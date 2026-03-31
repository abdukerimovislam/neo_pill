import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../l10n/l10n_extensions.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>(
  (ref) => throw UnimplementedError(
    'SharedPreferences must be overridden in main().',
  ),
);

const _themeModeKey = 'settings.theme_mode';
const _localeKey = 'settings.locale';
const _userNameKey = 'settings.user_name';
const _comfortModeKey = 'settings.comfort_mode';
const _onboardingCompleteKey = 'settings.onboarding_complete';
const _caregiverProfileKey = 'settings.caregiver_profile';
const _caregiverAlertSettingsKey = 'settings.caregiver_alert_settings';

final themeModeProvider = NotifierProvider<ThemeModeNotifier, ThemeMode>(
  ThemeModeNotifier.new,
);
final localeProvider = NotifierProvider<LocaleNotifier, Locale>(
  LocaleNotifier.new,
);
final userNameProvider = NotifierProvider<UserNameNotifier, String>(
  UserNameNotifier.new,
);
final comfortModeProvider = NotifierProvider<ComfortModeNotifier, bool>(
  ComfortModeNotifier.new,
);
final onboardingCompleteProvider =
    NotifierProvider<OnboardingCompleteNotifier, bool>(
      OnboardingCompleteNotifier.new,
    );
final caregiverProfileProvider =
    NotifierProvider<CaregiverProfileNotifier, CaregiverProfile?>(
      CaregiverProfileNotifier.new,
    );
final caregiverAlertSettingsProvider =
    NotifierProvider<CaregiverAlertSettingsNotifier, CaregiverAlertSettings>(
      CaregiverAlertSettingsNotifier.new,
    );

class CaregiverProfile {
  final String name;
  final String relation;
  final String phone;
  final bool shareReports;

  const CaregiverProfile({
    required this.name,
    required this.relation,
    required this.phone,
    required this.shareReports,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'relation': relation,
    'phone': phone,
    'shareReports': shareReports,
  };

  factory CaregiverProfile.fromJson(Map<String, dynamic> json) {
    return CaregiverProfile(
      name: (json['name'] as String? ?? '').trim(),
      relation: (json['relation'] as String? ?? '').trim(),
      phone: (json['phone'] as String? ?? '').trim(),
      shareReports: json['shareReports'] as bool? ?? true,
    );
  }
}

class CaregiverAlertSettings {
  final bool enabled;
  final int graceMinutes;
  final bool includeSkipped;
  final bool includeOverdue;
  final bool includeSupplements;

  const CaregiverAlertSettings({
    required this.enabled,
    required this.graceMinutes,
    required this.includeSkipped,
    required this.includeOverdue,
    required this.includeSupplements,
  });

  factory CaregiverAlertSettings.defaults() => const CaregiverAlertSettings(
    enabled: true,
    graceMinutes: 45,
    includeSkipped: true,
    includeOverdue: true,
    includeSupplements: false,
  );

  CaregiverAlertSettings copyWith({
    bool? enabled,
    int? graceMinutes,
    bool? includeSkipped,
    bool? includeOverdue,
    bool? includeSupplements,
  }) {
    return CaregiverAlertSettings(
      enabled: enabled ?? this.enabled,
      graceMinutes: graceMinutes ?? this.graceMinutes,
      includeSkipped: includeSkipped ?? this.includeSkipped,
      includeOverdue: includeOverdue ?? this.includeOverdue,
      includeSupplements: includeSupplements ?? this.includeSupplements,
    );
  }

  Map<String, dynamic> toJson() => {
    'enabled': enabled,
    'graceMinutes': graceMinutes,
    'includeSkipped': includeSkipped,
    'includeOverdue': includeOverdue,
    'includeSupplements': includeSupplements,
  };

  factory CaregiverAlertSettings.fromJson(Map<String, dynamic> json) {
    return CaregiverAlertSettings(
      enabled: json['enabled'] as bool? ?? true,
      graceMinutes: json['graceMinutes'] as int? ?? 45,
      includeSkipped: json['includeSkipped'] as bool? ?? true,
      includeOverdue: json['includeOverdue'] as bool? ?? true,
      includeSupplements: json['includeSupplements'] as bool? ?? false,
    );
  }
}

class ThemeModeNotifier extends Notifier<ThemeMode> {
  @override
  ThemeMode build() {
    final rawValue = ref
        .read(sharedPreferencesProvider)
        .getString(_themeModeKey);
    switch (rawValue) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.light;
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    state = mode;
    await ref.read(sharedPreferencesProvider).setString(
      _themeModeKey,
      switch (mode) {
        ThemeMode.light => 'light',
        ThemeMode.dark => 'dark',
        ThemeMode.system => 'system',
      },
    );
  }
}

class LocaleNotifier extends Notifier<Locale> {
  // 🚀 ЕДИНЫЙ СПИСОК ВСЕХ ЯЗЫКОВ ПРИЛОЖЕНИЯ
  static const supportedLocales = [
    Locale('en'), // Английский (По умолчанию)
    Locale('ru'), // Русский
    Locale('es'), // Испанский
    Locale('fr'), // Французский
    Locale('de'), // Немецкий
    Locale('ky'), // Кыргызский
    Locale('kk'),
  ];

