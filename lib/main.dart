import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // 🚀 НОВЫЙ ИМПОРТ ДЛЯ СИСТЕМНЫХ НАСТРОЕК
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/theme/app_theme.dart';
import 'core/utils/notification_service.dart';
import 'core/utils/lifecycle_observer.dart';
import 'core/presentation/main_navigation_screen.dart';
import 'l10n/app_localizations.dart';

void main() async {
  // Обязательная строка перед выполнением нативного кода
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Фиксируем ориентацию экрана только вертикально
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // 2. Делаем системный статус-бар прозрачным для красивых градиентов
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  // 3. Безопасная инициализация уведомлений
  try {
    final notificationService = NotificationService();
    await notificationService.init();
    await notificationService.requestPermissions();
  } catch (e) {
    debugPrint('Crucial error during notification init: $e');
    // В релизе мы не крашим аппку, если пуши не завелись,
    // даем пользователю зайти и посмотреть свои таблетки
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
    return MaterialApp(
      onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
      debugShowCheckedModeBanner: false, // 🚀 Убрали плашку DEBUG
      theme: AppTheme.lightTheme,

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