import 'package:flutter/material.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/analytics/presentation/analytics_screen.dart';
import '../../features/settings/presentation/settings_screen.dart'; // 🚀 ДОБАВИЛИ НАШ НОВЫЙ ЭКРАН
import '../../l10n/app_localizations.dart';
import '../../core/presentation/widgets/glass_container.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  // 🚀 ТЕПЕРЬ У НАС 3 ЭКРАНА В СТЕКЕ
  final List<Widget> _screens = const [
    HomeScreen(),
    AnalyticsScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      // КРИТИЧНО ВАЖНО: Градиенты внутренних экранов растекаются ПОД навигацией
      extendBody: true,
      backgroundColor: Colors.transparent,

      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),

      // 🚀 ПАРЯЩЕЕ СТЕКЛЯННОЕ МЕНЮ (PURE SWISS STYLE)
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 24, right: 24, bottom: 16),
          child: GlassContainer(
            padding: EdgeInsets.zero,
            color: theme.colorScheme.surface.withValues(alpha: 0.8), // Чистое стекло
            child: ClipRRect(
              borderRadius: BorderRadius.circular(32), // Скругление под пилюлю
              child: NavigationBar(
                height: 64, // Изящная высота
                backgroundColor: Colors.transparent,
                elevation: 0,
                selectedIndex: _currentIndex,
                onDestinationSelected: (index) {
                  setState(() => _currentIndex = index);
                },
                indicatorColor: theme.primaryColor.withValues(alpha: 0.15),
                // Убираем лейблы для неактивных вкладок для минимализма (по желанию)
                labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
                destinations: [
                  NavigationDestination(
                    icon: Icon(Icons.calendar_today_outlined, color: theme.colorScheme.onSurface.withValues(alpha: 0.5)),
                    selectedIcon: Icon(Icons.calendar_today_rounded, color: theme.primaryColor),
                    label: l10n.tabHome,
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.insights_outlined, color: theme.colorScheme.onSurface.withValues(alpha: 0.5)),
                    selectedIcon: Icon(Icons.insights_rounded, color: theme.primaryColor),
                    label: l10n.tabAnalytics,
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.person_outline_rounded, color: theme.colorScheme.onSurface.withValues(alpha: 0.5)),
                    selectedIcon: Icon(Icons.person_rounded, color: theme.primaryColor),
                    label: l10n.tabSettings,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}