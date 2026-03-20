import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

class ThemeModeNotifier extends Notifier<ThemeMode> {
  @override
  ThemeMode build() {
    final rawValue = ref.read(sharedPreferencesProvider).getString(_themeModeKey);
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
  @override
  Locale build() {
    final rawValue = ref.read(sharedPreferencesProvider).getString(_localeKey);
    if (rawValue == 'ru') {
      return const Locale('ru');
    }
    if (rawValue == 'en') {
      return const Locale('en');
    }

    final systemLanguage = PlatformDispatcher.instance.locale.languageCode;
    return systemLanguage == 'ru' ? const Locale('ru') : const Locale('en');
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

    return ref.read(localeProvider).languageCode == 'ru' ? 'Друг' : 'Friend';
  }

  Future<void> setUserName(String name) async {
    final normalized = name.trim();
    if (normalized.isEmpty) {
      return;
    }

    state = normalized;
    await ref.read(sharedPreferencesProvider).setString(_userNameKey, normalized);
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
    return ref.read(sharedPreferencesProvider).getBool(_onboardingCompleteKey) ?? false;
  }

  Future<void> complete() async {
    state = true;
    await ref.read(sharedPreferencesProvider).setBool(_onboardingCompleteKey, true);
  }

  Future<void> reset() async {
    state = false;
    await ref.read(sharedPreferencesProvider).setBool(_onboardingCompleteKey, false);
  }
}

class CaregiverProfileNotifier extends Notifier<CaregiverProfile?> {
  @override
  CaregiverProfile? build() {
    final raw = ref.read(sharedPreferencesProvider).getString(_caregiverProfileKey);
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
