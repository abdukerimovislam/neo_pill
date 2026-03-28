import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/presentation/main_navigation_screen.dart';
import 'core/firebase/firebase_messaging_service.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/lifecycle_observer.dart';
import 'core/utils/notification_service.dart';
import 'features/onboarding/presentation/onboarding_screen.dart';
import 'features/settings/provider/caregiver_cloud_provider.dart';
import 'features/settings/provider/settings_provider.dart';
import 'firebase_options.dart';
import 'l10n/app_localizations.dart';

// --- ДОБАВЛЕННЫЙ ИМПОРТ НАШЕГО АНИМИРОВАННОГО СПЛЭША ---
import 'features/splash/presentation/animated_splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final preferences = await SharedPreferences.getInstance();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

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
      child: const PilloraApp(),
    ),
  );
}

class PilloraApp extends ConsumerStatefulWidget {
  const PilloraApp({super.key});

  @override
  ConsumerState<PilloraApp> createState() => _PilloraAppState();
}

class _PilloraAppState extends ConsumerState<PilloraApp> {
  late AppLifecycleObserver _observer;
  final Set<String> _notifiedCaregiverAlertIds = <String>{};
  ProviderSubscription<AsyncValue<List<RemoteMessage>>>? _foregroundMessagesSub;

  @override
  void initState() {
    super.initState();
    _observer = AppLifecycleObserver(ref);
    WidgetsBinding.instance.addObserver(_observer);
    _initMessaging();
  }

  @override
  void dispose() {
    _foregroundMessagesSub?.close();
    WidgetsBinding.instance.removeObserver(_observer);
    super.dispose();
  }

  Future<void> _initMessaging() async {
    final service = ref.read(firebaseMessagingServiceProvider);
    await service.init();
    final initialToken = await service.getToken();
    final initialCloudState = ref.read(caregiverCloudProvider);
    final initialDisplayName = ref.read(userNameProvider);
    if (initialCloudState.isConnected) {
      await ref
          .read(caregiverCloudProvider.notifier)
          .syncPushToken(displayName: initialDisplayName, token: initialToken);
    }

    service.onTokenRefresh.listen((token) async {
      final cloudState = ref.read(caregiverCloudProvider);
      final displayName = ref.read(userNameProvider);
      if (cloudState.isConnected) {
        await ref
            .read(caregiverCloudProvider.notifier)
            .syncPushToken(displayName: displayName, token: token);
      }
    });

    _foregroundMessagesSub = ref.listenManual(
      firebaseForegroundMessagesProvider,
          (previous, next) async {
        final notificationService = NotificationService();
        final messages = next.valueOrNull;
        if (messages == null) {
          return;
        }
        for (final message in messages) {
          final remote = message.notification;
          await notificationService.showImmediateNotification(
            id: message.messageId.hashCode,
            title: remote?.title ?? 'Caregiver alert',
            body: remote?.body ?? '',
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeModeProvider);
    final locale = ref.watch(localeProvider);
    final comfortMode = ref.watch(comfortModeProvider);

    // Узнаем, куда направлять пользователя ПОСЛЕ сплэша
    final onboardingComplete = ref.watch(onboardingCompleteProvider);

    final notificationService = NotificationService();
    final l10n = AppLocalizations.of(context);

    ref.listen(caregiverCloudAlertsProvider, (previous, next) {
      next.whenData((alerts) async {
        for (final alert in alerts) {
          if (_notifiedCaregiverAlertIds.add(alert.id)) {
            await notificationService.showImmediateNotification(
              id: alert.id.hashCode,
              title: l10n?.caregiverCloudNotificationTitle ?? 'Caregiver alert',
              body: alert.patientName.isEmpty
                  ? alert.message
                  : '${alert.patientName}: ${alert.message}',
            );
          }
        }
      });
    });

    return MaterialApp(
      onGenerateTitle: (context) =>
      AppLocalizations.of(context)?.appTitle ?? 'Pillora',
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

      // --- ИЗМЕНЕННАЯ СТРОКА: ЗАПУСКАЕМ НАШ СПЛЭШ И ПЕРЕДАЕМ ЕМУ ФЛАГ ---
      home: AnimatedSplashScreen(isOnboardingComplete: onboardingComplete),
    );
  }
}