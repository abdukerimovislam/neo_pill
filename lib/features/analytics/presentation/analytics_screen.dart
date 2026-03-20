import 'dart:math';
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

    // Локализованные названия метрик (без arb для простоты)
    String getMetricName(MeasurementTypeEnum type) {
      switch (type) {
        case MeasurementTypeEnum.bloodPressure: return l10n.bloodPressure;
        case MeasurementTypeEnum.heartRate: return l10n.heartRate;
        case MeasurementTypeEnum.weight: return l10n.weight;
        case MeasurementTypeEnum.bloodSugar: return l10n.bloodSugar;
        default: return '';
      }
    }

    return GradientScaffold(
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 120.0,
            floating: false,
            pinned: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(bottom: 16),
              title: Text(
                l10n.analyticsTitle,
                style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold, color: theme.colorScheme.onSurface, letterSpacing: -0.5),
              ),
              background: Container(
                decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [theme.scaffoldBackgroundColor, theme.scaffoldBackgroundColor.withOpacity(0.0)])),
              ),
            ),
          ),

          SliverPadding(
            padding: EdgeInsets.only(top: 8.0, left: 20.0, right: 20.0, bottom: bottomNavHeight + 24.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate([

                // --- ГЛАВНОЕ КОЛЬЦО (Adherence) ---
                statsAsync.when(
                  data: (stats) {
                    final isGoodRate = stats.adherenceRate >= 80.0;
                    final rateColor = isGoodRate ? theme.colorScheme.secondary : theme.colorScheme.error;

                    return GlassContainer(
                      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                      color: rateColor.withOpacity(0.05),
                      child: Column(
                        children: [
                          Text(l10n.adherenceRate, style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.onSurface.withOpacity(0.6), fontWeight: FontWeight.bold)),
                          const SizedBox(height: 32),
                          SizedBox(
                            height: 160, width: 160,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                CircularProgressIndicator(
                                  value: stats.adherenceRate / 100,
                                  strokeWidth: 14, backgroundColor: rateColor.withOpacity(0.15),
                                  valueColor: AlwaysStoppedAnimation<Color>(rateColor), strokeCap: StrokeCap.round,
                                ),
                                Center(
                                  child: Text('${stats.adherenceRate.toStringAsFixed(0)}%', style: theme.textTheme.displayLarge?.copyWith(fontSize: 40, fontWeight: FontWeight.bold, color: rateColor)),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 32),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _MiniStat(title: l10n.statusTaken, value: stats.takenDoses.toString(), color: theme.colorScheme.secondary),
                              Container(height: 30, width: 1, margin: const EdgeInsets.symmetric(horizontal: 16), color: theme.dividerColor.withOpacity(0.2)),
                              _MiniStat(title: l10n.statusSkipped, value: stats.missedDoses.toString(), color: theme.colorScheme.error),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (e, _) => const SizedBox(),
                ),
                const SizedBox(height: 32),

                // --- 🚀 НОВОЕ: ГРАФИК КОРРЕЛЯЦИИ ---
                Text('Health Correlation', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: theme.colorScheme.onSurface.withOpacity(0.6))),
                const SizedBox(height: 12),

                // Переключатель метрик
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Row(
                    children: [MeasurementTypeEnum.bloodPressure, MeasurementTypeEnum.heartRate, MeasurementTypeEnum.weight, MeasurementTypeEnum.bloodSugar].map((type) {
                      final isSelected = selectedMetric == type;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ChoiceChip(
                          label: Text(getMetricName(type)),
                          selected: isSelected,
                          onSelected: (_) => ref.read(selectedChartMetricProvider.notifier).state = type,
                          selectedColor: theme.primaryColor,
                          backgroundColor: theme.colorScheme.surface.withOpacity(0.4),
                          labelStyle: TextStyle(color: isSelected ? Colors.white : theme.textTheme.bodyMedium?.color, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide.none),
                          showCheckmark: false,
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 16),

                // Сам График
                GlassContainer(
                  padding: const EdgeInsets.all(20),
                  color: theme.colorScheme.surface.withOpacity(0.4),
                  child: correlationAsync.when(
                    data: (data) {
                      if (data.isEmpty) return const Center(child: Text('No data yet'));

                      // Ищем максимальное значение для нормализации высоты столбцов здоровья
                      double maxMeasurement = data.map((e) => e.measurementValue ?? 0.0).fold(0.0, max);
                      if (maxMeasurement == 0) maxMeasurement = 100; // Защита от деления на ноль

                      // Высота холста графика
                      const double chartHeight = 150.0;

                      return Column(
                        children: [
                          // Легенда
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _LegendItem(color: theme.colorScheme.secondary, label: "Pills Taken"),
                              const SizedBox(width: 16),
                              _LegendItem(color: theme.primaryColor, label: getMetricName(selectedMetric)),
                            ],
                          ),
                          const SizedBox(height: 24),

                          // Столбцы (7 дней)
                          SizedBox(
                            height: chartHeight,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: data.map((dayData) {

                                // Вычисляем высоту столбцов (от 0 до 1)
                                final adherenceFactor = dayData.adherencePct / 100.0;
                                final measurementFactor = (dayData.measurementValue ?? 0.0) / (maxMeasurement * 1.2); // *1.2 чтобы не упиралось в потолок

                                final dayName = DateFormat.E(Localizations.localeOf(context).languageCode).format(dayData.date);

                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    // Тултип со значением над баром здоровья
                                    if (dayData.measurementValue != null)
                                      Text(
                                        dayData.measurementValue!.toStringAsFixed(0),
                                        style: theme.textTheme.labelSmall?.copyWith(color: theme.primaryColor, fontWeight: FontWeight.bold, fontSize: 10),
                                      )
                                    else
                                      const SizedBox(height: 14), // Пустое место, чтобы бары не прыгали

                                    const SizedBox(height: 4),

                                    // Двойной бар
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        // Бар таблеток
                                        AnimatedContainer(
                                          duration: const Duration(milliseconds: 500),
                                          width: 12,
                                          height: chartHeight * 0.7 * adherenceFactor,
                                          decoration: BoxDecoration(
                                            color: adherenceFactor > 0 ? theme.colorScheme.secondary : theme.dividerColor.withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(4),
                                          ),
                                        ),
                                        const SizedBox(width: 2),
                                        // Бар здоровья
                                        AnimatedContainer(
                                          duration: const Duration(milliseconds: 500),
                                          width: 12,
                                          height: chartHeight * 0.7 * measurementFactor,
                                          decoration: BoxDecoration(
                                            color: dayData.measurementValue != null ? theme.primaryColor : Colors.transparent,
                                            borderRadius: BorderRadius.circular(4),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Text(dayName, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurface.withOpacity(0.5), fontWeight: FontWeight.bold)),
                                  ],
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      );
                    },
                    loading: () => const Center(child: CircularProgressIndicator()),
                    error: (e, _) => Center(child: Text('Error: $e')),
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

// Вспомогательные виджеты
class _MiniStat extends StatelessWidget {
  final String title;
  final String value;
  final Color color;

  const _MiniStat({required this.title, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: color)),
        Text(title, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5))),
      ],
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendItem({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 12, height: 12, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(3))),
        const SizedBox(width: 6),
        Text(label, style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold)),
      ],
    );
  }
}