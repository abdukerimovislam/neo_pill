import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/presentation/main_navigation_screen.dart';
import '../../../core/presentation/widgets/gradient_scaffold.dart';
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

  bool get _isRussian => Localizations.localeOf(context).languageCode == 'ru';

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
      await ref.read(userNameProvider.notifier).setUserName(_nameController.text);
    }

    if (_currentPage == _pageCount - 1) {
      await ref.read(onboardingCompleteProvider.notifier).complete();
      if (!mounted) {
        return;
      }

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
    final locale = ref.watch(localeProvider);
    final comfortMode = ref.watch(comfortModeProvider);

    return GradientScaffold(
      useSafeArea: true,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        child: Column(
          children: [
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
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (page) => setState(() => _currentPage = page),
                children: [
                  _WelcomeStep(isRu: _isRussian),
                  _PersonalizeStep(
                    isRu: _isRussian,
                    nameController: _nameController,
                    locale: locale,
                    comfortMode: comfortMode,
                  ),
                  _ReadyStep(isRu: _isRussian, comfortMode: comfortMode),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _nextPage,
                child: Text(
                  _currentPage == _pageCount - 1
                      ? (_isRussian ? 'Начать работу' : 'Start using NeoPill')
                      : (_isRussian ? 'Продолжить' : 'Continue'),
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
                  child: Text(_isRussian ? 'Назад' : 'Back'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _WelcomeStep extends StatelessWidget {
  final bool isRu;

  const _WelcomeStep({required this.isRu});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Spacer(),
        Container(
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
        const SizedBox(height: 24),
        Text(
          isRu
              ? 'NeoPill поможет не пропускать лекарства'
              : 'NeoPill helps you stay on track',
          style: theme.textTheme.displayLarge?.copyWith(height: 1.1),
        ),
        const SizedBox(height: 16),
        Text(
          isRu ? 'Спокойно, понятно и по делу.' : 'Calm, clear, and focused.',
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          isRu
              ? 'Сразу после запуска вы будете видеть, какие препараты нужно принять сейчас и что предстоит дальше.'
              : 'Right after opening the app, you will see what medication needs to be taken now and what comes next.',
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.72),
            height: 1.5,
          ),
        ),
        const SizedBox(height: 28),
        _FeatureChip(
          icon: Icons.visibility_rounded,
          label: isRu
              ? 'Крупный и понятный интерфейс'
              : 'Large, easy-to-read interface',
        ),
        const SizedBox(height: 12),
        _FeatureChip(
          icon: Icons.schedule_rounded,
          label: isRu ? 'Фокус на ближайшем приеме' : 'Focus on the next dose',
        ),
        const SizedBox(height: 12),
        _FeatureChip(
          icon: Icons.notifications_active_rounded,
          label: isRu
              ? 'Напоминания и контроль запаса'
              : 'Reminders and refill awareness',
        ),
        const Spacer(flex: 2),
      ],
    );
  }
}

class _PersonalizeStep extends ConsumerWidget {
  final bool isRu;
  final TextEditingController nameController;
  final Locale locale;
  final bool comfortMode;

  const _PersonalizeStep({
    required this.isRu,
    required this.nameController,
    required this.locale,
    required this.comfortMode,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        const SizedBox(height: 12),
        Text(
          isRu ? 'Подстроим приложение под вас' : 'Let us tailor the app for you',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          isRu
              ? 'Эти настройки можно будет поменять позже в профиле.'
              : 'You can change these settings later in Profile.',
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ),
        const SizedBox(height: 24),
        TextField(
          controller: nameController,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
            labelText: isRu ? 'Как к вам обращаться?' : 'What should we call you?',
            hintText: isRu ? 'Например, Анна' : 'For example, Alex',
          ),
        ),
        const SizedBox(height: 24),
        Text(
          isRu ? 'Язык' : 'Language',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _OptionButton(
                label: 'English',
                selected: locale.languageCode == 'en',
                onTap: () => ref.read(localeProvider.notifier).setLocale(const Locale('en')),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _OptionButton(
                label: 'Русский',
                selected: locale.languageCode == 'ru',
                onTap: () => ref.read(localeProvider.notifier).setLocale(const Locale('ru')),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Text(
          isRu ? 'Удобство чтения' : 'Reading comfort',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 12),
        Container(
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
                      isRu ? 'Комфортный режим' : 'Comfort mode',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      isRu
                          ? 'Более крупный текст, крупнее кнопки и меньше визуального шума.'
                          : 'Larger text, bigger buttons, and less visual clutter.',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.68),
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              Switch.adaptive(
                value: comfortMode,
                activeTrackColor: theme.colorScheme.primary,
                onChanged: (value) => ref.read(comfortModeProvider.notifier).setComfortMode(value),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ReadyStep extends StatelessWidget {
  final bool isRu;
  final bool comfortMode;

  const _ReadyStep({required this.isRu, required this.comfortMode});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Spacer(),
        Text(
          isRu ? 'Все готово' : 'You are all set',
          style: theme.textTheme.displayLarge?.copyWith(height: 1.1),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            isRu
                ? 'Главное на первом экране: что и когда принять.'
                : 'The first screen focuses on what to take and when.',
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          isRu
              ? 'На главном экране сначала показываются препараты, которые нужно принять, а статистика остается на отдельной вкладке.'
              : 'The home screen shows medications that need attention first, while statistics stay on a separate tab.',
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.72),
            height: 1.5,
          ),
        ),
        const SizedBox(height: 28),
        _SummaryRow(
          icon: Icons.check_circle_rounded,
          text: isRu
              ? 'Главный экран без лишней перегрузки'
              : 'A simpler home screen with less clutter',
        ),
        const SizedBox(height: 14),
        _SummaryRow(
          icon: Icons.notifications_none_rounded,
          text: isRu
              ? 'Понятные действия: принять, пропустить, добавить'
              : 'Clear actions: take, skip, add',
        ),
        const SizedBox(height: 14),
        _SummaryRow(
          icon: Icons.text_increase_rounded,
          text: comfortMode
              ? (isRu
                    ? 'Комфортный режим уже включен'
                    : 'Comfort mode is already on')
              : (isRu
                    ? 'Комфортный режим можно включить позже в профиле'
                    : 'Comfort mode can be turned on later in Profile'),
        ),
        const Spacer(flex: 2),
      ],
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
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: theme.dividerColor.withValues(alpha: 0.14)),
      ),
      child: Row(
        children: [
          Icon(icon, color: theme.colorScheme.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
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

    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: selected
            ? theme.colorScheme.primary.withValues(alpha: 0.08)
            : theme.colorScheme.surface,
        side: BorderSide(
          color: selected
              ? theme.colorScheme.primary
              : theme.dividerColor.withValues(alpha: 0.22),
          width: selected ? 1.6 : 1.0,
        ),
      ),
      onPressed: onTap,
      child: Text(label),
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
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(icon, color: theme.colorScheme.primary),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
              height: 1.35,
            ),
          ),
        ),
      ],
    );
  }
}
