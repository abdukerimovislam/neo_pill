import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../l10n/app_localizations.dart';
import '../providers/analytics_provider.dart';
import '../../../data/local/entities/measurement_entity.dart';
import '../../../core/presentation/widgets/gradient_scaffold.dart';
import '../../../core/presentation/widgets/glass_container.dart';

class AnalyticsScreen extends ConsumerWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    final statsAsync = ref.watch(analyticsStatsProvider);
    final correlationAsync = ref.watch(correlationChartProvider);
    final selectedMetric = ref.watch(selectedChartMetricProvider);

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
              titlePadding: const EdgeInsets.only(left: 20, right: 20, bottom: 16),
              title: Text(
                l10n.analyticsTitle,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: theme.colorScheme.onSurface,
                  letterSpacing: -0.4,
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
              left: 20,
              right: 20,
              top: 12,
              bottom: bottomNavHeight + 24,
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  statsAsync.when(
                    data: (stats) {
                      final isGoodRate = stats.adherenceRate >= 80.0;
                      final rateColor = isGoodRate
                          ? theme.colorScheme.secondary
                          : theme.colorScheme.error;

                      return Column(
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
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: _SummaryInfoCard(
                                  icon: Icons.check_circle_rounded,
                                  title: l10n.statusTaken,
                                  value: stats.takenDoses.toString(),
                                  color: theme.colorScheme.secondary,
                                  subtitle: l10n.completedDosesSubtitle,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _SummaryInfoCard(
                                  icon: Icons.cancel_rounded,
                                  title: l10n.statusSkipped,
                                  value: stats.missedDoses.toString(),
                                  color: theme.colorScheme.error,
                                  subtitle: l10n.missedDosesSubtitle,
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                    loading: () => const _SectionLoading(height: 320),
                    error: (e, _) => _SectionError(
                      title: l10n.failedToLoadAdherence,
                      message: e.toString(),
                    ),
                  ),
                  const SizedBox(height: 28),
                  _SectionHeader(
                    title: l10n.healthCorrelationTitle,
                    subtitle: l10n.healthCorrelationSubtitle,
                  ),
                  const SizedBox(height: 12),
                  _MetricSelector(
                    selectedMetric: selectedMetric,
                    getMetricName: getMetricName,
                    onSelected: (type) {
                      ref.read(selectedChartMetricProvider.notifier).state = type;
                    },
                  ),
                  const SizedBox(height: 16),
                  GlassContainer(
                    padding: const EdgeInsets.all(18),
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
                                  label: l10n.avgAdherence(summary.avgAdherence.toStringAsFixed(0)),
                                  icon: Icons.show_chart_rounded,
                                ),
                                if (summary.avgMeasurement != null)
                                  _TopPillBadge(
                                    label: l10n.avgMetric(getMetricName(selectedMetric), summary.avgMeasurement!.toStringAsFixed(0)),
                                    icon: Icons.favorite_outline_rounded,
                                  ),
                              ],
                            ),
                            const SizedBox(height: 18),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _LegendItem(
                                  color: theme.colorScheme.secondary,
                                  label: l10n.pillsTaken,
                                ),
                                const SizedBox(width: 18),
                                _LegendItem(
                                  color: theme.colorScheme.primary,
                                  label: getMetricName(selectedMetric),
                                ),
                              ],
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const _SectionHeader({
    required this.title,
    required this.subtitle,
  });

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
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
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
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                decoration: BoxDecoration(
                  color: rateColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  adherenceRate >= 80 ? l10n.statusGood : l10n.statusNeedsAttention,
                  style: theme.textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: rateColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
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
                          color: theme.colorScheme.onSurface.withValues(alpha: 0.55),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
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
                    color: theme.colorScheme.secondary,
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
                    color: theme.colorScheme.error,
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
                    color: theme.colorScheme.primary,
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
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w900,
              color: theme.colorScheme.onSurface,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            subtitle,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.55),
            ),
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
              backgroundColor: theme.colorScheme.surface.withValues(alpha: 0.35),
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

  const _CorrelationChart({
    required this.data,
    required this.maxMeasurement,
  });

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

          final adherenceFactor = (dayData.adherencePct).clamp(0, 100) / 100.0;
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
                        '—',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onSurface.withValues(alpha: 0.30),
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
                                ? theme.colorScheme.secondary
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
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.55),
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

  const _TopPillBadge({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withValues(alpha: 0.38),
        borderRadius: BorderRadius.circular(999),
      ),
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
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

class _SectionError extends StatelessWidget {
  final String title;
  final String message;

  const _SectionError({
    required this.title,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GlassContainer(
      padding: const EdgeInsets.all(18),
      color: theme.colorScheme.error.withValues(alpha: 0.05),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.error_outline_rounded,
            color: theme.colorScheme.error,
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
                color: theme.colorScheme.onSurface,
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

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendItem({
    required this.color,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
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