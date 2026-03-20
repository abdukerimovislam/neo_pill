import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

import '../../../data/local/entities/dose_log_entity.dart';
import '../../../data/local/entities/medicine_entity.dart';
import '../../../data/local/isar_service.dart';

final selectedDateProvider = StateProvider<DateTime>((ref) {
  final now = DateTime.now();
  return DateTime(now.year, now.month, now.day);
});

class DoseScheduleItem {
  final DoseLogEntity doseLog;
  final MedicineEntity? medicine;

  DoseScheduleItem({required this.doseLog, required this.medicine});
}

class HomeDashboardSummary {
  final int totalDoses;
  final int takenDoses;
  final int skippedDoses;
  final int pendingDoses;
  final int overdueDoses;
  final int activeMedicines;
  final int lowStockMedicines;
  final double todayProgress;
  final double weeklyAdherence;
  final int currentStreak;
  final DoseScheduleItem? nextPendingDose;
  final List<String> insightMessages;

  const HomeDashboardSummary({
    required this.totalDoses,
    required this.takenDoses,
    required this.skippedDoses,
    required this.pendingDoses,
    required this.overdueDoses,
    required this.activeMedicines,
    required this.lowStockMedicines,
    required this.todayProgress,
    required this.weeklyAdherence,
    required this.currentStreak,
    required this.nextPendingDose,
    required this.insightMessages,
  });
}

final dailyScheduleProvider =
    FutureProvider.autoDispose<List<DoseScheduleItem>>((ref) async {
      final isarService = ref.read(localDbProvider);
      final isar = await isarService.db;
      final selectedDate = ref.watch(selectedDateProvider);

      final logs = await isarService.getLogsForDate(selectedDate);

      final medicineIds = logs
          .map((log) => log.medicineSyncId)
          .toSet()
          .toList();
      final medicines = medicineIds.isEmpty
          ? <MedicineEntity>[]
          : await isar.medicineEntitys
                .filter()
                .anyOf(medicineIds, (q, String id) => q.syncIdEqualTo(id))
                .findAll();

      final medicineMap = {
        for (var medicine in medicines) medicine.syncId: medicine,
      };

      return logs
          .map(
            (log) => DoseScheduleItem(
              doseLog: log,
              medicine: medicineMap[log.medicineSyncId],
            ),
          )
          .toList();
    });

