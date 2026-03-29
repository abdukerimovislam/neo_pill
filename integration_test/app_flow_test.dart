import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:neo_pill/core/presentation/main_navigation_screen.dart';
import 'package:neo_pill/features/onboarding/presentation/onboarding_screen.dart';
import 'package:neo_pill/features/settings/provider/settings_provider.dart';
import 'package:neo_pill/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  Future<void> pumpApp(
    WidgetTester tester, {
    required Map<String, Object> prefs,
  }) async {
    SharedPreferences.setMockInitialValues(prefs);
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
          home: (prefs['settings.onboarding_complete'] as bool? ?? false)
              ? const MainNavigationScreen()
              : const OnboardingScreen(),
        ),
      ),
    );

    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
  }

  testWidgets('user can complete onboarding and land on main navigation', (
    tester,
  ) async {
    await pumpApp(tester, prefs: {});

    expect(find.byType(OnboardingScreen), findsOneWidget);
    expect(find.text('Продолжить'), findsOneWidget);

    await tester.tap(find.text('Продолжить'));
    await tester.pumpAndSettle();

    expect(find.text('Как к вам обращаться?'), findsOneWidget);

    await tester.enterText(find.byType(TextField).first, 'Алексей');
    await tester.tap(find.text('Продолжить'));
    await tester.pumpAndSettle();

    expect(find.text('Все готово'), findsOneWidget);
    expect(find.text('Начать использовать NeoPill'), findsOneWidget);

    await tester.tap(find.text('Начать использовать NeoPill'));
    await tester.pumpAndSettle();

    expect(find.byType(MainNavigationScreen), findsOneWidget);
    expect(find.text('Расписание'), findsOneWidget);
  });

  testWidgets('user can open analytics and settings from main navigation', (
    tester,
  ) async {
    await pumpApp(
      tester,
      prefs: {
        'settings.onboarding_complete': true,
        'settings.locale': 'ru',
      },
    );

    expect(find.byType(MainNavigationScreen), findsOneWidget);
    expect(find.text('Расписание'), findsOneWidget);

    await tester.tap(find.text('Статистика'));
    await tester.pumpAndSettle();
    expect(find.text('Аналитика'), findsOneWidget);

    await tester.tap(find.text('Профиль'));
    await tester.pumpAndSettle();
    expect(find.text('Настройки'), findsOneWidget);
  });
}
