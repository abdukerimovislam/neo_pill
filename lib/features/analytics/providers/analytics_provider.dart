import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

import '../../../data/local/entities/dose_log_entity.dart';
import '../../../data/local/entities/medicine_entity.dart';
import '../../../data/local/entities/measurement_entity.dart';
import '../../../data/local/isar_service.dart';

class AnalyticsStats {
  final double adherenceRate;
  final int takenDoses;
  final int missedDoses;
  final int activeCourses;
  final int currentStreak;
  final int longestStreak;
  final double onTimeRate;
  final double averageDelayMinutes;
  final int lowStockCourses;

  AnalyticsStats({
    required this.adherenceRate,
    required this.takenDoses,
    required this.missedDoses,
    required this.activeCourses,
    required this.currentStreak,
    required this.longestStreak,
    required this.onTimeRate,
    required this.averageDelayMinutes,
    required this.lowStockCourses,
  });
}

class DailyCorrelation {
  final DateTime date;
  final double adherencePct;
  final double? measurementValue;

  DailyCorrelation({
    required this.date,
    required this.adherencePct,
    this.measurementValue,
  });
}

class CorrelationSummary {
  final List<DailyCorrelation> dailyData;
  final double avgAdherence;
  final double? avgMeasurement;
  final double maxMeasurement;

  CorrelationSummary({
    required this.dailyData,
    required this.avgAdherence,
    this.avgMeasurement,
    required this.maxMeasurement,
  });
}

class _StreakData {
  final int current;
  final int longest;

  const _StreakData({required this.current, required this.longest});
}

final selectedChartMetricProvider = StateProvider<MeasurementTypeEnum>(
  (ref) => MeasurementTypeEnum.bloodPressure,
);

final analyticsStatsProvider = FutureProvider.autoDispose<AnalyticsStats>((
  ref,
) async {
  final isarService = ref.read(localDbProvider);
  final isar = await isarService.db;

  final now = DateTime.now();
  final startOf7Days = DateTime(
    now.year,
    now.month,
    now.day,
  ).subtract(const Duration(days: 6));

  final logs = await isar.doseLogEntitys
      .filter()
      .scheduledTimeBetween(startOf7Days, now)
      .not()
      .statusEqualTo(DoseStatusEnum.pending)
      .findAll();

  int taken = 0;
  int missed = 0;

  for (var log in logs) {
    if (log.status == DoseStatusEnum.taken) taken++;
    if (log.status == DoseStatusEnum.skipped) missed++;
  }

  final total = taken + missed;
  final rate = total > 0 ? (taken / total) * 100 : 0.0;

  final activeCourses = await isar.medicineEntitys
      .filter()
      .isPausedEqualTo(false)
      .count();
  final allMedicines = await isar.medicineEntitys.where().findAll();
  final lowStockCourses = allMedicines
      .where(
        (medicine) => medicine.pillsRemaining <= medicine.refillAlertThreshold,
      )
      .length;

  final takenLogs = logs
      .where(
        (log) => log.status == DoseStatusEnum.taken && log.actualTime != null,
      )
      .toList();
  final onTimeCount = takenLogs.where((log) {
    final delay = log.actualTime!.difference(log.scheduledTime).inMinutes;
    return delay.abs() <= 30;
  }).length;
  final totalDelayMinutes = takenLogs.fold<double>(0, (sum, log) {
    return sum + log.actualTime!.difference(log.scheduledTime).inMinutes.abs();
  });
  final onTimeRate = takenLogs.isEmpty
      ? 0.0
      : (onTimeCount / takenLogs.length) * 100;
  final averageDelayMinutes = takenLogs.isEmpty
      ? 0.0
      : totalDelayMinutes / takenLogs.length;
  final streakData = await _calculateStreakData(isar, now);

  return AnalyticsStats(
    adherenceRate: rate,
    takenDoses: taken,
    missedDoses: missed,
    activeCourses: activeCourses,
    currentStreak: streakData.current,
    longestStreak: streakData.longest,
    onTimeRate: onTimeRate,
    averageDelayMinutes: averageDelayMinutes,
    lowStockCourses: lowStockCourses,
  );
});

final correlationChartProvider = FutureProvider.autoDispose<CorrelationSummary>(
  (ref) async {
    final isarService = ref.read(localDbProvider);
    final isar = await isarService.db;
    final metricType = ref.watch(selectedChartMetricProvider);

    final today = DateTime.now();
    final List<DailyCorrelation> result = [];

    double totalAdherence = 0;
    double totalMeasurement = 0;
    int measurementDaysCount = 0;
    double maxMetricValue = 0;

    for (int i = 6; i >= 0; i--) {
      final date = today.subtract(Duration(days: i));
      final startOfDay = DateTime(date.year, date.month, date.day);
      final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59);

      final logs = await isar.doseLogEntitys
          .filter()
          .scheduledTimeBetween(startOfDay, endOfDay)
          .findAll();

      double adherence = 0.0;
      final finishedLogs = logs
          .where((l) => l.status != DoseStatusEnum.pending)
          .toList();
      if (finishedLogs.isNotEmpty) {
        final taken = finishedLogs
            .where((l) => l.status == DoseStatusEnum.taken)
            .length;
        adherence = (taken / finishedLogs.length) * 100;
      }

      final measurements = await isar.measurementEntitys
          .filter()
          .typeEqualTo(metricType)
          .timestampBetween(startOfDay, endOfDay)
          .findAll();

      double? avgValue;
      if (measurements.isNotEmpty) {
        final sum = measurements.fold(0.0, (prev, item) => prev + item.value1);
        avgValue = sum / measurements.length;
        totalMeasurement += avgValue;
        measurementDaysCount++;
        if (avgValue > maxMetricValue) {
          maxMetricValue = avgValue;
        }
      }

      totalAdherence += adherence;

      result.add(
        DailyCorrelation(
          date: startOfDay,
          adherencePct: adherence,
          measurementValue: avgValue,
        ),
      );
    }

    return CorrelationSummary(
      dailyData: result,
      avgAdherence: result.isEmpty ? 0.0 : totalAdherence / result.length,
      avgMeasurement: measurementDaysCount > 0
          ? totalMeasurement / measurementDaysCount
          : null,
      maxMeasurement: maxMetricValue > 0 ? maxMetricValue : 100.0,
    );
  },
);

Future<_StreakData> _calculateStreakData(Isar isar, DateTime now) async {
  int current = 0;
  int longest = 0;
  int running = 0;
  bool currentLocked = false;

  for (int dayOffset = 0; dayOffset < 90; dayOffset++) {
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
      if (!currentLocked) {
        currentLocked = true;
      }
      running = 0;
      continue;
    }

    final allTaken = finishedLogs.every(
      (log) => log.status == DoseStatusEnum.taken,
    );
    if (allTaken) {
      running++;
      if (!currentLocked) {
        current = running;
      }
      if (running > longest) {
        longest = running;
      }
    } else {
      if (!currentLocked) {
        currentLocked = true;
      }
      running = 0;
    }
  }

  return _StreakData(current: current, longest: longest);
}
