import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'entities/medicine_entity.dart';
import 'entities/dose_log_entity.dart';
import 'entities/measurement_entity.dart'; // 🚀 ДОБАВЛЕН ИМПОРТ НОВОЙ ТАБЛИЦЫ

// Провайдер для доступа к БД из любой точки приложения через Riverpod
final localDbProvider = Provider<IsarService>((ref) {
  return IsarService();
});

class IsarService {
  late Future<Isar> db;

  IsarService() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    // Проверка, не открыта ли уже база, чтобы избежать утечек памяти
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      return await Isar.open(
        [
          MedicineEntitySchema,
          DoseLogEntitySchema,
          MeasurementEntitySchema // 🚀 НОВАЯ ТАБЛИЦА ЗАРЕГИСТРИРОВАНА
        ],
        directory: dir.path,
        inspector: true, // Позволяет просматривать БД прямо в браузере при дебаге
      );
    }
    return Future.value(Isar.getInstance());
  }

  // --- МЕТОДЫ ДЛЯ ЛЕКАРСТВ ---

  Future<void> saveMedicine(MedicineEntity medicine) async {
    final isar = await db;
    // Используем синхронную транзакцию для скорости, так как запись одной сущности мгновенна
    isar.writeTxnSync<int>(() => isar.medicineEntitys.putSync(medicine));
  }

  Future<List<MedicineEntity>> getAllMedicines() async {
    final isar = await db;
    return await isar.medicineEntitys.where().findAll();
  }

  // --- МЕТОДЫ ДЛЯ ЛОГОВ ПРИЕМА ---

  Future<void> saveDoseLog(DoseLogEntity log) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.doseLogEntitys.putSync(log));
  }

  /// Получить расписание на конкретный день
  Future<List<DoseLogEntity>> getLogsForDate(DateTime date) async {
    final isar = await db;

    // Сбрасываем время до начала и конца дня для точной выборки
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59);

    return await isar.doseLogEntitys
        .filter() // Используем filter для работы с датами
        .scheduledTimeBetween(startOfDay, endOfDay)
        .sortByScheduledTime()
        .findAll();
  }

  // --- 🚀 МЕТОДЫ ДЛЯ ДНЕВНИКА ИЗМЕРЕНИЙ (НОВОЕ) ---

  Future<void> saveMeasurement(MeasurementEntity measurement) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.measurementEntitys.put(measurement);
    });
  }

  /// Получить историю конкретного замера (например, только Давление) от новых к старым
  Future<List<MeasurementEntity>> getMeasurementsByType(MeasurementTypeEnum type) async {
    final isar = await db;
    return await isar.measurementEntitys
        .filter()
        .typeEqualTo(type)
        .sortByTimestampDesc()
        .findAll();
  }

  Future<void> deleteMeasurement(Id id) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.measurementEntitys.delete(id);
    });
  }
}