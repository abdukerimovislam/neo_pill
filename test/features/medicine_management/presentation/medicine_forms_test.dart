import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:neo_pill/data/local/entities/medicine_entity.dart';
import 'package:neo_pill/features/medicine_management/presentation/add_medicine_screen.dart';
import 'package:neo_pill/features/medicine_management/presentation/edit_medicine_screen.dart';
import 'package:neo_pill/features/settings/provider/settings_provider.dart';
import 'package:neo_pill/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Future<void> pumpLocalizedScreen(WidgetTester tester, Widget child) async {
    SharedPreferences.setMockInitialValues({});
    final preferences = await SharedPreferences.getInstance();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [sharedPreferencesProvider.overrideWithValue(preferences)],
        child: MaterialApp(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('en'), Locale('ru')],
          locale: const Locale('ru'),
          home: child,
        ),
      ),
    );

    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
  }

  MedicineEntity buildMedicine({
    required String name,
    required CourseKindEnum kind,
  }) {
    return MedicineEntity()
      ..id = 1
      ..syncId = 'sync-$name'
      ..name = name
      ..dosage = 1
      ..dosageUnit = 'mg'
      ..kind = kind
      ..form = MedicineFormEnum.pill
      ..frequency = FrequencyTypeEnum.daily
      ..foodInstruction = FoodInstructionEnum.noMatter
      ..timesPerDay = 1
      ..startDate = DateTime(2026, 1, 1)
      ..pillsInPackage = 30
      ..pillsRemaining = 20;
  }

  testWidgets('add medication screen shows medication-specific copy', (
    tester,
  ) async {
    await pumpLocalizedScreen(
      tester,
      const AddMedicineScreen(initialKind: CourseKindEnum.medication),
    );

    expect(find.text('Добавить лекарство'), findsOneWidget);
    expect(find.text('Название (например, Витамин Д)'), findsOneWidget);
    expect(find.text('Основное'), findsOneWidget);
  });

  testWidgets('add supplement screen shows supplement-specific copy', (
    tester,
  ) async {
    await pumpLocalizedScreen(
      tester,
      const AddMedicineScreen(initialKind: CourseKindEnum.supplement),
    );

    expect(find.text('Добавить БАД'), findsOneWidget);
    expect(find.text('Название БАДа (например, Магний)'), findsOneWidget);
    expect(find.text('Основное'), findsOneWidget);
  });

  testWidgets(
    'edit supplement screen shows supplement-specific title and hint',
    (tester) async {
      await pumpLocalizedScreen(
        tester,
        EditMedicineScreen(
          medicine: buildMedicine(
            name: 'Магний',
            kind: CourseKindEnum.supplement,
          ),
        ),
      );

      expect(find.text('Редактировать БАД'), findsOneWidget);
      expect(find.text('Название БАДа (например, Магний)'), findsOneWidget);
    },
  );

  testWidgets(
    'edit medication screen shows generic course title and medication hint',
    (tester) async {
      await pumpLocalizedScreen(
        tester,
        EditMedicineScreen(
          medicine: buildMedicine(
            name: 'Аспирин',
            kind: CourseKindEnum.medication,
          ),
        ),
      );

      expect(find.text('Изменить курс'), findsOneWidget);
      expect(find.text('Название (например, Витамин Д)'), findsOneWidget);
    },
  );
}
