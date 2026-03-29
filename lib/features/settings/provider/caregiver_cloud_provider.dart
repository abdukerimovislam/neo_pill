import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/firebase/caregiver_cloud_repository.dart';
import '../../../core/firebase/firebase_messaging_service.dart';
import 'caregiver_delivery_provider.dart';
import 'settings_provider.dart';

const _caregiverCloudStateKey = 'settings.caregiver_cloud_state';

class CaregiverCloudState {
  final String? patientShareCode;
  final String? caregiverShareCode;
  final String? caregiverLinkedPatientName;

  const CaregiverCloudState({
    this.patientShareCode,
    this.caregiverShareCode,
    this.caregiverLinkedPatientName,
  });

  factory CaregiverCloudState.initial() => const CaregiverCloudState();

  bool get hasPatientLink => patientShareCode != null;
  bool get hasCaregiverLink => caregiverShareCode != null;
  bool get isConnected => hasPatientLink || hasCaregiverLink;

  Map<String, dynamic> toJson() => {
    'patientShareCode': patientShareCode,
    'caregiverShareCode': caregiverShareCode,
    'caregiverLinkedPatientName': caregiverLinkedPatientName,
  };

  factory CaregiverCloudState.fromJson(Map<String, dynamic> json) {
    return CaregiverCloudState(
      patientShareCode: json['patientShareCode'] as String?,
      caregiverShareCode: json['caregiverShareCode'] as String?,
      caregiverLinkedPatientName: json['caregiverLinkedPatientName'] as String?,
    );
  }

  CaregiverCloudState copyWith({
    String? patientShareCode,
    bool clearPatientShareCode = false,
    String? caregiverShareCode,
    bool clearCaregiverShareCode = false,
    String? caregiverLinkedPatientName,
    bool clearCaregiverLinkedPatientName = false,
  }) {
    return CaregiverCloudState(
      patientShareCode: clearPatientShareCode
          ? null
          : (patientShareCode ?? this.patientShareCode),
      caregiverShareCode: clearCaregiverShareCode
          ? null
          : (caregiverShareCode ?? this.caregiverShareCode),
      caregiverLinkedPatientName: clearCaregiverLinkedPatientName
          ? null
          : (caregiverLinkedPatientName ?? this.caregiverLinkedPatientName),
    );
  }
}

final caregiverCloudProvider =
    NotifierProvider<CaregiverCloudNotifier, CaregiverCloudState>(
      CaregiverCloudNotifier.new,
    );

final caregiverCloudAlertsProvider =
    StreamProvider.autoDispose<List<CaregiverCloudAlert>>((ref) {
      final state = ref.watch(caregiverCloudProvider);
      final shareCode = state.caregiverShareCode;
      if (shareCode == null) {
        return const Stream<List<CaregiverCloudAlert>>.empty();
      }
      return ref.read(caregiverCloudRepositoryProvider).watchAlerts(shareCode);
    });

class CaregiverCloudNotifier extends Notifier<CaregiverCloudState> {
  @override
  CaregiverCloudState build() {
    final raw = ref
        .read(sharedPreferencesProvider)
        .getString(_caregiverCloudStateKey);
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
    await ref
        .read(caregiverCloudRepositoryProvider)
        .upsertPatientNetwork(
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
    final token = await ref.read(firebaseMessagingServiceProvider).getToken();
    final record = await ref
        .read(caregiverCloudRepositoryProvider)
        .connectAsCaregiver(
          shareCode: shareCode,
          deviceName: deviceName,
          fcmToken: token,
        );
    if (record == null) {
      return false;
    }

    state = state.copyWith(
      caregiverShareCode: record.shareCode,
      caregiverLinkedPatientName: record.patientName,
    );
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

  Future<void> disconnectCaregiverMode() async {
    final shareCode = state.caregiverShareCode;
    if (shareCode != null) {
      await ref.read(caregiverCloudRepositoryProvider).removeCurrentMember(
        shareCode,
      );
    }
    state = state.copyWith(
      clearCaregiverShareCode: true,
      clearCaregiverLinkedPatientName: true,
    );
    await _persist();
  }

  Future<void> disconnect() async {
    await disconnectPatientMode();
    await disconnectCaregiverMode();
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

    await ref
        .read(caregiverCloudRepositoryProvider)
        .enqueueAlert(
          shareCode: shareCode,
          alertId: event.id,
          patientName: patientName,
          message: event.message,
          itemCount: event.itemCount,
        );
  }

  Future<void> markAlertSeen(String alertId) async {
    final shareCode = state.caregiverShareCode;
    if (shareCode == null) {
      return;
    }
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

    if (state.caregiverShareCode != null) {
      await repository.updateCurrentMemberToken(
        shareCode: state.caregiverShareCode!,
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
