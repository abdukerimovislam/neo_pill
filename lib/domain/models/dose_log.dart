import 'package:uuid/uuid.dart';

enum DoseStatus { taken, skipped, snoozed, pending }

class DoseLog {
  final String id;
  final String medicineId;
  final DateTime scheduledTime;
  final DateTime? actualTime;
  final DoseStatus status;

  DoseLog({
    String? id,
    required this.medicineId,
    required this.scheduledTime,
    this.actualTime,
    required this.status,
  }) : id = id ?? const Uuid().v4();

  DoseLog copyWith({
    String? medicineId,
    DateTime? scheduledTime,
    DateTime? actualTime,
    DoseStatus? status,
  }) {
    return DoseLog(
      id: id,
      medicineId: medicineId ?? this.medicineId,
      scheduledTime: scheduledTime ?? this.scheduledTime,
      actualTime: actualTime ?? this.actualTime,
      status: status ?? this.status,
    );
  }
}
