import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/theme/app_theme.dart';
import 'core/utils/notification_service.dart';
import 'core/utils/lifecycle_observer.dart';
import 'core/presentation/main_navigation_screen.dart';
import 'features/settings/provider/settings_provider.dart';
import 'l10n/app_localizations.dart';
// 🚀 ДОБАВЛЕН ИМПОРТ ПРОВАЙДЕРОВ НАСТРОЕК

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
    const ProviderScope(
      child: NeoPillApp(),
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
    // 🚀 СЛУШАЕМ СТЕЙТЫ ИЗ НАСТРОЕК
    final themeMode = ref.watch(themeModeProvider);
    final locale = ref.watch(localeProvider);

    return MaterialApp(
      onGenerateTitle: (context) => AppLocalizations.of(context)?.appTitle ?? 'NeoPill',
      debugShowCheckedModeBanner: false,

      // 🚀 ПОДКЛЮЧИЛИ ТЕМЫ И ЯЗЫК
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      locale: locale,

      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('ru', ''),
      ],

      home: const MainNavigationScreen(),
    );
  }
}