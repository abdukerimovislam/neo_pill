import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import 'settings_provider.dart';

const _caregiverShareCodeKey = 'settings.caregiver_share_code';
const _caregiverAlertOutboxKey = 'settings.caregiver_alert_outbox';

final caregiverDeliveryProvider =
    NotifierProvider<CaregiverDeliveryNotifier, CaregiverDeliveryState>(
      CaregiverDeliveryNotifier.new,
    );

class CaregiverDeliveryEvent {
  final String id;
  final String caregiverName;
  final String message;
  final int itemCount;
  final DateTime createdAt;

  const CaregiverDeliveryEvent({
    required this.id,
    required this.caregiverName,
    required this.message,
    required this.itemCount,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'caregiverName': caregiverName,
    'message': message,
    'itemCount': itemCount,
    'createdAt': createdAt.toIso8601String(),
  };

  factory CaregiverDeliveryEvent.fromJson(Map<String, dynamic> json) {
    return CaregiverDeliveryEvent(
      id: json['id'] as String? ?? const Uuid().v4(),
      caregiverName: json['caregiverName'] as String? ?? '',
      message: json['message'] as String? ?? '',
      itemCount: json['itemCount'] as int? ?? 0,
      createdAt:
          DateTime.tryParse(json['createdAt'] as String? ?? '') ??
          DateTime.now(),
    );
  }
}

class CaregiverDeliveryState {
  final String shareCode;
  final List<CaregiverDeliveryEvent> outbox;

  const CaregiverDeliveryState({required this.shareCode, required this.outbox});

  DateTime? get lastQueuedAt => outbox.isEmpty ? null : outbox.first.createdAt;

  int get pendingCount => outbox.length;

  CaregiverDeliveryState copyWith({
    String? shareCode,
    List<CaregiverDeliveryEvent>? outbox,
  }) {
    return CaregiverDeliveryState(
      shareCode: shareCode ?? this.shareCode,
      outbox: outbox ?? this.outbox,
    );
  }
}

class CaregiverDeliveryNotifier extends Notifier<CaregiverDeliveryState> {
  @override
  CaregiverDeliveryState build() {
    final prefs = ref.read(sharedPreferencesProvider);
    final savedCode = prefs.getString(_caregiverShareCodeKey);
    final shareCode = savedCode ?? _generateShareCode();

    if (savedCode == null) {
      prefs.setString(_caregiverShareCodeKey, shareCode);
    }

    final rawOutbox = prefs.getString(_caregiverAlertOutboxKey);
    if (rawOutbox == null || rawOutbox.isEmpty) {
      return CaregiverDeliveryState(shareCode: shareCode, outbox: const []);
    }

    try {
      final decoded = jsonDecode(rawOutbox) as List<dynamic>;
      final outbox =
          decoded
              .map(
                (item) => CaregiverDeliveryEvent.fromJson(
                  item as Map<String, dynamic>,
                ),
              )
              .toList()
            ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
      return CaregiverDeliveryState(shareCode: shareCode, outbox: outbox);
    } catch (_) {
      return CaregiverDeliveryState(shareCode: shareCode, outbox: const []);
    }
  }

  Future<CaregiverDeliveryEvent?> queueAlert({
    required String caregiverName,
    required String message,
    required int itemCount,
  }) async {
    final now = DateTime.now();
    final recentDuplicate = state.outbox.any(
      (event) =>
          event.message == message &&
          now.difference(event.createdAt).inMinutes < 5,
    );
    if (recentDuplicate) {
      return null;
    }

    final event = CaregiverDeliveryEvent(
      id: const Uuid().v4(),
      caregiverName: caregiverName,
      message: message,
      itemCount: itemCount,
      createdAt: now,
    );

    final updated = [event, ...state.outbox].take(25).toList();

    state = state.copyWith(outbox: updated);
    await _persist();
    return event;
  }

  Future<void> clearOutbox() async {
    state = state.copyWith(outbox: const []);
    await ref.read(sharedPreferencesProvider).remove(_caregiverAlertOutboxKey);
  }

  Future<void> _persist() async {
    await ref
        .read(sharedPreferencesProvider)
        .setString(
          _caregiverAlertOutboxKey,
          jsonEncode(state.outbox.map((event) => event.toJson()).toList()),
        );
  }

  String _generateShareCode() {
    final raw = const Uuid().v4().replaceAll('-', '').toUpperCase();
    return 'NP-${raw.substring(0, 4)}-${raw.substring(4, 8)}';
  }
}
