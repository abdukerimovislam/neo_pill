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

class TimedDoseInput {
  final TimeOfDay time;
  final double dosage;

  const TimedDoseInput({required this.time, required this.dosage});
}

class HomeController {
  final Ref ref;

  HomeController(this.ref);

  String _smartReminderTitle({
    required MedicineEntity medicine,
    required DateTime scheduledTime,
  }) {
    return NotificationService.buildSmartReminderTitle(
      medicine: medicine,
      scheduledTime: scheduledTime,
    );
  }

  String _smartReminderBody({
    required MedicineEntity medicine,
    required DateTime scheduledTime,
    required double dosage,
  }) {
    return NotificationService.buildSmartReminderBody(
      medicine: medicine,
      scheduledTime: scheduledTime,
      dosage: dosage,
    );
  }

  Map<TimeOfDay, double> _mapDailyDosagesFromLogs(List<DoseLogEntity> logs) {
    final sortedLogs = [...logs]
      ..sort((a, b) => a.scheduledTime.compareTo(b.scheduledTime));
    final mapped = <TimeOfDay, double>{};

    for (final log in sortedLogs) {
      final time = TimeOfDay.fromDateTime(log.scheduledTime);
      mapped.putIfAbsent(time, () => log.dosage);
    }

    return mapped;
  }

  Future<void> _cancelNotificationsForLogs({
    required NotificationService notificationService,
    required MedicineEntity medicine,
    required List<DoseLogEntity> logs,
  }) async {
    if (logs.isEmpty) return;

    if (medicine.frequency == FrequencyTypeEnum.daily) {
      final uniqueTimes = logs
          .map((log) => TimeOfDay.fromDateTime(log.scheduledTime))
          .toSet();
      for (final time in uniqueTimes) {
        final stableNotificationId =
            (medicine.id * 10000) + (time.hour * 100) + time.minute;
        await notificationService.cancelNotification(stableNotificationId);
      }
      return;
    }

    for (final log in logs) {
      final stableNotificationId =
          (medicine.id * 100000) +
          log.scheduledTime.day * 1000 +
          log.scheduledTime.hour * 100 +
          log.scheduledTime.minute;
      await notificationService.cancelNotification(stableNotificationId);
    }
  }

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
          // ðŸš€ Ð˜Ð¡ÐŸÐžÐ›Ð¬Ð—Ð£Ð•Ðœ Ð˜ÐÐ”Ð˜Ð’Ð˜Ð”Ð£ÐÐ›Ð¬ÐÐ£Ð® Ð”ÐžÐ—Ð£ Ð›ÐžÐ“Ð Ð”Ð›Ð¯ Ð¡ÐŸÐ˜Ð¡ÐÐÐ˜Ð¯ Ð¡Ðž Ð¡ÐšÐ›ÐÐ”Ð (Ð•Ð¡Ð›Ð˜ ÐžÐÐ > 0)
          final deduction = log.dosage > 0 ? log.dosage.ceil() : 1;
          medicine.pillsRemaining -= deduction;

          if (medicine.pillsRemaining < 0) medicine.pillsRemaining = 0;
          await isar.medicineEntitys.put(medicine);

