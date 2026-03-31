import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/presentation/widgets/glass_container.dart';
import '../../../l10n/app_localizations.dart';
import '../provider/premium_provider.dart';

class PremiumPaywallSheet extends ConsumerWidget {
  const PremiumPaywallSheet({super.key});

  static void show(BuildContext context) {
    HapticFeedback.lightImpact();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const PremiumPaywallSheet(),
    );
  }

  Widget _buildFeatureRow(ThemeData theme, IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: theme.primaryColor.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: theme.primaryColor, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                text,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.85),
                  height: 1.3,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Container(
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      ),
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 32),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [theme.primaryColor, theme.colorScheme.secondary],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: theme.primaryColor.withValues(alpha: 0.3),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(Icons.star_rounded, color: Colors.white, size: 28),
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: Text(
                l10n.premiumTitle,
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.5,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(
                l10n.premiumSubtitle,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                  height: 1.4,
                ),
              ),
            ),
            const SizedBox(height: 32),
            GlassContainer(
              padding: const EdgeInsets.all(24),
              borderRadius: 24,
              color: theme.colorScheme.surface.withValues(alpha: 0.5),
              child: Column(
                children: [
                  _buildFeatureRow(theme, Icons.groups_rounded, l10n.premiumFeatureCaregiver),
                  _buildFeatureRow(theme, Icons.qr_code_scanner_rounded, l10n.premiumFeatureScanner),
                  _buildFeatureRow(theme, Icons.calendar_month_rounded, l10n.premiumFeatureSchedules),
                  _buildFeatureRow(theme, Icons.picture_as_pdf_rounded, l10n.premiumFeatureReports),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // 🚀 КНОПКА ГОДОВОЙ ПОДПИСКИ
            SizedBox(
              width: double.infinity,
              height: 64,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 4,
                  shadowColor: theme.primaryColor.withValues(alpha: 0.4),
                ),
                onPressed: () async {
                  HapticFeedback.mediumImpact();

                  // 🚀 РЕАЛЬНАЯ ПОКУПКА ЧЕРЕЗ REVENUECAT
                  final success = await ref.read(premiumProvider.notifier).purchasePro();

                  if (context.mounted) {
                    if (success) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Pillora Pro Activated!'), // Можно заменить на локализацию успеха
                          backgroundColor: Colors.green,
                        ),
                      );
                    } else {
                      // Ошибка или отмена пользователем
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Purchase cancelled or error occurred')),
                      );
                    }
                  }
                },
                child: Text(
                  l10n.premiumSubscribeYearly,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                ),
              ),
            ),

            const SizedBox(height: 24), // Чуть увеличил отступ до кнопки восстановления

            // 🚀 КНОПКА ВОССТАНОВЛЕНИЯ ПОКУПОК
            Center(
              child: TextButton(
                onPressed: () async {
                  HapticFeedback.lightImpact();

                  // 🚀 ВОССТАНОВЛЕНИЕ ПОКУПОК
                  await ref.read(premiumProvider.notifier).restore();

                  if (context.mounted) {
                    final isPremiumNow = ref.read(premiumProvider);
                    if (isPremiumNow) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Purchases restored successfully!')),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('No active subscriptions found')),
                      );
                    }
                  }
                },
                child: Text(
                  l10n.premiumRestorePurchases,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}