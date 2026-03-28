import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'entities/dose_log_entity.dart';
import 'entities/measurement_entity.dart';
import 'entities/medicine_entity.dart';

final localDbProvider = Provider<IsarService>((ref) {
  return IsarService();
});

class IsarService {
  late Future<Isar> db;

  IsarService() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      return Isar.open(
        [MedicineEntitySchema, DoseLogEntitySchema, MeasurementEntitySchema],
        directory: dir.path,
        inspector: kDebugMode,
      );
    }

    return Future.value(Isar.getInstance());
  }

  Future<void> saveMedicine(MedicineEntity medicine) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.medicineEntitys.putSync(medicine));
  }

  Future<List<MedicineEntity>> getAllMedicines() async {
    final isar = await db;
    return isar.medicineEntitys.where().findAll();
  }

  Future<void> saveDoseLog(DoseLogEntity log) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.doseLogEntitys.putSync(log));
  }

  Future<List<DoseLogEntity>> getLogsForDate(DateTime date) async {
    final isar = await db;
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59);

    return isar.doseLogEntitys
        .filter()
        .scheduledTimeBetween(startOfDay, endOfDay)
        .sortByScheduledTime()
        .findAll();
  }

  Future<void> saveMeasurement(MeasurementEntity measurement) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.measurementEntitys.put(measurement);
    });
  }

  Future<List<MeasurementEntity>> getMeasurementsByType(
    MeasurementTypeEnum type,
  ) async {
    final isar = await db;
    return isar.measurementEntitys
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
