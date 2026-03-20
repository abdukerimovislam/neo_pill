import 'package:flutter/material.dart';

class GradientScaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  // НОВЫЕ СВОЙСТВА ДЛЯ ГИБКОСТИ:
  final bool extendBodyBehindAppBar;
  final bool resizeToAvoidBottomInset;

  const GradientScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.floatingActionButtonLocation,
    // По умолчанию растягиваем фон под прозрачный AppBar
    this.extendBodyBehindAppBar = true,
    // По умолчанию позволяем Scaffold двигать контент от клавиатуры
    this.resizeToAvoidBottomInset = true,
  });

  @override
  Widget build(BuildContext context) {
    // Проверяем текущую тему устройства
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          // Адаптивная палитра: светлый или глубокий темный градиент
          colors: isDark
              ? const [
            Color(0xFF1A1F2B), // Глубокий темный синий
            Color(0xFF172621), // Темный хвойный/мятный
            Color(0xFF1E1A29), // Темный фиолетовый/лавандовый
          ]
              : const [
            Color(0xFFE3F2FD),
            Color(0xFFE0F2F1),
            Color(0xFFEDE7F6),
          ],
          stops: const [0.0, 0.5, 1.0],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,

        // ВАЖНО: Архитектурные настройки для идеального визуала
        extendBodyBehindAppBar: extendBodyBehindAppBar,
        extendBody: true, // Всегда растягиваем под нижний навбар
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,

        appBar: appBar,
        body: body,
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: floatingActionButtonLocation,
        bottomNavigationBar: bottomNavigationBar,
      ),
    );
  }
}