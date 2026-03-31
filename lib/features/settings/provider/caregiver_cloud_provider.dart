import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/firebase/caregiver_cloud_repository.dart';
import '../../../core/firebase/firebase_messaging_service.dart';
import 'caregiver_delivery_provider.dart';
import 'settings_provider.dart';

const _caregiverCloudStateKey = 'settings.caregiver_cloud_state';

// 🔥 ДОБАВЛЕНО: Модель привязанного пациента (позволяет следить за несколькими)
class LinkedPatient {
  final String shareCode;
  final String patientName;

  const LinkedPatient({required this.shareCode, required this.patientName});

  Map<String, dynamic> toJson() => {
    'shareCode': shareCode,
    'patientName': patientName,
  };

  factory LinkedPatient.fromJson(Map<String, dynamic> json) {
    return LinkedPatient(
      shareCode: json['shareCode'] as String,
      patientName: json['patientName'] as String,
    );
  }
}

class CaregiverCloudState {
  final String? patientShareCode;
  final List<LinkedPatient> linkedPatients; // 🔥 Множество пациентов

  const CaregiverCloudState({
    this.patientShareCode,
    this.linkedPatients = const [],
  });

  factory CaregiverCloudState.initial() => const CaregiverCloudState();

  bool get hasPatientLink => patientShareCode != null;
  bool get hasCaregiverLink => linkedPatients.isNotEmpty;
  bool get isConnected => hasPatientLink || hasCaregiverLink;

  // Для обратной совместимости с UI (берем первого пациента, пока не сделаем Дашборд)
  String? get caregiverLinkedPatientName =>
      linkedPatients.isNotEmpty ? linkedPatients.first.patientName : null;

  Map<String, dynamic> toJson() => {
    'patientShareCode': patientShareCode,
    'linkedPatients': linkedPatients.map((p) => p.toJson()).toList(),
  };

  factory CaregiverCloudState.fromJson(Map<String, dynamic> json) {
    // Поддержка миграции старого стейта с одним пациентом
    List<LinkedPatient> patients = [];
    if (json.containsKey('linkedPatients')) {
      patients = (json['linkedPatients'] as List)
          .map((e) => LinkedPatient.fromJson(e as Map<String, dynamic>))
          .toList();
    } else if (json.containsKey('caregiverShareCode') &&
        json['caregiverShareCode'] != null) {
      patients.add(
        LinkedPatient(
          shareCode: json['caregiverShareCode'],
          patientName: json['caregiverLinkedPatientName'] ?? 'Unknown',
        ),
      );
    }

    return CaregiverCloudState(
      patientShareCode: json['patientShareCode'] as String?,
      linkedPatients: patients,
    );
  }

  CaregiverCloudState copyWith({
    String? patientShareCode,
    bool clearPatientShareCode = false,
    List<LinkedPatient>? linkedPatients,
  }) {
    return CaregiverCloudState(
      patientShareCode: clearPatientShareCode
          ? null
          : (patientShareCode ?? this.patientShareCode),
      linkedPatients: linkedPatients ?? this.linkedPatients,
    );
  }
}

final caregiverCloudProvider =
NotifierProvider<CaregiverCloudNotifier, CaregiverCloudState>(
  CaregiverCloudNotifier.new,
);

// 🚀 Вспомогательный провайдер для прослушивания 1 пациента
final _patientAlertsProvider = StreamProvider.family
    .autoDispose<List<CaregiverCloudAlert>, String>((ref, shareCode) {
  return ref.read(caregiverCloudRepositoryProvider).watchAlerts(shareCode);
});

// 🚀 Магический провайдер, который собирает алерты от ВСЕХ пациентов в одну ленту
final caregiverCloudAlertsProvider =
Provider.autoDispose<AsyncValue<List<CaregiverCloudAlert>>>((ref) {
  final state = ref.watch(caregiverCloudProvider);

  if (state.linkedPatients.isEmpty) {
    return const AsyncValue.data([]);
  }

  List<CaregiverCloudAlert> allAlerts = [];
  bool isLoading = false;
  bool hasError = false;

  for (final patient in state.linkedPatients) {
    final alertsAsync = ref.watch(_patientAlertsProvider(patient.shareCode));
    alertsAsync.when(
      data: (alerts) => allAlerts.addAll(alerts),
      loading: () => isLoading = true,
      error: (e, s) => hasError = true,
    );
  }

  if (isLoading && allAlerts.isEmpty) return const AsyncValue.loading();
  if (hasError && allAlerts.isEmpty) {
    return AsyncValue.error('Error loading alerts', StackTrace.current);
  }

  // Сортируем все алерты от самых новых к старым
  allAlerts.sort((a, b) => b.createdAt.compareTo(a.createdAt));
  return AsyncValue.data(allAlerts);
});

