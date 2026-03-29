import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:neo_pill/data/local/entities/dose_log_entity.dart';
import 'package:neo_pill/data/local/entities/medicine_entity.dart';
import 'package:neo_pill/features/medicine_management/presentation/medicine_detail_screen.dart';
import 'package:neo_pill/features/settings/provider/settings_provider.dart';
import 'package:neo_pill/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MedicineEntity buildMedicine({
    required String name,
    required CourseKindEnum kind,
    bool isPaused = false,
    int pillsRemaining = 12,
    int pillsInPackage = 30,
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
      ..pillsInPackage = pillsInPackage
      ..pillsRemaining = pillsRemaining
      ..isPaused = isPaused;
  }

  Future<void> pumpScreen(
    WidgetTester tester, {
    required MedicineEntity medicine,
    List<DoseLogEntity> history = const [],
    List<DoseLogEntity> schedulePreview = const [],
  }) async {
    SharedPreferences.setMockInitialValues({});
    final preferences = await SharedPreferences.getInstance();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(preferences),
          medicineHistoryProvider(
            medicine.syncId,
          ).overrideWith((ref) async => history),
          medicineSchedulePreviewProvider(
            medicine.syncId,
          ).overrideWith((ref) async => schedulePreview),
        ],
        child: MaterialApp(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('en'), Locale('ru')],
          locale: const Locale('ru'),
          home: MedicineDetailScreen(medicine: medicine),
        ),
      ),
    );

    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
  }

  testWidgets('shows generic stock labels and paused action state', (
    tester,
  ) async {
    final medicine = buildMedicine(
      name: 'Магний',
      kind: CourseKindEnum.supplement,
      isPaused: true,
    );

    await pumpScreen(tester, medicine: medicine);

    expect(find.text('12 / 30'), findsOneWidget);
    expect(find.text('Возобновить'), findsOneWidget);
    expect(find.text('БАД'), findsWidgets);
  });

  testWidgets('shows active pause action for running medication', (
    tester,
  ) async {
    final medicine = buildMedicine(
      name: 'Аспирин',
      kind: CourseKindEnum.medication,
      isPaused: false,
    );

    await pumpScreen(tester, medicine: medicine);

    expect(find.text('Пауза'), findsOneWidget);
    expect(find.text('Лекарство'), findsWidgets);
  });

  testWidgets('delete dialog includes course name and neutral confirmation', (
    tester,
  ) async {
    final medicine = buildMedicine(
      name: 'Магний',
      kind: CourseKindEnum.supplement,
    );

    await pumpScreen(tester, medicine: medicine);

    await tester.ensureVisible(find.text('Удалить курс'));
    await tester.pump();
    await tester.tap(find.text('Удалить курс'), warnIfMissed: false);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('Удалить курс: Магний'), findsOneWidget);
    expect(
      find.text(
        'Вы уверены, что хотите удалить этот курс и все его напоминания?',
      ),
      findsOneWidget,
    );
  });
}
