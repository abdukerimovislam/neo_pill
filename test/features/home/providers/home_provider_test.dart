import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:neo_pill/data/local/entities/dose_log_entity.dart';
import 'package:neo_pill/data/local/entities/medicine_entity.dart';
import 'package:neo_pill/features/home/providers/home_provider.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MedicineEntity buildMedicine(String syncId, CourseKindEnum kind) {
    return MedicineEntity()
      ..syncId = syncId
      ..name = syncId
      ..dosage = 1
      ..dosageUnit = 'mg'
      ..kind = kind
      ..form = MedicineFormEnum.pill
      ..frequency = FrequencyTypeEnum.daily
      ..foodInstruction = FoodInstructionEnum.noMatter
      ..timesPerDay = 1
      ..startDate = DateTime(2026, 1, 1)
      ..pillsInPackage = 30
      ..pillsRemaining = 30;
  }

  DoseScheduleItem buildItem({
    required String syncId,
    required DateTime time,
    required CourseKindEnum kind,
  }) {
    final medicine = buildMedicine(syncId, kind);
    final log = DoseLogEntity()
      ..syncId = 'log-$syncId-${time.hour}-${time.minute}'
      ..medicineSyncId = syncId
      ..scheduledTime = time
      ..status = DoseStatusEnum.pending
      ..dosage = 1;
    return DoseScheduleItem(doseLog: log, medicine: medicine);
  }

  group('buildRoutineBundles', () {
    testWidgets('groups nearby items into one English bundle', (tester) async {
      tester.binding.platformDispatcher.localeTestValue = const Locale(
        'en',
        'US',
      );

      final bundles = buildRoutineBundles([
        buildItem(
          syncId: 'aspirin',
          time: DateTime(2026, 3, 28, 8, 0),
          kind: CourseKindEnum.medication,
        ),
        buildItem(
          syncId: 'vitd',
          time: DateTime(2026, 3, 28, 8, 45),
          kind: CourseKindEnum.medication,
        ),
      ]);

      expect(bundles, hasLength(1));
      expect(bundles.first.label, 'Morning routine');
      expect(bundles.first.subtitle, contains('2 items'));
      expect(bundles.first.subtitle, contains('08:00-08:45'));
      expect(bundles.first.subtitle, contains('medications'));
    });

    testWidgets('splits distant items and marks mixed bundle type', (
      tester,
    ) async {
      tester.binding.platformDispatcher.localeTestValue = const Locale(
        'en',
        'US',
      );

      final bundles = buildRoutineBundles([
        buildItem(
          syncId: 'aspirin',
          time: DateTime(2026, 3, 28, 8, 0),
          kind: CourseKindEnum.medication,
        ),
        buildItem(
          syncId: 'magnesium',
          time: DateTime(2026, 3, 28, 9, 15),
          kind: CourseKindEnum.supplement,
        ),
        buildItem(
          syncId: 'evening',
          time: DateTime(2026, 3, 28, 12, 0),
          kind: CourseKindEnum.supplement,
        ),
      ]);

      expect(bundles, hasLength(2));
      expect(bundles.first.subtitle, contains('mixed'));
      expect(bundles[1].label, 'Afternoon routine');
      expect(bundles[1].subtitle, contains('1 item'));
      expect(bundles[1].subtitle, contains('supplements'));
    });
  });
}
