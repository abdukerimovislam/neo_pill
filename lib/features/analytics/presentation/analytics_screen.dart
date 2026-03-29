import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/firebase/caregiver_cloud_repository.dart';
import '../../../core/presentation/widgets/glass_container.dart';
import '../../../core/presentation/widgets/animated_reveal.dart';
import '../../../core/presentation/widgets/care_context_switcher.dart';
import '../../../core/presentation/widgets/gradient_scaffold.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/local/entities/measurement_entity.dart';
import '../../../l10n/app_localizations.dart';
import '../../settings/provider/care_context_provider.dart';
import '../../settings/provider/caregiver_cloud_provider.dart';
import '../../settings/provider/settings_provider.dart';
import '../providers/analytics_provider.dart';

class AnalyticsScreen extends ConsumerWidget {
  const AnalyticsScreen({super.key});

  static String _courseFilterLabel(
      BuildContext context,
      AnalyticsCourseFilterType filter,
      ) {
    return switch (filter) {
      AnalyticsCourseFilterType.all => AppLocalizations.of(
        context,
      )!.courseFilterAll,
      AnalyticsCourseFilterType.medications => AppLocalizations.of(
        context,
      )!.courseFilterMedications,
      AnalyticsCourseFilterType.supplements => AppLocalizations.of(
        context,
      )!.courseFilterSupplements,
    };
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final caregiverCloudState = ref.watch(caregiverCloudProvider);
    final caregiverCloudAlerts =
        ref.watch(caregiverCloudAlertsProvider).valueOrNull ??
            const <CaregiverCloudAlert>[];
    final displayName = ref.watch(userNameProvider).trim().isEmpty
        ? l10n.defaultUserName
        : ref.watch(userNameProvider).trim();
    final hasCaregivingContext = caregiverCloudState.hasCaregiverLink;
    final selectedContext = hasCaregivingContext
        ? ref.watch(selectedCareContextProvider)
        : AppCareContext.myCare;
    final isMyCare = selectedContext == AppCareContext.myCare;
    final statsAsync = isMyCare
        ? ref.watch(analyticsStatsProvider)
        : const AsyncValue<AnalyticsStats>.loading();
    final correlationAsync = isMyCare
        ? ref.watch(correlationChartProvider)
        : const AsyncValue<CorrelationSummary>.loading();
    final selectedMetric = ref.watch(selectedChartMetricProvider);
    final selectedCourseFilter = ref.watch(
      selectedAnalyticsCourseFilterProvider,
    );

    final bottomSafeArea = MediaQuery.paddingOf(context).bottom;
    final bottomNavHeight = 85.0 + bottomSafeArea;

    String getMetricName(MeasurementTypeEnum type) {
      switch (type) {
        case MeasurementTypeEnum.bloodPressure:
          return l10n.bloodPressure;
        case MeasurementTypeEnum.heartRate:
          return l10n.heartRate;
        case MeasurementTypeEnum.weight:
          return l10n.weight;
        case MeasurementTypeEnum.bloodSugar:
          return l10n.bloodSugar;
        default:
          return '';
      }
    }

    return GradientScaffold(
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 118,
            pinned: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              titlePadding: const EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: 16,
              ),
              title: Text(
                selectedContext == AppCareContext.myCare
                    ? l10n.analyticsTitle
                    : l10n.settingsCaregiverConnectedInboxTitle,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: theme.colorScheme.onSurface,
                  letterSpacing: -0.5,
                ),
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
          SliverPadding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 12,
              bottom: bottomNavHeight + 24,
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                if (hasCaregivingContext) ...[
                  AnimatedReveal(
                    delay: const Duration(milliseconds: 40),
                    child: CareContextSwitcher(
                      selectedContext: selectedContext,
                      personalLabel: displayName,
                      caregivingLabel:
                      caregiverCloudState.caregiverLinkedPatientName ??
                          l10n.settingsCaregiverConnectedTitle,
                      onChanged: (value) {
                        ref.read(selectedCareContextProvider.notifier).state =
                            value;
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
                if (selectedContext == AppCareContext.caregiving)
                  AnimatedReveal(
                    delay: const Duration(milliseconds: 90),
                    child: _CaregivingAnalyticsCard(
                      linkedPatientName:
                      caregiverCloudState.caregiverLinkedPatientName ??
                          l10n.defaultUserName,
                      alerts: caregiverCloudAlerts,
                    ),
                  )
                else ...[
                  AnimatedReveal(
                    delay: const Duration(milliseconds: 50),
                    child: _AnalyticsCourseFilterChips(
                      selectedFilter: selectedCourseFilter,
                      labelBuilder: (filter) =>
                          _courseFilterLabel(context, filter),
                      onSelected: (filter) {
                        ref
                            .read(
                          selectedAnalyticsCourseFilterProvider.notifier,
                        )
                            .state =
                            filter;
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  statsAsync.when(
                    data: (stats) {
                      final isGoodRate = stats.adherenceRate >= 80.0;
                      final rateColor = isGoodRate
                          ? theme.successAccent
                          : theme.dangerAccent;

                      return AnimatedReveal(
                        delay: const Duration(milliseconds: 120),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _SectionHeader(
                              title: l10n.adherenceRate,
                              subtitle: l10n.adherenceSubtitle,
                            ),
                            const SizedBox(height: 12),
                            _AdherenceHeroCard(
                              adherenceRate: stats.adherenceRate,
                              takenDoses: stats.takenDoses,
                              missedDoses: stats.missedDoses,
                              rateColor: rateColor,
                              l10n: l10n,
                            ),
                            const SizedBox(height: 12),
                            GlassContainer(
                              padding: const EdgeInsets.all(16),
                              color: theme.colorScheme.surface.withValues(
                                alpha: 0.42,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    l10n.analyticsCourseMix,
                                    style: theme.textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    l10n.analyticsCourseMixSubtitle,
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: theme.colorScheme.onSurface
                                          .withValues(alpha: 0.6),
                                      height: 1.35,
                                    ),
                                  ),
                                  const SizedBox(height: 14),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: _CourseTypeBreakdownCard(
                                          icon: Icons.medication_rounded,
                                          title: l10n.courseFilterMedications,
                                          activeCourses:
                                          stats.activeMedicationCourses,
                                          takenDoses: stats.medicationTakenDoses,
                                          missedDoses:
                                          stats.medicationMissedDoses,
                                          color: theme.brandPrimary,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: _CourseTypeBreakdownCard(
                                          icon: Icons.spa_rounded,
                                          title: l10n.courseFilterSupplements,
                                          activeCourses:
                                          stats.activeSupplementCourses,
                                          takenDoses: stats.supplementTakenDoses,
                                          missedDoses:
                                          stats.supplementMissedDoses,
                                          color: theme.supplementAccent,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: _SummaryInfoCard(
                                    icon: Icons.local_fire_department_rounded,
                                    title: l10n.analyticsCurrentRoutine,
                                    value: '${stats.currentStreak}',
                                    color: theme.brandPrimary,
                                    subtitle:
                                    l10n.analyticsCurrentRoutineSubtitle,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: _SummaryInfoCard(
                                    icon: Icons.timer_outlined,
                                    title: l10n.analyticsTimingAccuracy,
                                    value: '${stats.onTimeRate.round()}%',
                                    color: theme.successAccent,
                                    subtitle:
                                    l10n.analyticsTimingAccuracySubtitle,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(
                                  child: _SummaryInfoCard(
                                    icon: Icons.workspace_premium_rounded,
                                    title: l10n.analyticsBestRoutine,
                                    value: '${stats.longestStreak}',
                                    color: theme.warningAccent,
                                    subtitle: l10n.analyticsBestRoutineSubtitle,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: _SummaryInfoCard(
                                    icon: Icons.inventory_2_outlined,
                                    title: l10n.analyticsRefillRisk,
                                    value: stats.lowStockCourses.toString(),
                                    color: theme.dangerAccent,
                                    subtitle: l10n.analyticsRefillRiskSubtitle,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            GlassContainer(
                              padding: const EdgeInsets.all(16),
                              color: theme.colorScheme.surface.withValues(
                                alpha: 0.42,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: _MiniInsight(
                                      label: l10n.analyticsAverageDelay,
                                      value:
                                      '${stats.averageDelayMinutes.round()} ${l10n.analyticsMinutesShort}',
                                    ),
                                  ),
                                  Container(
                                    width: 1,
                                    height: 36,
                                    color: theme.dividerColor.withValues(
                                      alpha: 0.25,
                                    ),
                                  ),
                                  Expanded(
                                    child: _MiniInsight(
                                      label: l10n.activeCourses,
                                      value: stats.activeCourses.toString(),
                                    ),
                                  ),
                                  Container(
                                    width: 1,
                                    height: 36,
                                    color: theme.dividerColor.withValues(
                                      alpha: 0.25,
                                    ),
                                  ),
                                  Expanded(
                                    child: _MiniInsight(
                                      label: l10n.analyticsMissedDoses,
                                      value: stats.missedDoses.toString(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),
                            _CoachCard(stats: stats),
                          ],
                        ),
                      );
                    },
                    loading: () => const _SectionLoading(height: 320),
                    error: (e, _) => _SectionError(
                      title: l10n.failedToLoadAdherence,
                      message: e.toString(),
                    ),
                  ),
                  const SizedBox(height: 28),
                  AnimatedReveal(
                    delay: const Duration(milliseconds: 210),
                    child: _SectionHeader(
                      title: l10n.healthCorrelationTitle,
                      subtitle: l10n.healthCorrelationSubtitle,
                    ),
                  ),
                  const SizedBox(height: 12),
                  AnimatedReveal(
                    delay: const Duration(milliseconds: 250),
                    child: _MetricSelector(
                      selectedMetric: selectedMetric,
                      getMetricName: getMetricName,
                      onSelected: (type) {
                        ref.read(selectedChartMetricProvider.notifier).state =
                            type;
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  AnimatedReveal(
                    delay: const Duration(milliseconds: 300),
                    child: GlassContainer(
                      padding: const EdgeInsets.all(16),
                      color: theme.colorScheme.surface.withValues(alpha: 0.45),
                      child: correlationAsync.when(
                        data: (summary) {
                          if (summary.dailyData.isEmpty) {
                            return _EmptyChartState(l10n: l10n);
                          }

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Wrap(
                                spacing: 10,
                                runSpacing: 10,
                                children: [
                                  _TopPillBadge(
                                    label: l10n.last7Days,
                                    icon: Icons.calendar_view_week_rounded,
                                  ),
                                  _TopPillBadge(
                                    label: l10n.avgAdherence(
                                      summary.avgAdherence.toStringAsFixed(0),
                                    ),
                                    icon: Icons.show_chart_rounded,
                                  ),
                                  if (summary.avgMeasurement != null)
                                    _TopPillBadge(
                                      label: l10n.avgMetric(
                                        getMetricName(selectedMetric),
                                        summary.avgMeasurement!.toStringAsFixed(
                                          0,
                                        ),
                                      ),
                                      icon: Icons.favorite_outline_rounded,
                                    ),
                                ],
                              ),
                              const SizedBox(height: 18),
                              // 🚀 ИСПРАВЛЕНИЕ: Используем Wrap вместо Row для легенды
                              Center(
                                child: Wrap(
                                  alignment: WrapAlignment.center,
                                  spacing: 18,
                                  runSpacing: 8,
                                  children: [
                                    _LegendItem(
                                      color: theme.successAccent,
                                      label: l10n.pillsTaken,
                                    ),
                                    _LegendItem(
                                      color: theme.colorScheme.primary,
                                      label: getMetricName(selectedMetric),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 22),
                              _CorrelationChart(
                                data: summary.dailyData,
                                maxMeasurement: summary.maxMeasurement,
                              ),
                            ],
                          );
                        },
                        loading: () => const _SectionLoading(height: 250),
                        error: (e, _) => _SectionError(
                          title: l10n.failedToLoadChart,
                          message: e.toString(),
                        ),
                      ),
                    ),
                  ),
                ],
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _CaregivingAnalyticsCard extends StatelessWidget {
  final String linkedPatientName;
  final List<CaregiverCloudAlert> alerts;

  const _CaregivingAnalyticsCard({
    required this.linkedPatientName,
    required this.alerts,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).languageCode;
    final timeFormat = DateFormat.MMMd(locale).add_Hm();
    final latestAlert = alerts.isEmpty ? null : alerts.first;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(
          title: linkedPatientName,
          subtitle: l10n.settingsCaregiverConnectedModeCaregiver(
            linkedPatientName,
          ),
        ),
        const SizedBox(height: 12),
        GlassContainer(
          padding: const EdgeInsets.all(16),
          color: theme.warningAccent.withValues(alpha: 0.08),
          child: Row(
            children: [
              Expanded(
                child: _MiniInsight(
                  label: l10n.settingsCaregiverConnectedInboxTitle,
                  value: alerts.length.toString(),
                ),
              ),
              Container(
                width: 1,
                height: 36,
                color: theme.dividerColor.withValues(alpha: 0.25),
              ),
              Expanded(
                child: _MiniInsight(
                  label: l10n.last7Days,
                  value: latestAlert == null
                      ? '-'
                      : DateFormat.Hm(locale).format(latestAlert.createdAt),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        if (alerts.isEmpty)
          GlassContainer(
            padding: const EdgeInsets.all(18),
            color: theme.successAccent.withValues(alpha: 0.06),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.settingsCaregiverConnectedInboxEmpty,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  l10n.settingsCaregiverConnectedReady,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.65),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          )
        else
          ...alerts.map(
                (alert) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: GlassContainer(
                padding: const EdgeInsets.all(16),
                color: theme.colorScheme.surface.withValues(alpha: 0.44),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      alert.patientName,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      alert.message,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        height: 1.4,
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.7,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      timeFormat.format(alert.createdAt),
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
            ),
          ),
      ],
    );
  }
}

class _CoachCard extends StatelessWidget {
  final AnalyticsStats stats;

  const _CoachCard({required this.stats});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    String message;
    if (stats.adherenceRate >= 90 && stats.onTimeRate >= 75) {
      message = l10n.analyticsCoachGreat;
    } else if (stats.missedDoses > 0) {
      message = l10n.analyticsCoachMissed;
    } else {
      message = l10n.analyticsCoachTiming;
    }

    return GlassContainer(
      padding: const EdgeInsets.all(16),
      color: theme.primaryColor.withValues(alpha: 0.06),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: theme.primaryColor.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              Icons.psychology_alt_rounded,
              color: theme.primaryColor,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.analyticsCoachNote,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  message,
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

class _MiniInsight extends StatelessWidget {
  final String label;
  final String value;

  const _MiniInsight({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Text(
          value,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.56),
          ),
        ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const _SectionHeader({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w800,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.58),
            height: 1.35,
          ),
        ),
      ],
    );
  }
}

class _AdherenceHeroCard extends StatelessWidget {
  final double adherenceRate;
  final int takenDoses;
  final int missedDoses;
  final Color rateColor;
  final AppLocalizations l10n;

  const _AdherenceHeroCard({
    required this.adherenceRate,
    required this.takenDoses,
    required this.missedDoses,
    required this.rateColor,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final total = takenDoses + missedDoses;

    return GlassContainer(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      color: rateColor.withValues(alpha: 0.06),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  l10n.overallAdherence,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: rateColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  adherenceRate >= 80
                      ? l10n.statusGood
                      : l10n.statusNeedsAttention,
                  style: theme.textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: rateColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          SizedBox(
            width: 180,
            height: 180,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  value: adherenceRate / 100,
                  strokeWidth: 14,
                  backgroundColor: rateColor.withValues(alpha: 0.14),
                  valueColor: AlwaysStoppedAnimation<Color>(rateColor),
                  strokeCap: StrokeCap.round,
                ),
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${adherenceRate.toStringAsFixed(0)}%',
                        style: theme.textTheme.displayLarge?.copyWith(
                          fontSize: 38,
                          fontWeight: FontWeight.w900,
                          color: rateColor,
                          letterSpacing: -1,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        l10n.last7Days,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurface.withValues(
                            alpha: 0.55,
                          ),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface.withValues(alpha: 0.30),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _HeroBottomStat(
                    label: l10n.statTaken,
                    value: takenDoses.toString(),
                    color: theme.successAccent,
                  ),
                ),
                Container(
                  width: 1,
                  height: 36,
                  color: theme.dividerColor.withValues(alpha: 0.35),
                ),
                Expanded(
                  child: _HeroBottomStat(
                    label: l10n.statSkipped,
                    value: missedDoses.toString(),
                    color: theme.dangerAccent,
                  ),
                ),
                Container(
                  width: 1,
                  height: 36,
                  color: theme.dividerColor.withValues(alpha: 0.35),
                ),
                Expanded(
                  child: _HeroBottomStat(
                    label: l10n.statTotal,
                    value: total.toString(),
                    color: theme.brandPrimary,
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

class _HeroBottomStat extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _HeroBottomStat({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Text(
          value,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w800,
            color: color,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.55),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _SummaryInfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final String subtitle;
  final Color color;

  const _SummaryInfoCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.subtitle,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GlassContainer(
      padding: const EdgeInsets.all(16),
      color: color.withValues(alpha: 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 14),
          Text(
            value,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w900,
              color: theme.colorScheme.onSurface,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: theme.colorScheme.onSurface,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 3),
          Text(
            subtitle,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.55),
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _AnalyticsCourseFilterChips extends StatelessWidget {
  final AnalyticsCourseFilterType selectedFilter;
  final ValueChanged<AnalyticsCourseFilterType> onSelected;
  final String Function(AnalyticsCourseFilterType filter) labelBuilder;

  const _AnalyticsCourseFilterChips({
    required this.selectedFilter,
    required this.onSelected,
    required this.labelBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: AnalyticsCourseFilterType.values.map((filter) {
          final isSelected = filter == selectedFilter;
          final color = filter == AnalyticsCourseFilterType.supplements
              ? theme.supplementAccent
              : theme.brandPrimary;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(labelBuilder(filter)),
              selected: isSelected,
              onSelected: (_) => onSelected(filter),
              selectedColor: color,
              backgroundColor: theme.colorScheme.surface.withValues(
                alpha: 0.35,
              ),
              side: BorderSide.none,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              showCheckmark: false,
              labelStyle: TextStyle(
                color: isSelected
                    ? Colors.white
                    : theme.colorScheme.onSurface.withValues(alpha: 0.70),
                fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _CourseTypeBreakdownCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final int activeCourses;
  final int takenDoses;
  final int missedDoses;
  final Color color;

  const _CourseTypeBreakdownCard({
    required this.icon,
    required this.title,
    required this.activeCourses,
    required this.takenDoses,
    required this.missedDoses,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return GlassContainer(
      padding: const EdgeInsets.all(16),
      borderRadius: 20,
      color: color.withValues(alpha: 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 14),
          Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w800,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 10),
          Text(
            l10n.analyticsActiveShort(activeCourses),
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w900,
              color: theme.colorScheme.onSurface,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 10),
          Text(
            l10n.analyticsTakenMissed(takenDoses, missedDoses),
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.65),
              height: 1.4,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _MetricSelector extends StatelessWidget {
  final MeasurementTypeEnum selectedMetric;
  final String Function(MeasurementTypeEnum type) getMetricName;
  final ValueChanged<MeasurementTypeEnum> onSelected;

  const _MetricSelector({
    required this.selectedMetric,
    required this.getMetricName,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final metrics = [
      MeasurementTypeEnum.bloodPressure,
      MeasurementTypeEnum.heartRate,
      MeasurementTypeEnum.weight,
      MeasurementTypeEnum.bloodSugar,
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: metrics.map((type) {
          final isSelected = selectedMetric == type;

          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(getMetricName(type)),
              selected: isSelected,
              onSelected: (_) => onSelected(type),
              selectedColor: theme.colorScheme.primary,
              backgroundColor: theme.colorScheme.surface.withValues(
                alpha: 0.35,
              ),
              side: BorderSide.none,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              showCheckmark: false,
              labelStyle: TextStyle(
                color: isSelected
                    ? Colors.white
                    : theme.colorScheme.onSurface.withValues(alpha: 0.70),
                fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _CorrelationChart extends StatelessWidget {
  final List<DailyCorrelation> data;
  final double maxMeasurement;

  const _CorrelationChart({required this.data, required this.maxMeasurement});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const double chartHeight = 180.0;

    return SizedBox(
      height: chartHeight + 46,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(data.length, (index) {
          final dayData = data[index];
          final adherenceFactor = dayData.adherencePct.clamp(0, 100) / 100.0;
          final measurementValue = dayData.measurementValue;
          final measurementFactor = measurementValue == null
              ? 0.0
              : (measurementValue / (maxMeasurement * 1.15)).clamp(0.0, 1.0);

          final dayName = DateFormat.E(
            Localizations.localeOf(context).languageCode,
          ).format(dayData.date);

          return Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: index == data.length - 1 ? 0 : 6),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (measurementValue != null)
                    Text(
                      measurementValue.toStringAsFixed(0),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w800,
                      ),
                    )
                  else
                    SizedBox(
                      height: 16,
                      child: Text(
                        '-',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onSurface.withValues(
                            alpha: 0.30,
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(height: 6),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          _AnimatedBar(
                            width: 14,
                            height: chartHeight * adherenceFactor,
                            color: adherenceFactor > 0
                                ? theme.successAccent
                                : theme.dividerColor.withValues(alpha: 0.15),
                          ),
                          const SizedBox(width: 4),
                          _AnimatedBar(
                            width: 14,
                            height: chartHeight * measurementFactor,
                            color: measurementValue != null
                                ? theme.colorScheme.primary
                                : Colors.transparent,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    dayName,
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: theme.colorScheme.onSurface.withValues(
                        alpha: 0.55,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _AnimatedBar extends StatelessWidget {
  final double width;
  final double height;
  final Color color;

  const _AnimatedBar({
    required this.width,
    required this.height,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 450),
      curve: Curves.easeOutCubic,
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}

class _TopPillBadge extends StatelessWidget {
  final IconData icon;
  final String label;

  const _TopPillBadge({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GlassContainer(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      borderRadius: 999,
      color: theme.colorScheme.surface.withValues(alpha: 0.44),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 15,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.68),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.72),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionLoading extends StatelessWidget {
  final double height;

  const _SectionLoading({required this.height});

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      padding: EdgeInsets.zero,
      child: SizedBox(
        height: height,
        child: const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

class _SectionError extends StatelessWidget {
  final String title;
  final String message;

  const _SectionError({required this.title, required this.message});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GlassContainer(
      padding: const EdgeInsets.all(16),
      color: theme.dangerAccent.withValues(alpha: 0.05),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.error_outline_rounded, color: theme.dangerAccent),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  message,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.62),
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

class _EmptyChartState extends StatelessWidget {
  final AppLocalizations l10n;

  const _EmptyChartState({required this.l10n});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      height: 220,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.query_stats_rounded,
              size: 36,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.35),
            ),
            const SizedBox(height: 12),
            Text(
              l10n.noDataYet,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              l10n.noDataDescription,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.55),
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 🚀 ИСПРАВЛЕНИЕ: Убрали Flexible внутри _LegendItem, чтобы он сам принимал нужный размер
class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendItem({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisSize: MainAxisSize.min, // Важно! Ограничиваем Row по контенту
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w700,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.72),
          ),
        ),
      ],
    );
  }
}