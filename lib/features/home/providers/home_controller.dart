import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';
import '../../../data/local/isar_service.dart';
import '../../../data/local/entities/dose_log_entity.dart';
import '../../../data/local/entities/medicine_entity.dart';
import '../../../core/utils/notification_service.dart';
import '../../../l10n/app_localizations.dart';
import 'home_provider.dart';

final homeControllerProvider = Provider((ref) => HomeController(ref));

final asNeededMedicinesProvider = StreamProvider<List<MedicineEntity>>((
  ref,
) async* {
  final isarService = ref.read(localDbProvider);
  final isar = await isarService.db;
  yield* isar.medicineEntitys
      .filter()
      .frequencyEqualTo(FrequencyTypeEnum.asNeeded)
      .watch(fireImmediately: true);
});

class HomeController {
  final Ref ref;

  HomeController(this.ref);

  Future<void> updateDoseStatus(
    DoseLogEntity log,
    DoseStatusEnum newStatus,
  ) async {
    final isarService = ref.read(localDbProvider);
    final notificationService = ref.read(notificationServiceProvider);
    final isar = await isarService.db;
    final now = DateTime.now();

    if (newStatus != DoseStatusEnum.pending && log.scheduledTime.isAfter(now)) {
      debugPrint('Blocked attempt to modify future dose log');
      return;
    }

    log.status = newStatus;
    if (newStatus == DoseStatusEnum.taken) {
      log.actualTime = now;
    }

    await isar.writeTxn(() async {
      await isar.doseLogEntitys.put(log);

      if (newStatus == DoseStatusEnum.taken) {
        final medicine = await isar.medicineEntitys
            .where()
            .syncIdEqualTo(log.medicineSyncId)
            .findFirst();
        if (medicine != null && medicine.pillsRemaining > 0) {
          final oldStock = medicine.pillsRemaining;
          // 🚀 ИСПОЛЬЗУЕМ ИНДИВИДУАЛЬНУЮ ДОЗУ ЛОГА ДЛЯ СПИСАНИЯ СО СКЛАДА (ЕСЛИ ОНА > 0)
          final deduction = log.dosage > 0 ? log.dosage.ceil() : 1;
          medicine.pillsRemaining -= deduction;

          if (medicine.pillsRemaining < 0) medicine.pillsRemaining = 0;
          await isar.medicineEntitys.put(medicine);

          if (oldStock > medicine.refillAlertThreshold &&
              medicine.pillsRemaining <= medicine.refillAlertThreshold) {
            await notificationService.showImmediateNotification(
              id: medicine.id * 1000,
              title: '⚠️ Low Stock: ${medicine.name}',
              body:
                  'Only ${medicine.pillsRemaining} ${medicine.dosageUnit} left. Time to refill!',
            );
          }
        }
      }
    });
    ref.invalidate(dailyScheduleProvider);
    ref.invalidate(heroDoseProvider);
    ref.invalidate(homeDashboardProvider);
  }

  Future<void> undoDoseStatus(DoseLogEntity log) async {
    final isarService = ref.read(localDbProvider);
    final isar = await isarService.db;

    await isar.writeTxn(() async {
      final oldStatus = log.status;

      log.status = DoseStatusEnum.pending;
      log.actualTime = null;
      await isar.doseLogEntitys.put(log);

      if (oldStatus == DoseStatusEnum.taken) {
        final medicine = await isar.medicineEntitys
            .where()
            .syncIdEqualTo(log.medicineSyncId)
            .findFirst();

        if (medicine != null) {
          final deduction = log.dosage > 0 ? log.dosage.ceil() : 1;
          medicine.pillsRemaining += deduction;
          await isar.medicineEntitys.put(medicine);
        }
      }
    });
    ref.invalidate(dailyScheduleProvider);
    ref.invalidate(heroDoseProvider);
    ref.invalidate(homeDashboardProvider);
  }