class CaregiverCloudNotifier extends Notifier<CaregiverCloudState> {
  @override
  CaregiverCloudState build() {
    final raw =
    ref.read(sharedPreferencesProvider).getString(_caregiverCloudStateKey);
    if (raw == null || raw.isEmpty) {
      return CaregiverCloudState.initial();
    }
    try {
      final decoded = jsonDecode(raw) as Map<String, dynamic>;
      return CaregiverCloudState.fromJson(decoded);
    } catch (_) {
      return CaregiverCloudState.initial();
    }
  }

  Future<void> activatePatientMode({
    required String patientName,
    required String shareCode,
    required CaregiverProfile? caregiver,
  }) async {
    final token = await ref.read(firebaseMessagingServiceProvider).getToken();
    await ref.read(caregiverCloudRepositoryProvider).upsertPatientNetwork(
      shareCode: shareCode,
      patientName: patientName,
      caregiver: caregiver,
      fcmToken: token,
    );

    state = state.copyWith(patientShareCode: shareCode);
    await _persist();
  }

  Future<bool> connectAsCaregiver({
    required String shareCode,
    required String deviceName,
  }) async {
    // Не подключаемся повторно, если уже есть в списке
    if (state.linkedPatients.any((p) => p.shareCode == shareCode)) {
      return true;
    }

    final token = await ref.read(firebaseMessagingServiceProvider).getToken();
    final record =
    await ref.read(caregiverCloudRepositoryProvider).connectAsCaregiver(
      shareCode: shareCode,
      deviceName: deviceName,
      fcmToken: token,
    );

    if (record == null) {
      return false; // Код не найден или попытка добавить себя
    }

    final newPatients = [
      ...state.linkedPatients,
      LinkedPatient(
        shareCode: record.shareCode,
        patientName: record.patientName,
      ),
    ];

    state = state.copyWith(linkedPatients: newPatients);
    await _persist();
    return true;
  }

  Future<void> disconnectPatientMode() async {
    final shareCode = state.patientShareCode;
    if (shareCode != null) {
      await ref
          .read(caregiverCloudRepositoryProvider)
          .clearCurrentMemberToken(shareCode);
    }
    state = state.copyWith(clearPatientShareCode: true);
    await _persist();
  }

  // Отключаемся от одного конкретного пациента
  Future<void> disconnectFromPatient(String shareCode) async {
    await ref
        .read(caregiverCloudRepositoryProvider)
        .removeCurrentMember(shareCode);

    final newPatients =
    state.linkedPatients.where((p) => p.shareCode != shareCode).toList();
    state = state.copyWith(linkedPatients: newPatients);
    await _persist();
  }

  // Отключаемся от ВСЕХ пациентов разом (используется при полном выходе)
  Future<void> disconnectAllCaregiverModes() async {
    for (final patient in state.linkedPatients) {
      await ref
          .read(caregiverCloudRepositoryProvider)
          .removeCurrentMember(patient.shareCode);
    }
    state = state.copyWith(linkedPatients: []);
    await _persist();
  }

  Future<void> disconnect() async {
    await disconnectPatientMode();
    await disconnectAllCaregiverModes();
    state = CaregiverCloudState.initial();
    await ref.read(sharedPreferencesProvider).remove(_caregiverCloudStateKey);
  }

  Future<void> mirrorQueuedAlert({
    required String patientName,
    required CaregiverDeliveryEvent event,
  }) async {
    final shareCode = state.patientShareCode;
    if (shareCode == null) {
      return;
    }

    await ref.read(caregiverCloudRepositoryProvider).enqueueAlert(
      shareCode: shareCode,
      alertId: event.id,
      patientName: patientName,
      message: event.message,
      itemCount: event.itemCount,
    );
  }

  Future<void> markAlertSeen({
    required String shareCode,
    required String alertId,
  }) async {
    await ref
        .read(caregiverCloudRepositoryProvider)
        .markAlertSeen(shareCode: shareCode, alertId: alertId);
  }

  Future<void> syncPushToken({
    required String displayName,
    required String? token,
  }) async {
    final repository = ref.read(caregiverCloudRepositoryProvider);

    if (state.patientShareCode != null) {
      await repository.updateCurrentMemberToken(
        shareCode: state.patientShareCode!,
        role: 'patient',
        displayName: displayName,
        fcmToken: token,
      );
    }

    for (final patient in state.linkedPatients) {
      await repository.updateCurrentMemberToken(
        shareCode: patient.shareCode,
        role: 'caregiver',
        displayName: displayName,
        fcmToken: token,
      );
    }
  }

  Future<void> _persist() async {
    await ref
        .read(sharedPreferencesProvider)
        .setString(_caregiverCloudStateKey, jsonEncode(state.toJson()));
  }
}