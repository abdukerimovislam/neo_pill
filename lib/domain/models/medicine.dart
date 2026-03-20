import 'package:uuid/uuid.dart';

enum MedicineForm { pill, capsule, liquid, injection, drops, ointment }

enum FrequencyType { daily, asNeeded, specificDays }

class Medicine {
  final String id;
  final String name;
  final double dosage;
  final String dosageUnit; // mg, ml, drops
  final MedicineForm form;
  final FrequencyType frequency;
  final int timesPerDay;
  final DateTime startDate;
  final DateTime? endDate;
  final int pillsInPackage;
  final int pillsRemaining;
  final String? instructions; // e.g., "After meal"
  final String? notes;

  Medicine({
    String? id,
    required this.name,
    required this.dosage,
    this.dosageUnit = 'mg',
    required this.form,
    required this.frequency,
    required this.timesPerDay,
    required this.startDate,
    this.endDate,
    required this.pillsInPackage,
    required this.pillsRemaining,
    this.instructions,
    this.notes,
  }) : id = id ?? const Uuid().v4();

  // Метод для копирования объекта с изменением части полей (нужно для изменения стейта)
  Medicine copyWith({
    String? name,
    double? dosage,
    String? dosageUnit,
    MedicineForm? form,
    FrequencyType? frequency,
    int? timesPerDay,
    DateTime? startDate,
    DateTime? endDate,
    int? pillsInPackage,
    int? pillsRemaining,
    String? instructions,
    String? notes,
  }) {
    return Medicine(
      id: id,
      name: name ?? this.name,
      dosage: dosage ?? this.dosage,
      dosageUnit: dosageUnit ?? this.dosageUnit,
      form: form ?? this.form,
      frequency: frequency ?? this.frequency,
      timesPerDay: timesPerDay ?? this.timesPerDay,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      pillsInPackage: pillsInPackage ?? this.pillsInPackage,
      pillsRemaining: pillsRemaining ?? this.pillsRemaining,
      instructions: instructions ?? this.instructions,
      notes: notes ?? this.notes,
    );
  }
}