  Future<void> takeAsNeededDose(
    MedicineEntity medicine,
    BuildContext context,
    AppLocalizations l10n,
  ) async {
    final isarService = ref.read(localDbProvider);
    final isar = await isarService.db;
    final now = DateTime.now();

    if (medicine.prnMaxDailyDoses != null) {
      final startOfDay = DateTime(now.year, now.month, now.day);
      final endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59);

      final todayLogsCount = await isar.doseLogEntitys
          .filter()
          .medicineSyncIdEqualTo(medicine.syncId)
          .statusEqualTo(DoseStatusEnum.taken)
          .scheduledTimeBetween(startOfDay, endOfDay)
          .count();

      if (todayLogsCount >= medicine.prnMaxDailyDoses!) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  const Icon(Icons.warning_amber_rounded, color: Colors.white),
                  const SizedBox(width: 8),
                  Expanded(child: Text(l10n.limitReachedAlert)),
                ],
              ),
              backgroundColor: Theme.of(context).colorScheme.error,
              duration: const Duration(seconds: 4),
            ),
          );
        }
        return;
      }
    }

    final log = DoseLogEntity()
      ..syncId = const Uuid().v4()
      ..medicineSyncId = medicine.syncId
      ..scheduledTime = now
      ..actualTime = now
      ..status = DoseStatusEnum.taken
      ..dosage = medicine.dosage; // 🚀 ПРИСВАИВАЕМ ДОЗУ

    await isar.writeTxn(() async {
      await isar.doseLogEntitys.put(log);

      if (medicine.pillsRemaining > 0) {
        final oldStock = medicine.pillsRemaining;
        final deduction = log.dosage > 0 ? log.dosage.ceil() : 1;
        medicine.pillsRemaining -= deduction;
        if (medicine.pillsRemaining < 0) medicine.pillsRemaining = 0;

        await isar.medicineEntitys.put(medicine);

        if (oldStock > medicine.refillAlertThreshold &&
            medicine.pillsRemaining <= medicine.refillAlertThreshold) {
          final notificationService = ref.read(notificationServiceProvider);
          await notificationService.showImmediateNotification(
            id: medicine.id * 1000,
            title: '⚠️ Low Stock: ${medicine.name}',
            body:
                'Only ${medicine.pillsRemaining} ${medicine.dosageUnit} left. Time to refill!',
          );
        }
      }
    });

    ref.invalidate(dailyScheduleProvider);
    ref.invalidate(heroDoseProvider);
    ref.invalidate(homeDashboardProvider);
  }

  Future<void> togglePauseMedicine(MedicineEntity medicine) async {
    final isarService = ref.read(localDbProvider);
    final notificationService = ref.read(notificationServiceProvider);
    final isar = await isarService.db;

    final newPausedState = !medicine.isPaused;

    await isar.writeTxn(() async {
      medicine.isPaused = newPausedState;
      await isar.medicineEntitys.put(medicine);
    });

    final logs = await isar.doseLogEntitys
        .filter()
        .medicineSyncIdEqualTo(medicine.syncId)
        .statusEqualTo(DoseStatusEnum.pending)
        .findAll();

    if (newPausedState) {
      if (logs.isNotEmpty) {
        if (medicine.frequency == FrequencyTypeEnum.daily) {
          final uniqueTimes = logs
              .map((l) => TimeOfDay.fromDateTime(l.scheduledTime))
              .toSet();
          for (var time in uniqueTimes) {
            final stableNotificationId =
                (medicine.id * 10000) + (time.hour * 100) + time.minute;
            await notificationService.cancelNotification(stableNotificationId);
          }
        } else {
          for (var log in logs) {
            final stableNotificationId =
                (medicine.id * 100000) +
                log.scheduledTime.day * 1000 +
                log.scheduledTime.hour * 100 +
                log.scheduledTime.minute;
            await notificationService.cancelNotification(stableNotificationId);
          }
        }
      }
    } else {
      if (medicine.frequency == FrequencyTypeEnum.daily) {
        final uniqueTimes = logs
            .map((l) => TimeOfDay.fromDateTime(l.scheduledTime))
            .toSet();
        for (var time in uniqueTimes) {
          final stableNotificationId =
              (medicine.id * 10000) + (time.hour * 100) + time.minute;
          await notificationService.scheduleDailyRepeatingNotification(
            id: stableNotificationId,
            title: medicine.notificationTitle ?? 'Medicine Reminder',
            body: medicine.notificationBody ?? 'Time to take your medicine',
            time: time,
            payload: NotificationPayload.daily(
              medicineSyncId: medicine.syncId,
              hour: time.hour,
              minute: time.minute,
            ),
          );
        }
      } else {
        final now = DateTime.now();
        for (var log in logs) {
          if (log.scheduledTime.isAfter(now) &&
              log.scheduledTime.difference(now).inDays < 30) {
            final stableNotificationId =
                (medicine.id * 100000) +
                log.scheduledTime.day * 1000 +
                log.scheduledTime.hour * 100 +
                log.scheduledTime.minute;
            await notificationService.scheduleExactNotification(
              id: stableNotificationId,
              title: medicine.notificationTitle ?? 'Medicine Reminder',
              body: medicine.notificationBody ?? 'Time to take your medicine',
              scheduledTime: log.scheduledTime,
              payload: NotificationPayload.log(log.syncId),
            );
          }
        }
      }
    }
    ref.invalidate(dailyScheduleProvider);
    ref.invalidate(heroDoseProvider);
    ref.invalidate(homeDashboardProvider);
  }

  Future<void> addMedicineAndGenerateSchedule({
    required String name,
    required double dosage,
    required String dosageUnit,
    required MedicineFormEnum form,
    required FrequencyTypeEnum frequency,
    required FoodInstructionEnum foodInstruction,
    required List<TimeOfDay> times,
    required int durationDays,
    required int pillsInPackage,
    List<int>? selectedWeekDays,
    int? intervalDays,
    int? cycleOnDays,
    int? cycleOffDays,
    List<TaperingStep>? taperingSteps, // 🚀 НОВОЕ: Шаги титрации
    String? pillImagePath,
    int? prnMaxDailyDoses,
    required String notificationTitle,
    required String notificationBody,
    required PillShapeEnum pillShape,
    required int pillColor,
  }) async {
    final isarService = ref.read(localDbProvider);
    final notificationService = ref.read(notificationServiceProvider);
    final isar = await isarService.db;

    final syncId = const Uuid().v4();
    final now = DateTime.now();

    final medicine = MedicineEntity()
      ..syncId = syncId
      ..name = name
      ..dosage = dosage
      ..dosageUnit = dosageUnit
      ..form = form
      ..frequency = frequency
      ..foodInstruction = foodInstruction
      ..selectedWeekDays = selectedWeekDays
      ..intervalDays = intervalDays
      ..cycleOnDays = cycleOnDays
      ..cycleOffDays = cycleOffDays
      ..taperingSteps =
          taperingSteps // 🚀 СОХРАНЯЕМ ШАГИ ТИТРАЦИИ
      ..timesPerDay = times.length
      ..startDate = now
      ..pillsInPackage = pillsInPackage
      ..pillsRemaining = pillsInPackage
      ..pillImagePath = pillImagePath
      ..prnMaxDailyDoses = prnMaxDailyDoses
      ..notificationTitle = notificationTitle
      ..notificationBody = notificationBody
      ..pillShape = pillShape
      ..pillColor = pillColor;

    final List<DoseLogEntity> logsToInsert = [];

    // 🚀 СМАРТ-ГЕНЕРАТОР РАСПИСАНИЯ
    if (frequency == FrequencyTypeEnum.tapering &&
        taperingSteps != null &&
        taperingSteps.isNotEmpty) {
      // 1. ЛОГИКА ДЛЯ ДИНАМИЧЕСКИХ ДОЗ (Tapering)
      int dayOffset = 0;

      for (var step in taperingSteps) {
        for (int d = 0; d < step.durationDays; d++) {
          final scheduledDate = now.add(Duration(days: dayOffset));

          for (var time in times) {
            final specificTime = DateTime(
              scheduledDate.year,
              scheduledDate.month,
              scheduledDate.day,
              time.hour,
              time.minute,
            );
            final log = DoseLogEntity()
              ..syncId = const Uuid().v4()
              ..medicineSyncId = syncId
              ..scheduledTime = specificTime
              ..status = DoseStatusEnum.pending
              ..dosage = step.dosage; // 🚀 УНИКАЛЬНАЯ ДОЗА ИЗ ШАГА

            logsToInsert.add(log);
          }
          dayOffset++;
        }
      }
    } else if (frequency != FrequencyTypeEnum.asNeeded) {
      // 2. СТАНДАРТНАЯ ЛОГИКА ДЛЯ ОБЫЧНЫХ КУРСОВ
      for (int day = 0; day < durationDays; day++) {
        final scheduledDate = now.add(Duration(days: day));
        bool shouldAddDose = false;

        switch (frequency) {
          case FrequencyTypeEnum.daily:
            shouldAddDose = true;
            break;
          case FrequencyTypeEnum.interval:
            if (intervalDays != null && day % intervalDays == 0) {
              shouldAddDose = true;
            }
            break;
          case FrequencyTypeEnum.specificDays:
            if (selectedWeekDays != null &&
                selectedWeekDays.contains(scheduledDate.weekday)) {
              shouldAddDose = true;
            }
            break;
          case FrequencyTypeEnum.cycle:
            if (cycleOnDays != null && cycleOffDays != null) {
              final cycleLength = cycleOnDays + cycleOffDays;
              if (day % cycleLength < cycleOnDays) {
                shouldAddDose = true;
              }
            }
            break;
          case FrequencyTypeEnum.asNeeded:
          case FrequencyTypeEnum.tapering:
            break;
        }

        if (shouldAddDose) {
          for (var time in times) {
            final specificTime = DateTime(
              scheduledDate.year,
              scheduledDate.month,
              scheduledDate.day,
              time.hour,
              time.minute,
            );
            final log = DoseLogEntity()
              ..syncId = const Uuid().v4()
              ..medicineSyncId = syncId
              ..scheduledTime = specificTime
              ..status = DoseStatusEnum.pending
              ..dosage = dosage; // 🚀 ОБЫЧНАЯ ДОЗА
            logsToInsert.add(log);
          }
        }
      }
    }

    int medicineLocalId = 0;
    await isar.writeTxn(() async {
      medicineLocalId = await isar.medicineEntitys.put(medicine);
      if (logsToInsert.isNotEmpty) {
        await isar.doseLogEntitys.putAll(logsToInsert);
      }
    });

    // Настройка уведомлений
    if (frequency == FrequencyTypeEnum.daily) {
      for (var time in times) {
        final stableNotificationId =
            (medicineLocalId * 10000) + (time.hour * 100) + time.minute;
        await notificationService.scheduleDailyRepeatingNotification(
          id: stableNotificationId,
          title: notificationTitle,
          body: notificationBody,
          time: time,
          payload: NotificationPayload.daily(
            medicineSyncId: syncId,
            hour: time.hour,
            minute: time.minute,
          ),
        );
      }
    } else if (frequency != FrequencyTypeEnum.asNeeded) {
      for (var log in logsToInsert) {
        final stableNotificationId =
            (medicineLocalId * 100000) +
            log.scheduledTime.day * 1000 +
            log.scheduledTime.hour * 100 +
            log.scheduledTime.minute;
        if (log.scheduledTime.difference(DateTime.now()).inDays < 30) {
          // 🚀 Если это титрация, показываем правильную дозу в пуше
          final customBody = frequency == FrequencyTypeEnum.tapering
              ? notificationBody.replaceAll(
                  dosage.toString(),
                  log.dosage.toString(),
                )
              : notificationBody;

          await notificationService.scheduleExactNotification(
            id: stableNotificationId,
            title: notificationTitle,
            body: customBody,
            scheduledTime: log.scheduledTime,
            payload: NotificationPayload.log(log.syncId),
          );
        }
      }
    }
    ref.invalidate(dailyScheduleProvider);
    ref.invalidate(heroDoseProvider);
    ref.invalidate(homeDashboardProvider);
  }

  Future<void> updateMedicineDetails({
    required MedicineEntity medicine,
    required String newName,
    required double newDosage,
    required String newDosageUnit,
    required MedicineFormEnum newForm,
    required FoodInstructionEnum newFoodInstruction,
    required int newPillsRemaining,
    String? newPillImagePath,
    required String newNotificationTitle,
    required String newNotificationBody,
    required PillShapeEnum newPillShape,
    required int newPillColor,
    List<TaperingStep>? newTaperingSteps, // 🚀 Опциональное обновление шагов
  }) async {
    final isarService = ref.read(localDbProvider);
    final notificationService = ref.read(notificationServiceProvider);
    final isar = await isarService.db;

    await isar.writeTxn(() async {
      medicine.name = newName;
      medicine.dosage = newDosage;
      medicine.dosageUnit = newDosageUnit;
      medicine.form = newForm;
      medicine.foodInstruction = newFoodInstruction;
      medicine.pillsRemaining = newPillsRemaining;

      if (newTaperingSteps != null) {
        medicine.taperingSteps = newTaperingSteps;
      }

      medicine.pillShape = newPillShape;
      medicine.pillColor = newPillColor;

      if (newPillImagePath != null) {
        medicine.pillImagePath = newPillImagePath;
      }

      medicine.notificationTitle = newNotificationTitle;
      medicine.notificationBody = newNotificationBody;

      await isar.medicineEntitys.put(medicine);
    });

    if (!medicine.isPaused &&
        medicine.frequency != FrequencyTypeEnum.asNeeded) {
      final logs = await isar.doseLogEntitys
          .filter()
          .medicineSyncIdEqualTo(medicine.syncId)
          .statusEqualTo(DoseStatusEnum.pending)
          .findAll();

      if (logs.isNotEmpty) {
        if (medicine.frequency == FrequencyTypeEnum.daily) {
          final uniqueTimes = logs
              .map((l) => TimeOfDay.fromDateTime(l.scheduledTime))
              .toSet();
          for (var time in uniqueTimes) {
            final stableNotificationId =
                (medicine.id * 10000) + (time.hour * 100) + time.minute;
            await notificationService.scheduleDailyRepeatingNotification(
              id: stableNotificationId,
              title: newNotificationTitle,
              body: newNotificationBody,
              time: time,
              payload: NotificationPayload.daily(
                medicineSyncId: medicine.syncId,
                hour: time.hour,
                minute: time.minute,
              ),
            );
          }
        } else {
          final now = DateTime.now();
          for (var log in logs) {
            if (log.scheduledTime.isAfter(now) &&
                log.scheduledTime.difference(now).inDays < 30) {
              final stableNotificationId =
                  (medicine.id * 100000) +
                  log.scheduledTime.day * 1000 +
                  log.scheduledTime.hour * 100 +
                  log.scheduledTime.minute;

              final customBody =
                  medicine.frequency == FrequencyTypeEnum.tapering
                  ? newNotificationBody.replaceAll(
                      newDosage.toString(),
                      log.dosage.toString(),
                    )
                  : newNotificationBody;

              await notificationService.scheduleExactNotification(
                id: stableNotificationId,
                title: newNotificationTitle,
                body: customBody,
                scheduledTime: log.scheduledTime,
                payload: NotificationPayload.log(log.syncId),
              );
            }
          }
        }
      }
    }
    ref.invalidate(dailyScheduleProvider);
    ref.invalidate(heroDoseProvider);
    ref.invalidate(homeDashboardProvider);
  }

  Future<void> deleteMedicine(MedicineEntity medicine) async {
    final isarService = ref.read(localDbProvider);
    final notificationService = ref.read(notificationServiceProvider);
    final isar = await isarService.db;

    final logs = await isar.doseLogEntitys
        .filter()
        .medicineSyncIdEqualTo(medicine.syncId)
        .findAll();
    final logIds = logs.map((e) => e.id).toList();

    if (logs.isNotEmpty) {
      if (medicine.frequency == FrequencyTypeEnum.daily) {
        final uniqueTimes = logs
            .map((l) => TimeOfDay.fromDateTime(l.scheduledTime))
            .toSet();
        for (var time in uniqueTimes) {
          final stableNotificationId =
              (medicine.id * 10000) + (time.hour * 100) + time.minute;
          await notificationService.cancelNotification(stableNotificationId);
        }
      } else {
        for (var log in logs) {
          final stableNotificationId =
              (medicine.id * 100000) +
              log.scheduledTime.day * 1000 +
              log.scheduledTime.hour * 100 +
              log.scheduledTime.minute;
          await notificationService.cancelNotification(stableNotificationId);
        }
      }
    }

    await isar.writeTxn(() async {
      await isar.doseLogEntitys.deleteAll(logIds);
      await isar.medicineEntitys.delete(medicine.id);
    });
    ref.invalidate(dailyScheduleProvider);
    ref.invalidate(heroDoseProvider);
    ref.invalidate(homeDashboardProvider);
  }
}
