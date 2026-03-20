import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import '../../../data/local/isar_service.dart';
import '../../../data/local/entities/dose_log_entity.dart';
import '../../../data/local/entities/medicine_entity.dart';
import '../../../data/local/entities/measurement_entity.dart';

// --- МОДЕЛИ ДАННЫХ ДЛЯ UI ---

class AnalyticsStats {
  final double adherenceRate;
  final int takenDoses;
  final int missedDoses;
  final int activeCourses;

  AnalyticsStats({
    required this.adherenceRate,
    required this.takenDoses,
    required this.missedDoses,
    required this.activeCourses,
  });
}

class DailyCorrelation {
  final DateTime date;
  final double adherencePct; // 0-100%
  final double? measurementValue; // Значение пульса, веса и т.д.

  DailyCorrelation({
    required this.date,
    required this.adherencePct,
    this.measurementValue,
  });
}

// 🚀 НОВОЕ: Обертка, чтобы UI вообще не делал математику
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

// --- СТЕЙТ ВЫБРАННОЙ МЕТРИКИ ---
final selectedChartMetricProvider = StateProvider<MeasurementTypeEnum>((ref) => MeasurementTypeEnum.bloodPressure);

// --- ПРОВАЙДЕР ДЛЯ ОБЩЕЙ СТАТИСТИКИ ---
final analyticsStatsProvider = FutureProvider.autoDispose<AnalyticsStats>((ref) async {
  final isarService = ref.read(localDbProvider);
  final isar = await isarService.db;

  final now = DateTime.now();
  final startOf7Days = DateTime(now.year, now.month, now.day).subtract(const Duration(days: 6));

  final logs = await isar.doseLogEntitys
      .filter()
      .scheduledTimeBetween(startOf7Days, now)
      .not().statusEqualTo(DoseStatusEnum.pending)
      .findAll();

  int taken = 0;
  int missed = 0;

  for (var log in logs) {
    if (log.status == DoseStatusEnum.taken) taken++;
    if (log.status == DoseStatusEnum.skipped) missed++;
  }

  final total = taken + missed;
  final rate = total > 0 ? (taken / total) * 100 : 0.0;

  final activeCourses = await isar.medicineEntitys.filter().isPausedEqualTo(false).count();

  return AnalyticsStats(
    adherenceRate: rate,
    takenDoses: taken,
    missedDoses: missed,
    activeCourses: activeCourses,
  );
});

// --- ПРОВАЙДЕР ГРАФИКА КОРРЕЛЯЦИИ ---
final correlationChartProvider = FutureProvider.autoDispose<CorrelationSummary>((ref) async {
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
    final finishedLogs = logs.where((l) => l.status != DoseStatusEnum.pending).toList();
    if (finishedLogs.isNotEmpty) {
      final taken = finishedLogs.where((l) => l.status == DoseStatusEnum.taken).length;
      adherence = (taken / finishedLogs.length) * 100;
    }

    final measurements = await isar.measurementEntitys
        .filter()
        .typeEqualTo(metricType)
        .timestampBetween(startOfDay, endOfDay)
        .findAll();

    double? avgValue;
    if (measurements.isNotEmpty) {
      final sum = measurements.fold(0.0, (prev, m) => prev + m.value1);
      avgValue = sum / measurements.length;

      // Считаем метрики для итоговой сводки
      totalMeasurement += avgValue;
      measurementDaysCount++;
      if (avgValue > maxMetricValue) maxMetricValue = avgValue;
    }

    totalAdherence += adherence;

    result.add(DailyCorrelation(
      date: startOfDay,
      adherencePct: adherence,
      measurementValue: avgValue,
    ));
  }

  return CorrelationSummary(
    dailyData: result,
    avgAdherence: result.isEmpty ? 0.0 : (totalAdherence / result.length),
    avgMeasurement: measurementDaysCount > 0 ? (totalMeasurement / measurementDaysCount) : null,
    maxMeasurement: maxMetricValue > 0 ? maxMetricValue : 100.0, // Защита от деления на 0 в UI
  );
});