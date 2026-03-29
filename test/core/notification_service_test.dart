import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:neo_pill/core/utils/notification_service.dart';
import 'package:neo_pill/data/local/entities/medicine_entity.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MedicineEntity buildMedicine({
    required String name,
    required CourseKindEnum kind,
    required FoodInstructionEnum foodInstruction,
    String dosageUnit = 'mg',
    int pillsRemaining = 4,
  }) {
    return MedicineEntity()
      ..syncId = 'sync-$name'
      ..name = name
      ..dosage = 1
      ..dosageUnit = dosageUnit
      ..kind = kind
      ..form = MedicineFormEnum.pill
      ..frequency = FrequencyTypeEnum.daily
      ..foodInstruction = foodInstruction
      ..timesPerDay = 1
      ..startDate = DateTime(2026, 1, 1)
      ..pillsInPackage = 30
      ..pillsRemaining = pillsRemaining;
  }

  group('NotificationService', () {
    testWidgets('builds English medication reminder copy', (tester) async {
      tester.binding.platformDispatcher.localeTestValue = const Locale(
        'en',
        'US',
      );

      final medicine = buildMedicine(
        name: 'Aspirin',
        kind: CourseKindEnum.medication,
        foodInstruction: FoodInstructionEnum.beforeFood,
      );

      final title = NotificationService.buildSmartReminderTitle(
        medicine: medicine,
        scheduledTime: DateTime(2026, 3, 28, 8, 0),
      );
      final body = NotificationService.buildSmartReminderBody(
        medicine: medicine,
        scheduledTime: DateTime(2026, 3, 28, 8, 0),
        dosage: 2,
      );

      expect(title, 'Morning care: Aspirin');
      expect(body, contains('A calm reminder for your treatment plan.'));
      expect(body, contains('2 mg.'));
      expect(body, contains('Take before food.'));
    });

    testWidgets(
      'builds supplement-specific English reminder and low stock copy',
      (tester) async {
        tester.binding.platformDispatcher.localeTestValue = const Locale(
          'en',
          'US',
        );

        final medicine = buildMedicine(
          name: 'Magnesium',
          kind: CourseKindEnum.supplement,
          foodInstruction: FoodInstructionEnum.noMatter,
          dosageUnit: 'mg',
          pillsRemaining: 3,
        );

        final title = NotificationService.buildSmartReminderTitle(
          medicine: medicine,
          scheduledTime: DateTime(2026, 3, 28, 21, 0),
          snoozed: true,
        );
        final body = NotificationService.buildSmartReminderBody(
          medicine: medicine,
          scheduledTime: DateTime(2026, 3, 28, 21, 0),
          dosage: 1,
        );
        final lowStockTitle = NotificationService.buildLowStockTitle(medicine);
        final lowStockBody = NotificationService.buildLowStockBody(medicine);

        expect(title, 'Evening wellness reminder: Magnesium');
        expect(body, contains('A gentle check-in for your routine.'));
        expect(body, contains('1 mg.'));
        expect(
          body,
          contains('A calm evening routine helps you stay consistent.'),
        );
        expect(lowStockTitle, contains('Low Stock: Magnesium'));
        expect(lowStockBody, contains('Only 3 mg left.'));
      },
    );
  });
}
