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
  tapering, // 🚀 НОВОЕ: Динамическая дозировка (Титрация)
}

enum CourseKindEnum { medication, supplement }

enum FoodInstructionEnum { noMatter, beforeFood, withFood, afterFood }

// Перечисление для формы таблетки в визуальном конструкторе
enum PillShapeEnum {
  circle, // Круглая таблетка
  capsule, // Капсула (двухцветная)
  oval, // Овальная
  diamond, // Ромбовидная
  square, // Квадратная
}

// 🚀 НОВОЕ: Класс, описывающий один шаг титрации
@embedded
class TaperingStep {
  int durationDays = 1; // Сколько дней длится этот шаг
  double dosage = 0.0; // Какая доза на этом шаге
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

  // 🚀 НОВОЕ: Список шагов для сложных курсов (tapering)
  List<TaperingStep>? taperingSteps;

  late int timesPerDay;
  late DateTime startDate;
  DateTime? endDate;

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
