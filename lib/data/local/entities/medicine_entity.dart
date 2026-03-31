import 'package:isar/isar.dart';

part 'medicine_entity.g.dart';

enum MedicineFormEnum {
  pill,
  capsule,
  liquid,
  injection,
  drops,
  ointment,
  spray,
  inhaler,
  patch,
  suppository,
}

enum FrequencyTypeEnum {
  daily,
  asNeeded, // По потребности (PRN)
  specificDays,
  interval,
  cycle,
  tapering, // 🚀 Динамическая дозировка / Сложный поэтапный курс
}

enum CourseKindEnum { medication, supplement }

enum FoodInstructionEnum { noMatter, beforeFood, withFood, afterFood }

enum PillShapeEnum {
  circle, // Круглая таблетка
  capsule, // Капсула (двухцветная)
  oval, // Овальная
  diamond, // Ромбовидная
  square, // Квадратная
}

// 🚀 ОБНОВЛЕНО: Класс, описывающий один шаг поэтапного курса
@embedded
class TaperingStep {
  int durationDays = 1; // Сколько дней длится этот шаг
  double dosage = 0.0; // Какая доза на этом шаге

  // 🚀 НОВОЕ: Список времени приема для этого этапа
  // Так как Isar не поддерживает TimeOfDay, храним время в формате "HH:mm" (например: "08:30", "20:00")
  List<String> timeStrings = [];
}

@collection
class MedicineEntity {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String syncId;

  late String name;
  late double dosage;
  late String dosageUnit;

  @enumerated
  late MedicineFormEnum form;

  @enumerated
  late FrequencyTypeEnum frequency;

  @enumerated
  CourseKindEnum kind = CourseKindEnum.medication;

  // --- ПОЛЯ ДЛЯ СЛОЖНЫХ РАСПИСАНИЙ ---
  List<int>? selectedWeekDays;
  int? intervalDays;
  int? cycleOnDays;
  int? cycleOffDays;

  // 🚀 ОБНОВЛЕНО: Список шагов для сложных курсов (tapering/titration)
  List<TaperingStep>? taperingSteps;

  late int timesPerDay;
  late DateTime startDate;
  DateTime? endDate;

  // 🚀 НОВОЕ: Сохраняем исходное время для обычных курсов.
  // Это нужно, чтобы если юзер нажмет "Пауза", а через месяц "Возобновить",
  // мы знали, на какое время заново создавать локальные уведомления и ScheduleEntity
  List<String>? regularTimeStrings;

  // --- УМНЫЙ СКЛАД И БЕЗОПАСНОСТЬ ---
  late int pillsInPackage;
  late int pillsRemaining;
  int refillAlertThreshold = 5;

  // Флаг паузы
  bool isPaused = false;

  // Сохраняем тексты пушей для возможности их восстановления после паузы
  String? notificationTitle;
  String? notificationBody;

  // ЗАЩИТА ОТ ПЕРЕДОЗИРОВКИ: Лимит таблеток в сутки для frequency == asNeeded
  int? prnMaxDailyDoses;

  // --- МЕДИАТЕКА И ВИЗУАЛ ---
  // Локальный путь к фотографии реальной таблетки
  String? pillImagePath;

  // ПОЛЯ ВИЗУАЛЬНОГО КОНСТРУКТОРА:
  @enumerated
  PillShapeEnum pillShape = PillShapeEnum.circle;

  int pillColor = 0xFF2196F3;

  // --- ИНСТРУКЦИИ И КОНТЕКСТ ---
  @enumerated
  FoodInstructionEnum foodInstruction = FoodInstructionEnum.noMatter;

  String? instructions;
  String? notes;
}