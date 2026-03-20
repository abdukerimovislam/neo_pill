import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/analytics/presentation/analytics_screen.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/settings/presentation/settings_screen.dart';
import '../../features/settings/provider/settings_provider.dart';
import '../../l10n/app_localizations.dart';
import 'widgets/glass_container.dart';

class MainNavigationScreen extends ConsumerStatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  ConsumerState<MainNavigationScreen> createState() =>
      _MainNavigationScreenState();
}

class _MainNavigationScreenState extends ConsumerState<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    AnalyticsScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final comfortMode = ref.watch(comfortModeProvider);

    final navigation = NavigationBar(
      backgroundColor: Colors.transparent,
      selectedIndex: _currentIndex,
      onDestinationSelected: (index) {
        setState(() => _currentIndex = index);
      },
      indicatorColor: theme.primaryColor.withValues(
        alpha: comfortMode ? 0.18 : 0.15,
      ),
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      destinations: [
        NavigationDestination(
          icon: Icon(
            Icons.calendar_today_outlined,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.55),
          ),
          selectedIcon: Icon(
            Icons.calendar_today_rounded,
            color: theme.primaryColor,
          ),
          label: l10n.tabHome,
        ),
        NavigationDestination(
          icon: Icon(
            Icons.insights_outlined,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.55),
          ),
          selectedIcon: Icon(Icons.insights_rounded, color: theme.primaryColor),
          label: l10n.tabAnalytics,
        ),
        NavigationDestination(
          icon: Icon(
            Icons.person_outline_rounded,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.55),
          ),
          selectedIcon: Icon(Icons.person_rounded, color: theme.primaryColor),
          label: l10n.tabSettings,
        ),
      ],
    );

    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: comfortMode ? 16 : 24,
            right: comfortMode ? 16 : 24,
            bottom: comfortMode ? 12 : 16,
          ),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOutCubic,
            child: comfortMode
                ? Container(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(
                      color: theme.dividerColor.withValues(alpha: 0.12),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.06),
                        blurRadius: 18,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(28),
                      child: navigation,
                    ),
                  )
                : GlassContainer(
                    padding: EdgeInsets.zero,
                    color: theme.colorScheme.surface.withValues(alpha: 0.82),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(32),
                      child: navigation,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
