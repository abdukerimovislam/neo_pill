import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import '../../../data/local/isar_service.dart';
import '../../../data/local/entities/dose_log_entity.dart';
import '../../../data/local/entities/medicine_entity.dart';

// Провайдер для хранения выбранной даты в календаре (по умолчанию - сегодня)
final selectedDateProvider = StateProvider<DateTime>((ref) {
  final now = DateTime.now();
  return DateTime(now.year, now.month, now.day);
});

// Класс-обертка для UI, объединяющий лог приема и данные о самом лекарстве
class DoseScheduleItem {
  final DoseLogEntity doseLog;
  final MedicineEntity? medicine; // null, если лекарство удалено, но лог остался

  DoseScheduleItem({required this.doseLog, this.medicine});
}

// Провайдер, который слушает selectedDateProvider и асинхронно тянет данные из Isar
final dailyScheduleProvider = FutureProvider.autoDispose<List<DoseScheduleItem>>((ref) async {
  final selectedDate = ref.watch(selectedDateProvider);
  final isarService = ref.watch(localDbProvider);

  // 1. Получаем все логи приемов на выбранный день
  final logs = await isarService.getLogsForDate(selectedDate);

  // 2. Подтягиваем информацию о лекарствах для каждого лога
  final db = await isarService.db;
  List<DoseScheduleItem> scheduleItems = [];

  for (var log in logs) {
    // Ищем лекарство по syncId (связь между таблицами)
    final medicine = await db.medicineEntitys.where().syncIdEqualTo(log.medicineSyncId).findFirst();
    scheduleItems.add(DoseScheduleItem(doseLog: log, medicine: medicine));
  }

  return scheduleItems;
});