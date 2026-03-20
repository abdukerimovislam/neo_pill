import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/local/isar_service.dart';
import '../../../data/local/entities/dose_log_entity.dart';
import '../../../data/local/entities/medicine_entity.dart';
import 'package:isar/isar.dart';

final selectedDateProvider = StateProvider<DateTime>((ref) {
  final now = DateTime.now();
  return DateTime(now.year, now.month, now.day);
});

class DoseScheduleItem {
  final DoseLogEntity doseLog;
  final MedicineEntity? medicine;

  DoseScheduleItem({required this.doseLog, required this.medicine});
}

// Провайдер для ОБЫЧНОГО списка таблеток (все на этот день)
final dailyScheduleProvider = FutureProvider.autoDispose<List<DoseScheduleItem>>((ref) async {
  final isarService = ref.read(localDbProvider);
  final isar = await isarService.db;
  final selectedDate = ref.watch(selectedDateProvider);

  final logs = await isarService.getLogsForDate(selectedDate);

  final medicineIds = logs.map((log) => log.medicineSyncId).toSet().toList();
  final medicines = await isar.medicineEntitys.filter().anyOf(medicineIds, (q, String id) => q.syncIdEqualTo(id)).findAll();

  final medicineMap = {for (var m in medicines) m.syncId: m};

  return logs.map((log) => DoseScheduleItem(doseLog: log, medicine: medicineMap[log.medicineSyncId])).toList();
});

// 🚀 НОВОЕ: Провайдер для HERO-БЛОКА ("К приему сейчас")
final heroDoseProvider = FutureProvider.autoDispose<DoseScheduleItem?>((ref) async {
  final isarService = ref.read(localDbProvider);
  final isar = await isarService.db;

  // Герой имеет смысл только для СЕГОДНЯШНЕГО дня
  final selectedDate = ref.watch(selectedDateProvider);
  final now = DateTime.now();
  final pureSelected = DateTime(selectedDate.year, selectedDate.month, selectedDate.day);
  final pureToday = DateTime(now.year, now.month, now.day);

  if (!pureSelected.isAtSameMomentAs(pureToday)) return null;

  // Ищем все пропущенные или ожидающие таблетки за сегодня
  final startOfDay = DateTime(now.year, now.month, now.day);
  final logs = await isar.doseLogEntitys
      .filter()
      .scheduledTimeBetween(startOfDay, now.add(const Duration(minutes: 30))) // Берем те, что уже просрочены, или будут в ближайшие 30 минут
      .statusEqualTo(DoseStatusEnum.pending)
      .sortByScheduledTime()
      .findAll();

  if (logs.isEmpty) return null;

  // Берем самую первую невыпитую таблетку
  final heroLog = logs.first;
  final medicine = await isar.medicineEntitys.filter().syncIdEqualTo(heroLog.medicineSyncId).findFirst();

  return DoseScheduleItem(doseLog: heroLog, medicine: medicine);
});