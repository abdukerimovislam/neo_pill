import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🚀 Провайдер темы (по умолчанию системная)
final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.system);

// 🚀 Провайдер языка (по умолчанию английский, но можно поставить 'ru')
final localeProvider = StateProvider<Locale>((ref) => const Locale('en'));

// 🚀 Провайдер имени пользователя
final userNameProvider = StateProvider<String>((ref) => 'Alex');