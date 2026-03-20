import 'package:flutter/material.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/analytics/presentation/analytics_screen.dart';
import '../../l10n/app_localizations.dart';
// НОВЫЙ ИМПОРТ: Подключаем наше стекло
import 'widgets/glass_container.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    AnalyticsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      // КРИТИЧНО ВАЖНО: Это позволяет градиентам внутренних экранов растекаться ПОД навигацией
      extendBody: true,
      backgroundColor: Colors.transparent,

      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),

      // Делаем парящее стеклянное меню
      bottomNavigationBar: SafeArea(
        child: GlassContainer(
          // Отступы, чтобы меню "парило" над нижним краем экрана
          margin: const EdgeInsets.only(left: 24, right: 24, bottom: 16),
          padding: EdgeInsets.zero,
          borderRadius: 32,
          // Немного затемняем стекло для контраста иконок
          color: theme.cardColor.withOpacity(0.6),
          child: NavigationBar(
            height: 65, // Делаем бар чуть изящнее
            backgroundColor: Colors.transparent, // Фон обеспечивает GlassContainer
            elevation: 0,
            selectedIndex: _currentIndex,
            onDestinationSelected: (index) {
              setState(() => _currentIndex = index);
            },
            indicatorColor: theme.primaryColor.withOpacity(0.15),
            destinations: [
              NavigationDestination(
                icon: const Icon(Icons.calendar_today_outlined),
                selectedIcon: Icon(Icons.calendar_today, color: theme.primaryColor),
                label: l10n.tabHome,
              ),
              NavigationDestination(
                icon: const Icon(Icons.insights_outlined),
                selectedIcon: Icon(Icons.insights, color: theme.primaryColor),
                label: l10n.tabAnalytics,
              ),
            ],
          ),
        ),
      ),
    );
  }
}