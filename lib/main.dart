import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/presentation/main_navigation_screen.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/lifecycle_observer.dart';
import 'core/utils/notification_service.dart';
import 'features/onboarding/presentation/onboarding_screen.dart';
import 'features/settings/provider/settings_provider.dart';
import 'l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final preferences = await SharedPreferences.getInstance();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  try {
    final notificationService = NotificationService();
    await notificationService.init();
    await notificationService.requestPermissions();
  } catch (e) {
    debugPrint('Crucial error during notification init: $e');
  }

  runApp(
    ProviderScope(
      overrides: [sharedPreferencesProvider.overrideWithValue(preferences)],
      child: const NeoPillApp(),
    ),
  );
}

class NeoPillApp extends ConsumerStatefulWidget {
  const NeoPillApp({super.key});

  @override
  ConsumerState<NeoPillApp> createState() => _NeoPillAppState();
}

class _NeoPillAppState extends ConsumerState<NeoPillApp> {
  late AppLifecycleObserver _observer;

  @override
  void initState() {
    super.initState();
    _observer = AppLifecycleObserver(ref);
    WidgetsBinding.instance.addObserver(_observer);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(_observer);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeModeProvider);
    final locale = ref.watch(localeProvider);
    final comfortMode = ref.watch(comfortModeProvider);
    final onboardingComplete = ref.watch(onboardingCompleteProvider);

    return MaterialApp(
      onGenerateTitle: (context) =>
          AppLocalizations.of(context)?.appTitle ?? 'NeoPill',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme(comfortMode: comfortMode),
      darkTheme: AppTheme.darkTheme(comfortMode: comfortMode),
      themeMode: themeMode,
      locale: locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en', ''), Locale('ru', '')],
      home: onboardingComplete
          ? const MainNavigationScreen()
          : const OnboardingScreen(),
    );
  }
}