          if (oldStock > medicine.refillAlertThreshold &&
              medicine.pillsRemaining <= medicine.refillAlertThreshold) {
            await notificationService.showImmediateNotification(
              id: medicine.id * 1000,
              title: NotificationService.buildLowStockTitle(medicine),
              body: NotificationService.buildLowStockBody(medicine),
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
      ..dosage = medicine.dosage; // ðŸš€ ÐŸÐ Ð˜Ð¡Ð’ÐÐ˜Ð’ÐÐ•Ðœ Ð”ÐžÐ—Ð£

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
            title: NotificationService.buildLowStockTitle(medicine),
            body: NotificationService.buildLowStockBody(medicine),
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
          final dailyDosages = _mapDailyDosagesFromLogs(logs);
          for (final time in dailyDosages.keys) {
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
        final now = DateTime.now();
        final dailyDosages = _mapDailyDosagesFromLogs(logs);
        for (final entry in dailyDosages.entries) {
          final time = entry.key;
          final stableNotificationId =
              (medicine.id * 10000) + (time.hour * 100) + time.minute;
          await notificationService.scheduleDailyRepeatingNotification(
            id: stableNotificationId,
            title: _smartReminderTitle(
              medicine: medicine,
              scheduledTime: DateTime(
                now.year,
                now.month,
                now.day,
                time.hour,
                time.minute,
              ),
            ),
            body: _smartReminderBody(
              medicine: medicine,
              scheduledTime: DateTime(
                now.year,
                now.month,
                now.day,
                time.hour,
                time.minute,
              ),
              dosage: entry.value,
            ),
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
              title: _smartReminderTitle(
                medicine: medicine,
                scheduledTime: log.scheduledTime,
              ),
              body: _smartReminderBody(
                medicine: medicine,
                scheduledTime: log.scheduledTime,
                dosage: log.dosage > 0 ? log.dosage : medicine.dosage,
              ),
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
    required CourseKindEnum kind,
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
    List<TaperingStep>?
    taperingSteps, // ðŸš€ ÐÐžÐ’ÐžÐ•: Ð¨Ð°Ð³Ð¸ Ñ‚Ð¸Ñ‚Ñ€Ð°Ñ†Ð¸Ð¸
    List<TimedDoseInput>? customDailyDoses,
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
      ..kind = kind
      ..form = form
      ..frequency = frequency
      ..foodInstruction = foodInstruction
      ..selectedWeekDays = selectedWeekDays
      ..intervalDays = intervalDays
      ..cycleOnDays = cycleOnDays
      ..cycleOffDays = cycleOffDays
      ..taperingSteps =
          taperingSteps // ðŸš€ Ð¡ÐžÐ¥Ð ÐÐÐ¯Ð•Ðœ Ð¨ÐÐ“Ð˜ Ð¢Ð˜Ð¢Ð ÐÐ¦Ð˜Ð˜
      ..timesPerDay = customDailyDoses?.length ?? times.length
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

    // ðŸš€ Ð¡ÐœÐÐ Ð¢-Ð“Ð•ÐÐ•Ð ÐÐ¢ÐžÐ  Ð ÐÐ¡ÐŸÐ˜Ð¡ÐÐÐ˜Ð¯
    if (frequency == FrequencyTypeEnum.tapering &&
        taperingSteps != null &&
        taperingSteps.isNotEmpty) {
      // 1. Ð›ÐžÐ“Ð˜ÐšÐ Ð”Ð›Ð¯ Ð”Ð˜ÐÐÐœÐ˜Ð§Ð•Ð¡ÐšÐ˜Ð¥ Ð”ÐžÐ— (Tapering)
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
              ..dosage = step
                  .dosage; // ðŸš€ Ð£ÐÐ˜ÐšÐÐ›Ð¬ÐÐÐ¯ Ð”ÐžÐ—Ð Ð˜Ð— Ð¨ÐÐ“Ð

            logsToInsert.add(log);
          }
          dayOffset++;
        }
      }
    } else if (frequency != FrequencyTypeEnum.asNeeded) {
      // 2. Ð¡Ð¢ÐÐÐ”ÐÐ Ð¢ÐÐÐ¯ Ð›ÐžÐ“Ð˜ÐšÐ Ð”Ð›Ð¯ ÐžÐ‘Ð«Ð§ÐÐ«Ð¥ ÐšÐ£Ð Ð¡ÐžÐ’
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
          final doseMoments =
              customDailyDoses ??
              times
                  .map((time) => TimedDoseInput(time: time, dosage: dosage))
                  .toList();

          for (final doseMoment in doseMoments) {
            final specificTime = DateTime(
              scheduledDate.year,
              scheduledDate.month,
              scheduledDate.day,
              doseMoment.time.hour,
              doseMoment.time.minute,
            );
            final log = DoseLogEntity()
              ..syncId = const Uuid().v4()
              ..medicineSyncId = syncId
              ..scheduledTime = specificTime
              ..status = DoseStatusEnum.pending
              ..dosage = doseMoment.dosage;
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

    // ÐÐ°ÑÑ‚Ñ€Ð¾Ð¹ÐºÐ° ÑƒÐ²ÐµÐ´Ð¾Ð¼Ð»ÐµÐ½Ð¸Ð¹
    if (frequency == FrequencyTypeEnum.daily) {
      final dailyDoseMoments =
          customDailyDoses ??
          times
              .map((time) => TimedDoseInput(time: time, dosage: dosage))
              .toList();

      for (final doseMoment in dailyDoseMoments) {
        final stableNotificationId =
            (medicineLocalId * 10000) +
            (doseMoment.time.hour * 100) +
            doseMoment.time.minute;
        await notificationService.scheduleDailyRepeatingNotification(
          id: stableNotificationId,
          title: _smartReminderTitle(
            medicine: medicine,
            scheduledTime: DateTime(
              now.year,
              now.month,
              now.day,
              doseMoment.time.hour,
              doseMoment.time.minute,
            ),
          ),
          body: _smartReminderBody(
            medicine: medicine,
            scheduledTime: DateTime(
              now.year,
              now.month,
              now.day,
              doseMoment.time.hour,
              doseMoment.time.minute,
            ),
            dosage: doseMoment.dosage,
          ),
          time: doseMoment.time,
          payload: NotificationPayload.daily(
            medicineSyncId: syncId,
            hour: doseMoment.time.hour,
            minute: doseMoment.time.minute,
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
          // ðŸš€ Ð•ÑÐ»Ð¸ ÑÑ‚Ð¾ Ñ‚Ð¸Ñ‚Ñ€Ð°Ñ†Ð¸Ñ, Ð¿Ð¾ÐºÐ°Ð·Ñ‹Ð²Ð°ÐµÐ¼ Ð¿Ñ€Ð°Ð²Ð¸Ð»ÑŒÐ½ÑƒÑŽ Ð´Ð¾Ð·Ñƒ Ð² Ð¿ÑƒÑˆÐµ
          await notificationService.scheduleExactNotification(
            id: stableNotificationId,
            title: _smartReminderTitle(
              medicine: medicine,
              scheduledTime: log.scheduledTime,
            ),
            body: _smartReminderBody(
              medicine: medicine,
              scheduledTime: log.scheduledTime,
              dosage: log.dosage,
            ),
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
    required CourseKindEnum newKind,
    required MedicineFormEnum newForm,
    required FoodInstructionEnum newFoodInstruction,
    required int newPillsRemaining,
    String? newPillImagePath,
    required String newNotificationTitle,
    required String newNotificationBody,
    required PillShapeEnum newPillShape,
    required int newPillColor,
    List<TaperingStep>?
    newTaperingSteps, // ðŸš€ ÐžÐ¿Ñ†Ð¸Ð¾Ð½Ð°Ð»ÑŒÐ½Ð¾Ðµ Ð¾Ð±Ð½Ð¾Ð²Ð»ÐµÐ½Ð¸Ðµ ÑˆÐ°Ð³Ð¾Ð²
    List<TimedDoseInput>? updatedDoseSchedule,
  }) async {
    final isarService = ref.read(localDbProvider);
    final notificationService = ref.read(notificationServiceProvider);
    final isar = await isarService.db;
    final existingPendingLogs = await isar.doseLogEntitys
        .filter()
        .medicineSyncIdEqualTo(medicine.syncId)
        .statusEqualTo(DoseStatusEnum.pending)
        .findAll();
    final regeneratedLogs = <DoseLogEntity>[];

    await isar.writeTxn(() async {
      medicine.name = newName;
      medicine.dosage = newDosage;
      medicine.dosageUnit = newDosageUnit;
      medicine.kind = newKind;
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

      if (updatedDoseSchedule != null &&
          medicine.frequency != FrequencyTypeEnum.asNeeded &&
          medicine.frequency != FrequencyTypeEnum.tapering) {
        final pendingIds = existingPendingLogs.map((log) => log.id).toList();
        if (pendingIds.isNotEmpty) {
          await isar.doseLogEntitys.deleteAll(pendingIds);
        }

        final upcomingDates =
            existingPendingLogs
                .map(
                  (log) => DateTime(
                    log.scheduledTime.year,
                    log.scheduledTime.month,
                    log.scheduledTime.day,
                  ),
                )
                .toSet()
                .toList()
              ..sort((a, b) => a.compareTo(b));

        for (final date in upcomingDates) {
          for (final doseMoment in updatedDoseSchedule) {
            regeneratedLogs.add(
              DoseLogEntity()
                ..syncId = const Uuid().v4()
                ..medicineSyncId = medicine.syncId
                ..scheduledTime = DateTime(
                  date.year,
                  date.month,
                  date.day,
                  doseMoment.time.hour,
                  doseMoment.time.minute,
                )
                ..status = DoseStatusEnum.pending
                ..dosage = doseMoment.dosage,
            );
          }
        }

        if (regeneratedLogs.isNotEmpty) {
          await isar.doseLogEntitys.putAll(regeneratedLogs);
        }

        medicine.timesPerDay = updatedDoseSchedule.length;
        medicine.dosage = updatedDoseSchedule.first.dosage;
        await isar.medicineEntitys.put(medicine);
      }
    });

    if (!medicine.isPaused &&
        medicine.frequency != FrequencyTypeEnum.asNeeded) {
      await _cancelNotificationsForLogs(
        notificationService: notificationService,
        medicine: medicine,
        logs: existingPendingLogs,
      );

      final logs = updatedDoseSchedule != null
          ? regeneratedLogs
          : await isar.doseLogEntitys
                .filter()
                .medicineSyncIdEqualTo(medicine.syncId)
                .statusEqualTo(DoseStatusEnum.pending)
                .findAll();

      if (logs.isNotEmpty) {
        if (medicine.frequency == FrequencyTypeEnum.daily) {
          final now = DateTime.now();
          final dailyDosages = _mapDailyDosagesFromLogs(logs);
          for (final entry in dailyDosages.entries) {
            final time = entry.key;
            final stableNotificationId =
                (medicine.id * 10000) + (time.hour * 100) + time.minute;
            await notificationService.scheduleDailyRepeatingNotification(
              id: stableNotificationId,
              title: _smartReminderTitle(
                medicine: medicine,
                scheduledTime: DateTime(
                  now.year,
                  now.month,
                  now.day,
                  time.hour,
                  time.minute,
                ),
              ),
              body: _smartReminderBody(
                medicine: medicine,
                scheduledTime: DateTime(
                  now.year,
                  now.month,
                  now.day,
                  time.hour,
                  time.minute,
                ),
                dosage: entry.value,
              ),
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
                title: _smartReminderTitle(
                  medicine: medicine,
                  scheduledTime: log.scheduledTime,
                ),
                body: _smartReminderBody(
                  medicine: medicine,
                  scheduledTime: log.scheduledTime,
                  dosage: log.dosage,
                ),
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
