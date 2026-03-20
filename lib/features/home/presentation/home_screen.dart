import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/presentation/widgets/glass_container.dart';
import '../../../core/presentation/widgets/gradient_scaffold.dart';
import '../../../data/local/entities/dose_log_entity.dart';
import '../../../l10n/app_localizations.dart';
import '../../measurements/presentation/widgets/add_measurement_modal.dart';
import '../../medicine_management/presentation/add_medicine_screen.dart';
import '../../settings/provider/settings_provider.dart';
import '../providers/home_controller.dart';
import '../providers/home_provider.dart';
import 'widgets/dose_card.dart';
import 'widgets/horizontal_calendar.dart';
import 'widgets/pill_icon_widget.dart';
import 'widgets/sos_panel.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  static bool _isRussian(BuildContext context) =>
      Localizations.localeOf(context).languageCode == 'ru';

  static String _copy(BuildContext context, String en, String ru) =>
      _isRussian(context) ? ru : en;

  void _showActionCenter(
    BuildContext context,
    ThemeData theme,
    AppLocalizations l10n,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
            boxShadow: [
              BoxShadow(
                color: theme.primaryColor.withValues(alpha: 0.15),
                blurRadius: 40,
                spreadRadius: 10,
              ),
            ],
          ),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 48,
                  height: 6,
                  decoration: BoxDecoration(
                    color: theme.dividerColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  l10n.whatWouldYouLikeToDo,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 24),
                _ActionCard(
                  icon: Icons.medication_rounded,
                  title: l10n.addMedicationTitle,
                  subtitle: l10n.scheduleNewTreatmentCourse,
                  color: theme.primaryColor,
                  theme: theme,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const AddMedicineScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                _ActionCard(
                  icon: Icons.monitor_heart_rounded,
                  title: l10n.addMeasurement,
                  subtitle: l10n.logHealthMetricsSubtitle,
                  color: theme.colorScheme.secondary,
                  theme: theme,
                  onTap: () {
                    Navigator.pop(context);
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      isScrollControlled: true,
                      builder: (_) => const AddMeasurementModal(),
                    );
                  },
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final scheduleAsyncValue = ref.watch(dailyScheduleProvider);
    final heroAsyncValue = ref.watch(heroDoseProvider);
    final dashboardAsyncValue = ref.watch(homeDashboardProvider);
    final userName = ref.watch(userNameProvider);
    final comfortMode = ref.watch(comfortModeProvider);

    final bottomSafeArea = MediaQuery.paddingOf(context).bottom;
    const glassNavHeight = 85.0;
    final totalBottomPadding = glassNavHeight + bottomSafeArea + 120.0;

    final hour = DateTime.now().hour;
    final greeting = hour < 12
        ? l10n.goodMorning
        : (hour < 18 ? l10n.goodAfternoon : l10n.goodEvening);
    final isRu = _isRussian(context);
    final displayName = userName.trim().isEmpty
        ? (isRu ? 'Друг' : 'Friend')
        : userName.trim();

    return GradientScaffold(
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        slivers: [
          SliverAppBar(
            expandedHeight: 118.0,
            pinned: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            surfaceTintColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: 16,
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        greeting,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onSurface.withValues(
                            alpha: 0.5,
                          ),
                        ),
                      ),
                      Text(
                        displayName,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w900,
                          letterSpacing: -0.5,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: theme.colorScheme.surface.withValues(alpha: 0.8),
                    ),
                    child: Icon(
                      Icons.local_pharmacy_rounded,
                      color: theme.primaryColor,
                      size: 18,
                    ),
                  ),
                ],
              ),
              background: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      theme.scaffoldBackgroundColor.withValues(alpha: 0.92),
                      theme.scaffoldBackgroundColor.withValues(alpha: 0.0),
                    ],
                  ),
                ),
              ),
            ),
          ),
          heroAsyncValue.when(
            data: (heroItem) {
              return SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 12,
                    bottom: 24,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      dashboardAsyncValue.when(
                        data: (summary) => _MedicationAssistCard(
                          summary: summary,
                          comfortMode: comfortMode,
                        ),
                        loading: () => const SizedBox.shrink(),
                        error: (_, stackTrace) => const SizedBox.shrink(),
                      ),
                      if (heroItem != null) ...[
                        const SizedBox(height: 16),
                        _HeroMedicationCard(
                          item: heroItem,
                          l10n: l10n,
                          comfortMode: comfortMode,
                        ),
                      ] else ...[
                        const SizedBox(height: 16),
                        _HomeHintCard(
                          title: _copy(
                            context,
                            'Nothing is due right now',
                            'Сейчас ничего не нужно принимать',
                          ),
                          subtitle: _copy(
                            context,
                            'Use the calendar below if you want to check another day.',
                            'Ниже можно выбрать другой день и посмотреть расписание.',
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            },
            loading: () => const SliverToBoxAdapter(child: SizedBox.shrink()),
            error: (_, stackTrace) =>
                const SliverToBoxAdapter(child: SizedBox.shrink()),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: HorizontalCalendar(),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isRu ? 'Препараты к приему' : 'Medications to take',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _copy(
                        context,
                        'The nearest doses are shown first.',
                        'Ближайшие приемы показаны первыми.',
                      ),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ),
          ),
          scheduleAsyncValue.when(
            data: (scheduleItems) {
              final currentHero = ref.read(heroDoseProvider).valueOrNull;
              final filteredItems = scheduleItems
                  .where(
                    (item) =>
                        currentHero == null ||
                        item.doseLog.id != currentHero.doseLog.id,
                  )
                  .toList();

              if (filteredItems.isEmpty && currentHero == null) {
                return SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.task_alt_rounded,
                          size: 42,
                          color: theme.colorScheme.secondary.withValues(
                            alpha: 0.4,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          l10n.emptySchedule,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          isRu
                              ? 'Сейчас нет лекарств, требующих внимания.'
                              : 'No medications need attention right now.',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurface.withValues(
                              alpha: 0.55,
                            ),
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 140),
                      ],
                    ),
                  ),
                );
              }

              if (filteredItems.isEmpty && currentHero != null) {
                return const SliverToBoxAdapter(child: SizedBox(height: 12));
              }

              return SliverPadding(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: totalBottomPadding,
                ),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: DoseCard(item: filteredItems[index]),
                    ),
                    childCount: filteredItems.length,
                  ),
                ),
              );
            },
            loading: () => const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (error, _) => SliverFillRemaining(
              child: Center(child: Text(l10n.errorPrefix(error.toString()))),
            ),
          ),
          const SliverToBoxAdapter(child: SosPanel()),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: glassNavHeight + 16),
        child: Container(
          height: comfortMode ? 60 : 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: theme.primaryColor.withValues(alpha: 0.25),
                blurRadius: 20,
                spreadRadius: 2,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: FloatingActionButton.extended(
            heroTag: 'action_center_btn',
            elevation: 0,
            backgroundColor: theme.primaryColor,
            foregroundColor: Colors.white,
            onPressed: () => _showActionCenter(context, theme, l10n),
            icon: const Icon(Icons.add_rounded, size: 24),
            label: Text(
              _copy(
                context,
                'Add medication or measurement',
                'Добавить препарат или замер',
              ),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MedicationAssistCard extends StatelessWidget {
  final HomeDashboardSummary summary;
  final bool comfortMode;

  const _MedicationAssistCard({
    required this.summary,
    required this.comfortMode,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isRu = HomeScreen._isRussian(context);
    final locale = Localizations.localeOf(context).languageCode;
    final nextDose = summary.nextPendingDose;
    final nextDoseText = nextDose == null
        ? (isRu
              ? 'Ближайший прием не запланирован.'
              : 'No upcoming medication scheduled.')
        : '${DateFormat.Hm(locale).format(nextDose.doseLog.scheduledTime)} - ${nextDose.medicine?.name ?? 'Medication'}';

    return GlassContainer(
      padding: EdgeInsets.all(comfortMode ? 20 : 18),
      color: theme.colorScheme.surface.withValues(
        alpha: comfortMode ? 0.92 : 0.46,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (summary.overdueDoses > 0)
            _AssistRow(
              icon: Icons.warning_amber_rounded,
              color: theme.colorScheme.error,
              title: isRu ? 'Требует внимания' : 'Needs attention',
              subtitle: isRu
                  ? '${summary.overdueDoses} препарат${summary.overdueDoses == 1 ? '' : 'а'} нужно принять или проверить сейчас.'
                  : '${summary.overdueDoses} medication${summary.overdueDoses == 1 ? '' : 's'} should be taken or reviewed now.',
            ),
          if (summary.overdueDoses > 0 &&
              (nextDose != null || summary.lowStockMedicines > 0))
            _AssistDivider(theme: theme),
          if (nextDose != null)
            _AssistRow(
              icon: Icons.schedule_rounded,
              color: theme.primaryColor,
              title: isRu ? 'Следующий прием' : 'Next medication',
              subtitle: nextDoseText,
            ),
          if (nextDose != null && summary.lowStockMedicines > 0)
            _AssistDivider(theme: theme),
          if (summary.lowStockMedicines > 0)
            _AssistRow(
              icon: Icons.inventory_2_rounded,
              color: Colors.orange.shade700,
              title: isRu ? 'Напоминание о пополнении' : 'Refill reminder',
              subtitle: isRu
                  ? 'Скоро может потребоваться пополнить ${summary.lowStockMedicines} препарат${summary.lowStockMedicines == 1 ? '' : 'а'}.'
                  : '${summary.lowStockMedicines} medication${summary.lowStockMedicines == 1 ? '' : 's'} may need a refill soon.',
            ),
          if (summary.overdueDoses == 0 &&
              nextDose == null &&
              summary.lowStockMedicines == 0)
            _AssistRow(
              icon: Icons.check_circle_rounded,
              color: theme.colorScheme.secondary,
              title: isRu ? 'Все спокойно' : 'Everything is calm',
              subtitle: isRu
                  ? 'Сейчас нет срочных задач по лекарствам.'
                  : 'No urgent medication tasks right now.',
            ),
        ],
      ),
    );
  }
}

class _AssistDivider extends StatelessWidget {
  final ThemeData theme;

  const _AssistDivider({required this.theme});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Container(
        height: 1,
        color: theme.dividerColor.withValues(alpha: 0.18),
      ),
    );
  }
}

class _AssistRow extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;

  const _AssistRow({
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                subtitle,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.62),
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _HeroMedicationCard extends ConsumerWidget {
  final DoseScheduleItem item;
  final AppLocalizations l10n;
  final bool comfortMode;

  const _HeroMedicationCard({
    required this.item,
    required this.l10n,
    required this.comfortMode,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isRu = HomeScreen._isRussian(context);
    final medicine = item.medicine;
    final timeString = DateFormat.Hm(
      Localizations.localeOf(context).languageCode,
    ).format(item.doseLog.scheduledTime);
    final rawDosage = item.doseLog.dosage > 0
        ? item.doseLog.dosage
        : (medicine?.dosage ?? 0);
    final dosage = rawDosage % 1 == 0
        ? rawDosage.toInt().toString()
        : rawDosage.toString();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isRu ? 'Примите этот препарат сейчас' : 'Take this medication now',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w800,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 12),
        GlassContainer(
          padding: EdgeInsets.all(comfortMode ? 24 : 22),
          color: comfortMode
              ? theme.colorScheme.surface.withValues(alpha: 0.96)
              : theme.primaryColor.withValues(alpha: 0.06),
          child: Column(
            children: [
              Row(
                children: [
                  if (medicine != null)
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surface,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Color(
                              medicine.pillColor,
                            ).withValues(alpha: 0.2),
                            blurRadius: 12,
                          ),
                        ],
                      ),
                      child: Center(
                        child: PillIconWidget(
                          shape: medicine.pillShape,
                          colorHex: medicine.pillColor,
                          size: 28,
                        ),
                      ),
                    ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          timeString,
                          style: theme.textTheme.headlineSmall?.copyWith(
                            color: theme.primaryColor,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          medicine?.name ?? l10n.unknownMedicine,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '$dosage ${medicine?.dosageUnit}',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurface.withValues(
                              alpha: 0.6,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          isRu
                              ? 'Запланировано на $timeString'
                              : 'Scheduled for $timeString',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurface.withValues(
                              alpha: 0.5,
                            ),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: comfortMode ? 60 : 56,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {
                    ref
                        .read(homeControllerProvider)
                        .updateDoseStatus(item.doseLog, DoseStatusEnum.taken);
                    ref.invalidate(heroDoseProvider);
                    ref.invalidate(homeDashboardProvider);
                  },
                  icon: const Icon(Icons.check_circle_rounded, size: 26),
                  label: Text(
                    l10n.takeNowAction,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    ref
                        .read(homeControllerProvider)
                        .updateDoseStatus(item.doseLog, DoseStatusEnum.skipped);
                    ref.invalidate(heroDoseProvider);
                    ref.invalidate(homeDashboardProvider);
                  },
                  icon: const Icon(Icons.close_rounded),
                  label: Text(l10n.skipDoseAction),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _HomeHintCard extends StatelessWidget {
  final String title;
  final String subtitle;

  const _HomeHintCard({
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withValues(alpha: 0.84),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: theme.dividerColor.withValues(alpha: 0.14),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: theme.colorScheme.secondary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.event_available_rounded,
              color: theme.colorScheme.secondary,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.65),
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final ThemeData theme;
  final VoidCallback onTap;

  const _ActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.theme,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: GlassContainer(
        padding: const EdgeInsets.all(18),
        color: color.withValues(alpha: 0.04),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
            ),
          ],
        ),
      ),
    );
  }
}
