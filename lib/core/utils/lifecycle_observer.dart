import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import '../../data/local/entities/dose_log_entity.dart';
import '../../data/local/entities/medicine_entity.dart';
import '../../data/local/isar_service.dart';
import 'notification_service.dart';

class AppLifecycleObserver extends WidgetsBindingObserver {
  // ИСПРАВЛЕНИЕ ЗДЕСЬ: Меняем Ref на WidgetRef
  final WidgetRef ref;

  AppLifecycleObserver(this.ref);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed) {
      _syncNotifications();
    }
  }

  Future<void> _syncNotifications() async {
    // Теперь WidgetRef отлично работает с методом read()
    final isarService = ref.read(localDbProvider);
    final notificationService = ref.read(notificationServiceProvider);
    final isar = await isarService.db;
    final now = DateTime.now();

    final medicines = await isar.medicineEntitys.where().findAll();

    for (var med in medicines) {
      final lastLog = await isar.doseLogEntitys
          .where()
          .medicineSyncIdEqualTo(med.syncId)
          .sortByScheduledTimeDesc()
          .findFirst();

      if (lastLog != null && lastLog.scheduledTime.isBefore(now)) {
        final stableNotificationId = (med.id * 100) + lastLog.scheduledTime.hour;
        await notificationService.cancelNotification(stableNotificationId);
      }
    }
  }
}