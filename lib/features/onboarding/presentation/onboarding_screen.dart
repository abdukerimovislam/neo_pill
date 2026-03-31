import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/presentation/main_navigation_screen.dart';
import '../../../core/presentation/widgets/animated_reveal.dart';
import '../../../core/presentation/widgets/gradient_scaffold.dart';
import '../../../l10n/app_localizations.dart';
import '../../settings/provider/settings_provider.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _pageController = PageController();
  final TextEditingController _nameController = TextEditingController();
  static const _pageCount = 3;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _nameController.text = '';
  }

  @override
  void dispose() {
    _pageController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _nextPage() async {
    if (_currentPage == 1) {
      await ref
          .read(userNameProvider.notifier)
          .setUserName(_nameController.text);
    }

    if (_currentPage == _pageCount - 1) {
      await ref.read(onboardingCompleteProvider.notifier).complete();
      if (!mounted) return;

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const MainNavigationScreen()),
      );
      return;
    }

    await _pageController.nextPage(
      duration: const Duration(milliseconds: 240),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final locale = ref.watch(localeProvider);
    final comfortMode = ref.watch(comfortModeProvider);

    return GradientScaffold(
      useSafeArea: true,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        child: Column(
          children: [
            // Индикатор прогресса (Dots)
            Row(
              children: List.generate(
                _pageCount,
                    (index) => Expanded(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    height: 6,
                    margin: EdgeInsets.only(
                      right: index == _pageCount - 1 ? 0 : 8,
                    ),
                    decoration: BoxDecoration(
                      color: index <= _currentPage
                          ? theme.colorScheme.primary
                          : theme.colorScheme.onSurface.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Основной контент
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (page) => setState(() => _currentPage = page),
                children: [
                  _WelcomeStep(l10n: l10n),
                  _PersonalizeStep(
                    l10n: l10n,
                    nameController: _nameController,
                    locale: locale,
                    comfortMode: comfortMode,
                  ),
                  _ReadyStep(l10n: l10n, comfortMode: comfortMode),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Кнопки управления
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _nextPage,
                child: Text(
                  _currentPage == _pageCount - 1
                      ? l10n.onboardingStartUsing
                      : l10n.onboardingContinue,
                ),
              ),
            ),
            const SizedBox(height: 12),
            if (_currentPage > 0)
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    _pageController.previousPage(
                      duration: const Duration(milliseconds: 220),
                      curve: Curves.easeOutCubic,
                    );
                  },
                  child: Text(l10n.onboardingBack),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _WelcomeStep extends StatelessWidget {
  final AppLocalizations l10n;

  const _WelcomeStep({required this.l10n});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          child: IntrinsicHeight(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                AnimatedReveal(
                  delay: const Duration(milliseconds: 40),
                  child: Container(
                    width: 88,
                    height: 88,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withValues(alpha: 0.12),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.medication_liquid_rounded,
                      size: 42,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                AnimatedReveal(
                  delay: const Duration(milliseconds: 100),
                  child: Text(
                    l10n.onboardingWelcomeTitle,
                    style: theme.textTheme.displayLarge?.copyWith(
                      height: 1.1,
                      fontSize: 34,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                AnimatedReveal(
                  delay: const Duration(milliseconds: 150),
                  child: Text(
                    l10n.onboardingWelcomeTagline,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                AnimatedReveal(
                  delay: const Duration(milliseconds: 190),
                  child: Text(
                    l10n.onboardingWelcomeBody,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.72),
                      height: 1.5,
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                AnimatedReveal(
                  delay: const Duration(milliseconds: 240),
                  child: _FeatureChip(
                    icon: Icons.visibility_rounded,
                    label: l10n.onboardingFeatureEasyInterface,
                  ),
                ),
                const SizedBox(height: 12),
                AnimatedReveal(
                  delay: const Duration(milliseconds: 290),
                  child: _FeatureChip(
                    icon: Icons.schedule_rounded,
                    label: l10n.onboardingFeatureNextDose,
                  ),
                ),
                const SizedBox(height: 12),
                AnimatedReveal(
                  delay: const Duration(milliseconds: 340),
                  child: _FeatureChip(
                    icon: Icons.notifications_active_rounded,
                    label: l10n.onboardingFeatureReminders,
                  ),
                ),
                const Spacer(flex: 2),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PersonalizeStep extends ConsumerWidget {
  final AppLocalizations l10n;
  final TextEditingController nameController;
  final Locale locale;
  final bool comfortMode;

  const _PersonalizeStep({
    required this.l10n,
    required this.nameController,
    required this.locale,
    required this.comfortMode,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    const languageOptions = <Locale>[
      Locale('en'),
      Locale('ru'),
      Locale('es'),
      Locale('fr'),
      Locale('de'),
      Locale('ky'),
      Locale('kk'),
    ];

    String languageLabel(Locale locale) {
      return switch (locale.languageCode) {
        'ru' => 'Русский',
        'es' => 'Español',
        'fr' => 'Français',
        'de' => 'Deutsch',
        'ky' => 'Кыргызча',
        'kk' => 'Қазақша',
        _ => 'English',
      };
    }

    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        const SizedBox(height: 12),
        AnimatedReveal(
          delay: const Duration(milliseconds: 40),
          child: Text(
            l10n.onboardingTailorTitle,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(height: 12),
        AnimatedReveal(
          delay: const Duration(milliseconds: 90),
          child: Text(
            l10n.onboardingTailorSubtitle,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
        ),

        // 🚀 ВЫБОР ЯЗЫКА (ПЕРВЫМ)
        const SizedBox(height: 24),
        AnimatedReveal(
          delay: const Duration(milliseconds: 140),
          child: Text(
            l10n.onboardingLanguageTitle,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(height: 12),
        AnimatedReveal(
          delay: const Duration(milliseconds: 170),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final itemWidth = (constraints.maxWidth - 12) / 2;
              return Wrap(
                spacing: 12,
                runSpacing: 12,
                children: languageOptions.map((option) {
                  return SizedBox(
                    width: itemWidth,
                    child: _OptionButton(
                      label: languageLabel(option),
                      selected: locale.languageCode == option.languageCode,
                      onTap: () =>
                          ref.read(localeProvider.notifier).setLocale(option),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ),

        // 🚀 ИМЯ (ВТОРЫМ)
        const SizedBox(height: 24),
        AnimatedReveal(
          delay: const Duration(milliseconds: 210),
          child: TextField(
            controller: nameController,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
              labelText: l10n.onboardingNamePrompt,
              hintText: l10n.settingsExampleName,
            ),
          ),
        ),

        // 🚀 РЕЖИМ КОМФОРТА (ТРЕТЬИМ)
        const SizedBox(height: 24),
        AnimatedReveal(
          delay: const Duration(milliseconds: 250),
          child: Text(
            l10n.onboardingReadingComfort,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(height: 12),
        AnimatedReveal(
          delay: const Duration(milliseconds: 280),
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                color: theme.dividerColor.withValues(alpha: 0.14),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    Icons.text_fields_rounded,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.onboardingComfortModeTitle,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        l10n.onboardingComfortModeSubtitle,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurface.withValues(
                            alpha: 0.68,
                          ),
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
                Switch.adaptive(
                  value: comfortMode,
                  activeTrackColor: theme.colorScheme.primary,
                  onChanged: (value) => ref
                      .read(comfortModeProvider.notifier)
                      .setComfortMode(value),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}

class _ReadyStep extends StatelessWidget {
  final AppLocalizations l10n;
  final bool comfortMode;

  const _ReadyStep({required this.l10n, required this.comfortMode});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          child: IntrinsicHeight(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                Text(
                  l10n.onboardingReadyTitle,
                  style: theme.textTheme.displayLarge?.copyWith(
                    height: 1.1,
                    fontSize: 34,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    l10n.onboardingReadyBanner,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  l10n.onboardingReadyBody,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.72),
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 28),
                _SummaryRow(
                  icon: Icons.check_circle_rounded,
                  text: l10n.onboardingReadySummaryHome,
                ),
                const SizedBox(height: 14),
                _SummaryRow(
                  icon: Icons.notifications_none_rounded,
                  text: l10n.onboardingReadySummaryActions,
                ),
                const SizedBox(height: 14),
                _SummaryRow(
                  icon: Icons.text_increase_rounded,
                  text: comfortMode
                      ? l10n.onboardingReadySummaryComfortOn
                      : l10n.onboardingReadySummaryComfortLater,
                ),
                const Spacer(flex: 2),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FeatureChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _FeatureChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: theme.dividerColor.withValues(alpha: 0.1)),
      ),
      child: Row(
        children: [
          Icon(icon, color: theme.colorScheme.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _SummaryRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: theme.colorScheme.primary),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.74),
              height: 1.45,
            ),
          ),
        ),
      ],
    );
  }
}

class _OptionButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _OptionButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        decoration: BoxDecoration(
          color: selected
              ? theme.colorScheme.primary
              : theme.colorScheme.surface.withValues(alpha: 0.7),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: selected
                ? Colors.transparent
                : theme.dividerColor.withValues(alpha: 0.1),
          ),
        ),
        child: Center(
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.titleMedium?.copyWith(
              color: selected ? Colors.white : theme.colorScheme.onSurface,
              fontWeight: FontWeight.w800,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}