  @override
  Locale build() {
    final rawValue = ref.read(sharedPreferencesProvider).getString(_localeKey);

    // 1. Проверяем сохраненный кэш
    if (rawValue != null) {
      final savedLocale = Locale(rawValue);
      if (supportedLocales.contains(savedLocale)) {
        return savedLocale;
      }
    }

    // 2. Проверяем язык системы
    final systemLanguage = PlatformDispatcher.instance.locale.languageCode;
    final systemLocale = Locale(systemLanguage);

    if (supportedLocales.contains(systemLocale)) {
      return systemLocale;
    }

    // 3. Фолбэк на английский, если язык системы не поддерживается
    return const Locale('en');
  }

  Future<void> setLocale(Locale locale) async {
    state = locale;
    await ref
        .read(sharedPreferencesProvider)
        .setString(_localeKey, locale.languageCode);
  }
}

class UserNameNotifier extends Notifier<String> {
  @override
  String build() {
    final prefs = ref.read(sharedPreferencesProvider);
    final savedName = prefs.getString(_userNameKey)?.trim();
    if (savedName != null && savedName.isNotEmpty) {
      return savedName;
    }

    return ref.read(localeProvider).l10n.defaultUserName;
  }

  Future<void> setUserName(String name) async {
    final normalized = name.trim();
    if (normalized.isEmpty) {
      return;
    }

    state = normalized;
    await ref
        .read(sharedPreferencesProvider)
        .setString(_userNameKey, normalized);
  }
}

class ComfortModeNotifier extends Notifier<bool> {
  @override
  bool build() {
    return ref.read(sharedPreferencesProvider).getBool(_comfortModeKey) ?? true;
  }

  Future<void> setComfortMode(bool enabled) async {
    state = enabled;
    await ref.read(sharedPreferencesProvider).setBool(_comfortModeKey, enabled);
  }
}

class OnboardingCompleteNotifier extends Notifier<bool> {
  @override
  bool build() {
    return ref
            .read(sharedPreferencesProvider)
            .getBool(_onboardingCompleteKey) ??
        false;
  }

  Future<void> complete() async {
    state = true;
    await ref
        .read(sharedPreferencesProvider)
        .setBool(_onboardingCompleteKey, true);
  }

  Future<void> reset() async {
    state = false;
    await ref
        .read(sharedPreferencesProvider)
        .setBool(_onboardingCompleteKey, false);
  }
}

class CaregiverProfileNotifier extends Notifier<CaregiverProfile?> {
  @override
  CaregiverProfile? build() {
    final raw = ref
        .read(sharedPreferencesProvider)
        .getString(_caregiverProfileKey);
    if (raw == null || raw.isEmpty) {
      return null;
    }

    try {
      final decoded = jsonDecode(raw) as Map<String, dynamic>;
      final profile = CaregiverProfile.fromJson(decoded);
      if (profile.name.isEmpty) {
        return null;
      }
      return profile;
    } catch (_) {
      return null;
    }
  }

  Future<void> save(CaregiverProfile profile) async {
    if (profile.name.trim().isEmpty) {
      return;
    }

    state = profile;
    await ref
        .read(sharedPreferencesProvider)
        .setString(_caregiverProfileKey, jsonEncode(profile.toJson()));
  }

  Future<void> clear() async {
    state = null;
    await ref.read(sharedPreferencesProvider).remove(_caregiverProfileKey);
  }
}

class CaregiverAlertSettingsNotifier extends Notifier<CaregiverAlertSettings> {
  @override
  CaregiverAlertSettings build() {
    final raw = ref
        .read(sharedPreferencesProvider)
        .getString(_caregiverAlertSettingsKey);
    if (raw == null || raw.isEmpty) {
      return CaregiverAlertSettings.defaults();
    }

    try {
      final decoded = jsonDecode(raw) as Map<String, dynamic>;
      return CaregiverAlertSettings.fromJson(decoded);
    } catch (_) {
      return CaregiverAlertSettings.defaults();
    }
  }

  Future<void> save(CaregiverAlertSettings settings) async {
    state = settings;
    await ref
        .read(sharedPreferencesProvider)
        .setString(_caregiverAlertSettingsKey, jsonEncode(settings.toJson()));
  }
}
