import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'dart:math';
import '../../../data/local/isar_service.dart';
import '../../../data/local/entities/dose_log_entity.dart';
import '../../../data/local/entities/medicine_entity.dart';
import '../../../data/local/entities/measurement_entity.dart';

// --- СТАРЫЙ ПРОВАЙДЕР ДЛЯ ОБЩЕЙ СТАТИСТИКИ ---
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

final analyticsStatsProvider = FutureProvider.autoDispose<AnalyticsStats>((ref) async {
  final isarService = ref.read(localDbProvider);
  final isar = await isarService.db;

  final now = DateTime.now();
  final startOfMonth = DateTime(now.year, now.month, 1);

  final logs = await isar.doseLogEntitys
      .filter()
      .scheduledTimeBetween(startOfMonth, now)
  // 🚀 ИСПРАВЛЕНИЕ: Используем оператор .not() перед .statusEqualTo
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

// --- 🚀 НОВЫЕ ПРОВАЙДЕРЫ ДЛЯ ГРАФИКОВ КОРРЕЛЯЦИИ ---

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

// Стейт для переключателя типа графика на экране
final selectedChartMetricProvider = StateProvider<MeasurementTypeEnum>((ref) => MeasurementTypeEnum.bloodPressure);

final correlationChartProvider = FutureProvider.autoDispose<List<DailyCorrelation>>((ref) async {
  final isarService = ref.read(localDbProvider);
  final isar = await isarService.db;
  final metricType = ref.watch(selectedChartMetricProvider);

  final today = DateTime.now();
  final List<DailyCorrelation> result = [];

  // Идем по последним 7 дням (включая сегодня)
  for (int i = 6; i >= 0; i--) {
    final date = today.subtract(Duration(days: i));
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59);

    // 1. Считаем adherence (приверженность) за этот день
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

    // 2. Считаем среднее значение замера за этот день
    final measurements = await isar.measurementEntitys
        .filter()
        .typeEqualTo(metricType)
        .timestampBetween(startOfDay, endOfDay)
        .findAll();

    double? avgValue;
    if (measurements.isNotEmpty) {
      final sum = measurements.fold(0.0, (prev, m) => prev + m.value1);
      avgValue = sum / measurements.length;
    }

    result.add(DailyCorrelation(
      date: startOfDay,
      adherencePct: adherence,
      measurementValue: avgValue,
    ));
  }

  return result;
});