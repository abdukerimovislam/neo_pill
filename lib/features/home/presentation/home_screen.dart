import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../l10n/app_localizations.dart';

import '../../settings/provider/settings_provider.dart';
import 'widgets/horizontal_calendar.dart';
import 'widgets/dose_card.dart';
import 'widgets/sos_panel.dart';
import 'widgets/pill_icon_widget.dart';
import '../providers/home_provider.dart';
import '../providers/home_controller.dart';
import '../../medicine_management/presentation/add_medicine_screen.dart';
import '../../measurements/presentation/widgets/add_measurement_modal.dart';
import '../../../core/presentation/widgets/gradient_scaffold.dart';
import '../../../core/presentation/widgets/glass_container.dart';
import '../../../data/local/entities/dose_log_entity.dart';
// 🚀 ДОБАВЛЕН ИМПОРТ ПРОВАЙДЕРА НАСТРОЕК

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  void _showActionCenter(BuildContext context, ThemeData theme, AppLocalizations l10n) {
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
                  spreadRadius: 10
              )
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
                        borderRadius: BorderRadius.circular(3)
                    )
                ),
                const SizedBox(height: 24),
                Text(
                    l10n.whatWouldYouLikeToDo,
                    style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)
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
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => const AddMedicineScreen()));
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
                        builder: (_) => const AddMeasurementModal()
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

    // 🚀 ПОДТЯГИВАЕМ ИМЯ ИЗ НАСТРОЕК
    final userName = ref.watch(userNameProvider);

    final bottomSafeArea = MediaQuery.paddingOf(context).bottom;
    const glassNavHeight = 85.0;
    final totalBottomPadding = glassNavHeight + bottomSafeArea + 120.0;

    int totalDoses = 0;
    int takenDoses = 0;
    scheduleAsyncValue.whenData((items) {
      totalDoses = items.length;
      takenDoses = items.where((i) => i.doseLog.status == DoseStatusEnum.taken).length;
    });
    final progress = totalDoses > 0 ? (takenDoses / totalDoses) : 0.0;

    final hour = DateTime.now().hour;
    final greeting = hour < 12 ? l10n.goodMorning : (hour < 18 ? l10n.goodAfternoon : l10n.goodEvening);

    return GradientScaffold(
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        slivers: [
          SliverAppBar(
            expandedHeight: 118.0,
            floating: false,
            pinned: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            surfaceTintColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(left: 20, right: 20, bottom: 16),
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
                              color: theme.colorScheme.onSurface.withValues(alpha: 0.5)
                          )
                      ),
                      Text(
                          userName, // 🚀 ТЕПЕРЬ ЗДЕСЬ ДИНАМИЧЕСКОЕ ИМЯ
                          style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.w900,
                              letterSpacing: -0.5,
                              color: theme.colorScheme.onSurface
                          )
                      ),
                    ],
                  ),
                  Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: theme.colorScheme.surface.withValues(alpha: 0.8)
                      ),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          CircularProgressIndicator(
                            value: progress,
                            strokeWidth: 4,
                            color: theme.colorScheme.secondary,
                            backgroundColor: theme.colorScheme.secondary.withValues(alpha: 0.14),
                            strokeCap: StrokeCap.round,
                          ),
                          Center(
                              child: Icon(
                                  progress == 1.0 && totalDoses > 0 ? Icons.check_rounded : Icons.local_pharmacy_rounded,
                                  color: theme.colorScheme.secondary,
                                  size: 18
                              )
                          ),
                        ],
                      )
                  )
                ],
              ),
              background: DecoratedBox(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            theme.scaffoldBackgroundColor.withValues(alpha: 0.92),
                            theme.scaffoldBackgroundColor.withValues(alpha: 0.0)
                          ]
                      )
                  )
              ),
            ),
          ),

          const SliverToBoxAdapter(
              child: Padding(
                  padding: EdgeInsets.only(top: 12.0, bottom: 24.0),
                  child: HorizontalCalendar()
              )
          ),

          // HERO-БЛОК (Стиль Analytics)
          heroAsyncValue.when(
            data: (heroItem) {
              if (heroItem == null) return const SliverToBoxAdapter(child: SizedBox.shrink());

              final medicine = heroItem.medicine;
              final timeString = DateFormat.Hm(Localizations.localeOf(context).languageCode).format(heroItem.doseLog.scheduledTime);
              final rawDosage = heroItem.doseLog.dosage > 0 ? heroItem.doseLog.dosage : (medicine?.dosage ?? 0);
              final dosage = rawDosage % 1 == 0 ? rawDosage.toInt().toString() : rawDosage.toString();

              return SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, bottom: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          l10n.priorityAction,
                          style: theme.textTheme.labelSmall?.copyWith(
                              color: theme.primaryColor,
                              letterSpacing: 1.5,
                              fontWeight: FontWeight.w900
                          )
                      ),
                      const SizedBox(height: 12),
                      GlassContainer(
                        padding: const EdgeInsets.all(24),
                        color: theme.primaryColor.withValues(alpha: 0.06),
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
                                            BoxShadow(color: Color(medicine.pillColor).withValues(alpha: 0.2), blurRadius: 12)
                                          ]
                                      ),
                                      child: Center(
                                          child: PillIconWidget(shape: medicine.pillShape, colorHex: medicine.pillColor, size: 28)
                                      )
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
                                              letterSpacing: -0.5
                                          )
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                          medicine?.name ?? l10n.unknownMedicine,
                                          style: theme.textTheme.titleMedium?.copyWith(
                                              fontWeight: FontWeight.w800,
                                              color: theme.colorScheme.onSurface
                                          )
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                          '$dosage ${medicine?.dosageUnit}',
                                          style: theme.textTheme.bodyMedium?.copyWith(
                                              color: theme.colorScheme.onSurface.withValues(alpha: 0.6)
                                          )
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 24),
                            SizedBox(
                                width: double.infinity,
                                height: 56,
                                child: ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: theme.primaryColor,
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                      elevation: 0,
                                    ),
                                    onPressed: () {
                                      ref.read(homeControllerProvider).updateDoseStatus(heroItem.doseLog, DoseStatusEnum.taken);
                                      ref.invalidate(heroDoseProvider);
                                    },
                                    icon: const Icon(Icons.check_circle_rounded, size: 26),
                                    label: Text(
                                        l10n.takeNowAction,
                                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, letterSpacing: 0.5)
                                    )
                                )
                            ),
                            const SizedBox(height: 12),
                            GestureDetector(
                                onTap: () {
                                  ref.read(homeControllerProvider).updateDoseStatus(heroItem.doseLog, DoseStatusEnum.skipped);
                                  ref.invalidate(heroDoseProvider);
                                },
                                child: Text(
                                    l10n.skipDoseAction,
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                        color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                                        fontWeight: FontWeight.w600
                                    )
                                )
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            loading: () => const SliverToBoxAdapter(child: SizedBox.shrink()),
            error: (_, __) => const SliverToBoxAdapter(child: SizedBox.shrink()),
          ),

          const SliverToBoxAdapter(child: SosPanel()),

          scheduleAsyncValue.when(
            data: (scheduleItems) {
              final currentHero = ref.read(heroDoseProvider).valueOrNull;
              final filteredItems = scheduleItems.where((item) => currentHero == null || item.doseLog.id != currentHero.doseLog.id).toList();

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
                                color: theme.colorScheme.secondary.withValues(alpha: 0.4),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                  l10n.emptySchedule,
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w800,
                                    color: theme.colorScheme.onSurface,
                                  )
                              ),
                              const SizedBox(height: 6),
                              Text(
                                "All done for today!\nTake time to relax and recover.",
                                textAlign: TextAlign.center,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: theme.colorScheme.onSurface.withValues(alpha: 0.55),
                                  height: 1.4,
                                ),
                              ),
                              const SizedBox(height: 140)
                            ]
                        )
                    )
                );
              }
              if (filteredItems.isEmpty && currentHero != null) return const SliverToBoxAdapter(child: SizedBox(height: 140));

              return SliverPadding(
                padding: EdgeInsets.only(left: 20, right: 20, bottom: totalBottomPadding),
                sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                            (context, index) => Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: DoseCard(item: filteredItems[index])
                        ),
                        childCount: filteredItems.length
                    )
                ),
              );
            },
            loading: () => const SliverFillRemaining(child: Center(child: CircularProgressIndicator())),
            error: (error, stack) => SliverFillRemaining(child: Center(child: Text(l10n.errorPrefix(error.toString())))),
          ),
        ],
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: glassNavHeight + 16),
        child: Container(
            height: 56,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                      color: theme.primaryColor.withValues(alpha: 0.25),
                      blurRadius: 20,
                      spreadRadius: 2,
                      offset: const Offset(0, 6)
                  )
                ]
            ),
            child: FloatingActionButton.extended(
              heroTag: 'action_center_btn',
              elevation: 0,
              backgroundColor: theme.primaryColor,
              foregroundColor: Colors.white,
              onPressed: () => _showActionCenter(context, theme, l10n),
              icon: const Icon(Icons.add_rounded, size: 24),
              label: Text(
                  l10n.addAction,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, letterSpacing: 0.5)
              ),
            )
        ),
      ),
    );
  }
}

// СТИЛЬ ИЗ АНАЛИТИКИ (_SummaryInfoCard style)
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
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: GlassContainer(
            padding: const EdgeInsets.all(18),
            color: color.withValues(alpha: 0.04), // Легкий фон
            child: Row(
                children: [
                  Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(icon, color: color, size: 24)
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
                                    color: theme.colorScheme.onSurface
                                )
                            ),
                            const SizedBox(height: 4),
                            Text(
                                subtitle,
                                style: theme.textTheme.bodySmall?.copyWith(
                                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6)
                                )
                            )
                          ]
                      )
                  ),
                  Icon(
                      Icons.chevron_right_rounded,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.3)
                  )
                ]
            )
        )
    );
  }
}