import 'package:isar/isar.dart';

part 'dose_log_entity.g.dart';

enum DoseStatusEnum { taken, skipped, snoozed, pending }

@collection
class DoseLogEntity {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String syncId;

  @Index()
  late String medicineSyncId; // Связь с конкретным лекарством по UUID

  @Index() // Индексируем время для быстрой выборки "расписание на сегодня"
  late DateTime scheduledTime;

  DateTime? actualTime;

  @enumerated
  late DoseStatusEnum status;

  // 🚀 НОВОЕ: Индивидуальная доза для этого конкретного приема!
  // Теперь в расписании на понедельник может лежать 2 таблетки, а в пятницу — 0.5.
  double dosage = 0.0;
}
