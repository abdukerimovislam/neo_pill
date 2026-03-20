import 'package:isar/isar.dart';

part 'measurement_entity.g.dart';

enum MeasurementTypeEnum {
  bloodPressure, // Давление (120/80)
  heartRate, // Пульс (bpm)
  bloodSugar, // Сахар (ммоль/л или mg/dL)
  weight, // Вес (кг или фунты)
  temperature, // Температура (°C или °F)
  mood, // Настроение (от 1 до 5)
}

@collection
class MeasurementEntity {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String syncId;

  @enumerated
  late MeasurementTypeEnum type;

  // Главное значение
  // (Систолическое давление, Пульс, Вес, Сахар, Температура или оценка Настроения)
  late double value1;

  // Дополнительное значение
  // (Используется только для Диастолического давления, например "80")
  double? value2;

  // Единица измерения (мм рт. ст., уд/мин, кг, ммоль/л, °C)
  late String unit;

  @Index()
  late DateTime timestamp;

  // Заметки (например, "Измерил после пробежки" или "Кружится голова")
  String? notes;
}