final homeDashboardProvider = FutureProvider.autoDispose<HomeDashboardSummary>((
  ref,
) async {
  final isarService = ref.read(localDbProvider);
  final isar = await isarService.db;
  final selectedDate = ref.watch(selectedDateProvider);
  final logs = await isarService.getLogsForDate(selectedDate);

  final medicineIds = logs.map((log) => log.medicineSyncId).toSet().toList();
  final medicines = medicineIds.isEmpty
      ? <MedicineEntity>[]
      : await isar.medicineEntitys
            .filter()
            .anyOf(medicineIds, (q, String id) => q.syncIdEqualTo(id))
            .findAll();
  final medicineMap = {
    for (final medicine in medicines) medicine.syncId: medicine,
  };

  final items = logs
      .map(
        (log) => DoseScheduleItem(
          doseLog: log,
          medicine: medicineMap[log.medicineSyncId],
        ),
      )
      .toList();

  final now = DateTime.now();
  final selectedDay = DateTime(
    selectedDate.year,
    selectedDate.month,
    selectedDate.day,
  );
  final todayDay = DateTime(now.year, now.month, now.day);
  final isTodaySelected = selectedDay.isAtSameMomentAs(todayDay);
  final totalDoses = items.length;
  final takenDoses = items
      .where((item) => item.doseLog.status == DoseStatusEnum.taken)
      .length;
  final skippedDoses = items
      .where((item) => item.doseLog.status == DoseStatusEnum.skipped)
      .length;
  final pendingDoses = items
      .where((item) => item.doseLog.status == DoseStatusEnum.pending)
      .length;
  final overdueDoses = isTodaySelected
      ? items.where((item) {
          return item.doseLog.status == DoseStatusEnum.pending &&
              item.doseLog.scheduledTime.isBefore(now);
        }).length
      : 0;

  final todayProgress = totalDoses > 0 ? takenDoses / totalDoses : 0.0;

  final allMedicines = await isar.medicineEntitys.where().findAll();
  final activeMedicines = allMedicines
      .where((medicine) => !medicine.isPaused)
      .length;
  final lowStockMedicines = allMedicines
      .where(
        (medicine) => medicine.pillsRemaining <= medicine.refillAlertThreshold,
      )
      .length;

  final startOfToday = DateTime(now.year, now.month, now.day);
  final nextPendingDose = isTodaySelected
      ? items
            .where((item) => item.doseLog.status == DoseStatusEnum.pending)
            .where((item) => item.doseLog.scheduledTime.isAfter(now))
            .cast<DoseScheduleItem?>()
            .fold<DoseScheduleItem?>(null, (previous, item) {
              if (item == null) return previous;
              if (previous == null) return item;
              return item.doseLog.scheduledTime.isBefore(
                    previous.doseLog.scheduledTime,
                  )
                  ? item
                  : previous;
            })
      : null;

  final weeklyLogs = await isar.doseLogEntitys
      .filter()
      .scheduledTimeBetween(startOfToday.subtract(const Duration(days: 6)), now)
      .findAll();
  final finishedWeeklyLogs = weeklyLogs
      .where((log) => log.status != DoseStatusEnum.pending)
      .toList();
  final weeklyTaken = finishedWeeklyLogs
      .where((log) => log.status == DoseStatusEnum.taken)
      .length;
  final weeklyAdherence = finishedWeeklyLogs.isEmpty
      ? 0.0
      : (weeklyTaken / finishedWeeklyLogs.length) * 100;

  final currentStreak = await _calculateCurrentStreak(isar, now);

  final insightMessages = <String>[
    if (overdueDoses > 0)
      '$overdueDoses dose${overdueDoses == 1 ? '' : 's'} need attention right now.',
    if (weeklyAdherence >= 85)
      'Excellent consistency this week. Your routine is holding up.',
    if (weeklyAdherence > 0 && weeklyAdherence < 85)
      'There is room to tighten the routine. Focus on the next due dose.',
    if (lowStockMedicines > 0)
      '$lowStockMedicines medication${lowStockMedicines == 1 ? '' : 's'} are close to refill level.',
    if (totalDoses == 0)
      'No doses are scheduled for this date. Use it as a recovery day.',
  ];

  return HomeDashboardSummary(
    totalDoses: totalDoses,
    takenDoses: takenDoses,
    skippedDoses: skippedDoses,
    pendingDoses: pendingDoses,
    overdueDoses: overdueDoses,
    activeMedicines: activeMedicines,
    lowStockMedicines: lowStockMedicines,
    todayProgress: todayProgress,
    weeklyAdherence: weeklyAdherence,
    currentStreak: currentStreak,
    nextPendingDose: nextPendingDose,
    insightMessages: insightMessages.take(3).toList(),
  );
});

final heroDoseProvider = FutureProvider.autoDispose<DoseScheduleItem?>((
  ref,
) async {
  final isarService = ref.read(localDbProvider);
  final isar = await isarService.db;

  final selectedDate = ref.watch(selectedDateProvider);
  final now = DateTime.now();
  final pureSelected = DateTime(
    selectedDate.year,
    selectedDate.month,
    selectedDate.day,
  );
  final pureToday = DateTime(now.year, now.month, now.day);

  if (!pureSelected.isAtSameMomentAs(pureToday)) return null;

  final startOfDay = DateTime(now.year, now.month, now.day);
  final logs = await isar.doseLogEntitys
      .filter()
      .scheduledTimeBetween(startOfDay, now.add(const Duration(minutes: 30)))
      .statusEqualTo(DoseStatusEnum.pending)
      .sortByScheduledTime()
      .findAll();

  if (logs.isEmpty) return null;

  final heroLog = logs.first;
  final medicine = await isar.medicineEntitys
      .filter()
      .syncIdEqualTo(heroLog.medicineSyncId)
      .findFirst();

  return DoseScheduleItem(doseLog: heroLog, medicine: medicine);
});

Future<int> _calculateCurrentStreak(Isar isar, DateTime now) async {
  int streak = 0;

  for (int dayOffset = 0; dayOffset < 60; dayOffset++) {
    final date = DateTime(
      now.year,
      now.month,
      now.day,
    ).subtract(Duration(days: dayOffset));
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59);

    final logs = await isar.doseLogEntitys
        .filter()
        .scheduledTimeBetween(startOfDay, endOfDay)
        .findAll();

    if (logs.isEmpty) {
      continue;
    }

    final finishedLogs = logs
        .where((log) => log.status != DoseStatusEnum.pending)
        .toList();
    if (finishedLogs.isEmpty) {
      if (dayOffset == 0) {
        continue;
      }
      break;
    }

    final allTaken = finishedLogs.every(
      (log) => log.status == DoseStatusEnum.taken,
    );
    if (!allTaken) {
      break;
    }

    streak++;
  }

  return streak;
}
