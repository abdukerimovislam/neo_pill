import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../theme/app_colors.dart';
import '../theme/app_motion.dart';
import '../../features/analytics/presentation/analytics_screen.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/settings/presentation/settings_screen.dart';
import '../../features/settings/provider/settings_provider.dart';
import '../../features/premium/provider/premium_provider.dart';
import '../../features/premium/presentation/premium_paywall_sheet.dart';
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

  // Убрали PageController, так как теперь используем AnimatedSwitcher
  final List<Widget> _screens = const [
    HomeScreen(),
    _ScannerStubScreen(),
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
        if (_currentIndex != index) {
          setState(() => _currentIndex = index);
          HapticFeedback.selectionClick(); // Легкая отдача при смене таба
        }
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
            Icons.qr_code_scanner_outlined,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.55),
          ),
          selectedIcon: Icon(
            Icons.qr_code_scanner_rounded,
            color: theme.primaryColor,
          ),
          label: l10n.tabScanner,
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

      // 🚀 АНИМИРОВАННЫЙ ПЕРЕХОД ВМЕСТО СВАЙПОВ
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        switchInCurve: Curves.easeOutCubic,
        switchOutCurve: Curves.easeInCubic,
        transitionBuilder: (Widget child, Animation<double> animation) {
          // Комбинируем Fade (проявление) и Slide (сдвиг снизу вверх)
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 0.05), // Легкий сдвиг снизу
                end: Offset.zero,
              ).animate(animation),
              child: child,
            ),
          );
        },
        // Ключ обязателен, чтобы AnimatedSwitcher понимал, что экран сменился
        child: SizedBox(
          key: ValueKey<int>(_currentIndex),
          child: _screens[_currentIndex],
        ),
      ),

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

class _ScannerStubScreen extends ConsumerWidget {
  const _ScannerStubScreen();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final isPremium = ref.watch(premiumProvider);

    // 🚀 ИЗБАВЛЯЕМСЯ ОТ ХАРДКОДА ЧЕРЕЗ ПРОВЕРКУ ЛОКАЛИ
    final isRu = Localizations.localeOf(context).languageCode == 'ru';
    final activeText = isRu ? 'Pillora Pro Активен' : 'Pillora Pro Active';

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: GlassContainer(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
          borderRadius: 32,
          color: theme.colorScheme.surface.withValues(alpha: 0.65),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: theme.primaryColor.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.document_scanner_rounded,
                  size: 64,
                  color: theme.primaryColor,
                ),
              ),
              const SizedBox(height: 28),
              Text(
                l10n.scannerComingSoonTitle,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: theme.colorScheme.onSurface,
                  letterSpacing: -0.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                l10n.scannerComingSoonText,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.65),
                  height: 1.45,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),

              if (!isPremium)
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.surface,
                      foregroundColor: theme.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    onPressed: () => PremiumPaywallSheet.show(context),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.star_rounded, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          l10n.premiumTitle,
                          style: const TextStyle(fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                  ),
                )
              else
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  decoration: BoxDecoration(
                    color: theme.successAccent.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.check_circle_rounded, color: theme.successAccent, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        activeText, // 👈 ИСПОЛЬЗУЕМ ДИНАМИЧЕСКИЙ ТЕКСТ
                        style: TextStyle(color: theme.successAccent, fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}