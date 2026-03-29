import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/firebase/caregiver_cloud_repository.dart';
import '../../../core/utils/caregiver_alert_service.dart';
import '../../../core/presentation/widgets/glass_container.dart';
import '../../../core/presentation/widgets/animated_reveal.dart';
import '../../../core/presentation/widgets/ambient_glow.dart';
import '../../../core/presentation/widgets/care_context_switcher.dart';
import '../../../core/presentation/widgets/gradient_scaffold.dart';
import '../../../core/presentation/widgets/motion_pressable.dart';
import '../../../core/presentation/widgets/state_card.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/local/entities/dose_log_entity.dart';
import '../../../data/local/entities/medicine_entity.dart';
import '../../../l10n/app_localizations.dart';
import '../../../l10n/l10n_extensions.dart';
import '../../measurements/presentation/widgets/add_measurement_modal.dart';
import '../../medicine_management/presentation/add_medicine_screen.dart';
import '../../settings/provider/care_context_provider.dart';
import '../../settings/provider/caregiver_cloud_provider.dart';
import '../../settings/provider/caregiver_delivery_provider.dart';
import '../../settings/provider/settings_provider.dart';
import '../providers/home_controller.dart';
import '../providers/home_provider.dart';
import 'widgets/dose_card.dart';
import 'widgets/horizontal_calendar.dart';
import 'widgets/pill_icon_widget.dart';
import 'widgets/sos_panel.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  static String _kindLabel(BuildContext context, MedicineEntity? medicine) {
    final l10n = AppLocalizations.of(context)!;
    final kind = medicine?.kind ?? CourseKindEnum.medication;
    return l10n.courseKindLabel(kind);
  }

  static String _courseFilterLabel(
      BuildContext context,
      CourseFilterType filter,
      ) {
    return switch (filter) {
      CourseFilterType.all => AppLocalizations.of(context)!.courseFilterAll,
      CourseFilterType.medications =>
      AppLocalizations.of(context)!.courseFilterMedications,
      CourseFilterType.supplements =>
      AppLocalizations.of(context)!.courseFilterSupplements,
    };
  }

  static String _emptyStateTitle(
      BuildContext context,
      CourseFilterType filter,
      ) {
    return switch (filter) {
      CourseFilterType.all => AppLocalizations.of(context)!.homeEmptyAllTitle,
      CourseFilterType.medications =>
      AppLocalizations.of(context)!.homeEmptyMedicationsTitle,
      CourseFilterType.supplements =>
      AppLocalizations.of(context)!.homeEmptySupplementsTitle,
    };
  }

  void _openAddMedication(BuildContext context) {
    final navigator = Navigator.of(context);
    final messenger = ScaffoldMessenger.of(context);

    navigator
        .push(
      MaterialPageRoute(
        builder: (_) => const AddMedicineScreen(
          initialKind: CourseKindEnum.medication,
        ),
      ),
    )
        .then((result) {
      if (result is String && result.isNotEmpty) {
        messenger.showSnackBar(SnackBar(content: Text(result)));
      }
    });
  }

  void _openAddSupplement(BuildContext context) {
    final navigator = Navigator.of(context);
    final messenger = ScaffoldMessenger.of(context);

    navigator
        .push(
      MaterialPageRoute(
        builder: (_) => const AddMedicineScreen(
          initialKind: CourseKindEnum.supplement,
        ),
      ),
    )
        .then((result) {
      if (result is String && result.isNotEmpty) {
        messenger.showSnackBar(SnackBar(content: Text(result)));
      }
    });
  }

  void _openAddMeasurement(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => const AnimatedReveal(
        duration: Duration(milliseconds: 420),
        offset: Offset(0, 0.05),
        scaleBegin: 0.975,
        child: AddMeasurementModal(),
      ),
    );
  }

  void _showCaregiverAlertSheet(
      BuildContext context,
      AppLocalizations l10n,
      ThemeData theme,
      String patientName,
      CaregiverAlertSummary summary,
      ) {
    final localeCode = Localizations.localeOf(context).languageCode;
    final message = CaregiverAlertService.buildAlertMessage(
      l10n: l10n,
      patientName: patientName,
      caregiver: summary.caregiver,
      summary: summary,
      localeCode: localeCode,
    );
    final timeFormat = DateFormat.Hm(localeCode);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => Container(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 28),
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        ),
        child: SafeArea(
          top: false,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.caregiverAlertSheetTitle,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.caregiverAlertSheetSubtitle(
                    summary.caregiver.name,
                    summary.totalCount,
                  ),
                  style: theme.textTheme.bodyMedium?.copyWith(height: 1.45),
                ),
                const SizedBox(height: 18),
                GlassContainer(
                  padding: const EdgeInsets.all(14),
                  color: theme.colorScheme.surface.withValues(alpha: 0.84),
                  child: Column(
                    children: summary.items.map((alert) {
                      final courseName =
                          alert.item.medicine?.name ?? l10n.unknownMedicine;
                      final scheduledTime =
                      timeFormat.format(alert.item.doseLog.scheduledTime);
                      final reason = switch (alert.reason) {
                        CaregiverAlertReason.overdue =>
                            l10n.caregiverAlertReasonOverdue(alert.delayMinutes),
                        CaregiverAlertReason.skipped =>
                        l10n.caregiverAlertReasonSkipped,
                      };
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 34,
                              height: 34,
                              decoration: BoxDecoration(
                                color: (alert.reason ==
                                    CaregiverAlertReason.overdue
                                    ? theme.warningAccent
                                    : theme.dangerAccent)
                                    .withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                alert.reason == CaregiverAlertReason.overdue
                                    ? Icons.schedule_rounded
                                    : Icons.close_rounded,
                                size: 18,
                                color: alert.reason ==
                                    CaregiverAlertReason.overdue
                                    ? theme.warningAccent
                                    : theme.dangerAccent,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    courseName,
                                    style: theme.textTheme.titleSmall?.copyWith(
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    l10n.caregiverAlertItemSchedule(
                                      scheduledTime,
                                      reason,
                                    ),
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: theme.colorScheme.onSurface
                                          .withValues(alpha: 0.64),
                                      height: 1.35,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  l10n.caregiverAlertManualShareNote,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.62),
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 14),
                GlassContainer(
                  padding: const EdgeInsets.all(14),
                  color: theme.colorScheme.surface.withValues(alpha: 0.8),
                  child: SelectableText(
                    message,
                    style: theme.textTheme.bodyMedium?.copyWith(height: 1.45),
                  ),
                ),
                const SizedBox(height: 18),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      final container = ProviderScope.containerOf(
                        context,
                        listen: false,
                      );
                      await Clipboard.setData(ClipboardData(text: message));
                      final queuedEvent = await container
                          .read(caregiverDeliveryProvider.notifier)
                          .queueAlert(
                        caregiverName: summary.caregiver.name,
                        message: message,
                        itemCount: summary.totalCount,
                      );
                      if (queuedEvent != null) {
                        await container
                            .read(caregiverCloudProvider.notifier)
                            .mirrorQueuedAlert(
                          patientName: patientName,
                          event: queuedEvent,
                        );
                      }
                      if (ctx.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(l10n.caregiverAlertMessageCopied),
                          ),
                        );
                      }
                    },
                    icon: const Icon(Icons.copy_rounded),
                    label: Text(l10n.caregiverAlertCopyMessage),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: summary.caregiver.phone.trim().isEmpty
                        ? null
                        : () async {
                      await Clipboard.setData(
                        ClipboardData(text: summary.caregiver.phone),
                      );
                      if (ctx.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              l10n.caregiverAlertPhoneCopied,
                            ),
                          ),
                        );
                      }
                    },
                    icon: const Icon(Icons.phone_rounded),
                    label: Text(
                      summary.caregiver.phone.trim().isEmpty
                          ? l10n.caregiverAlertNoPhone
                          : l10n.caregiverAlertCopyPhone,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    final scheduleAsyncValue = ref.watch(filteredDailyScheduleProvider);
    final heroAsyncValue = ref.watch(heroDoseProvider);
    final dashboardAsyncValue = ref.watch(homeDashboardProvider);
    final caregiverAlertAsyncValue = ref.watch(caregiverAlertSummaryProvider);
    final caregiverCloudState = ref.watch(caregiverCloudProvider);
    final caregiverCloudAlerts =
        ref.watch(caregiverCloudAlertsProvider).valueOrNull ??
            const <CaregiverCloudAlert>[];
    final userName = ref.watch(userNameProvider);
    final comfortMode = ref.watch(comfortModeProvider);
    final selectedFilter = ref.watch(selectedHomeCourseFilterProvider);

    final availableCaregivingContext = caregiverCloudState.hasCaregiverLink;
    final selectedAudience = availableCaregivingContext
        ? ref.watch(selectedCareContextProvider)
        : AppCareContext.myCare;

    final bottomSafeArea = MediaQuery.paddingOf(context).bottom;
    const glassNavHeight = 85.0;
    final universalBottomSpacer = glassNavHeight + bottomSafeArea + 80.0;

    final hour = DateTime.now().hour;
    final greeting = hour < 12
        ? l10n.goodMorning
        : (hour < 18 ? l10n.goodAfternoon : l10n.goodEvening);
    final displayName = userName.trim().isEmpty
        ? l10n.defaultUserName
        : userName.trim();

    return GradientScaffold(
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        slivers: [
          SliverToBoxAdapter(
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                child: AnimatedReveal(
                  duration: const Duration(milliseconds: 340),
                  offset: const Offset(0, 0.02),
                  child: _HomeTopHeader(
                    greeting: greeting,
                    displayName: displayName,
                    selectedAudience: selectedAudience,
                    onProfileTap: () {},
                  ),
                ),
              ),
            ),
          ),

          if (availableCaregivingContext)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
                child: AnimatedReveal(
                  delay: const Duration(milliseconds: 40),
                  offset: const Offset(0, 0.02),
                  child: CareContextSwitcher(
                    selectedContext: selectedAudience,
                    personalLabel: displayName,
                    caregivingLabel:
                    caregiverCloudState.caregiverLinkedPatientName ??
                        l10n.settingsCaregiverConnectedTitle,
                    onChanged: (contextType) {
                      ref.read(selectedCareContextProvider.notifier).state =
                          contextType;
                    },
                  ),
                ),
              ),
            ),

          if (selectedAudience == AppCareContext.myCare)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: AnimatedReveal(
                  delay: const Duration(milliseconds: 80),
                  child: dashboardAsyncValue.when(
                    data: (summary) => _MedicationAssistCard(
                      summary: summary,
                      comfortMode: comfortMode,
                    ),
                    loading: () => const SizedBox.shrink(),
                    error: (_, __) => const SizedBox.shrink(),
                  ),
                ),
              ),
            ),

          if (selectedAudience == AppCareContext.myCare)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
                child: AnimatedReveal(
                  delay: const Duration(milliseconds: 120),
                  child: const HorizontalCalendar(),
                ),
              ),
            ),

          if (selectedAudience == AppCareContext.myCare)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
                child: AnimatedReveal(
                  delay: const Duration(milliseconds: 150),
                  child: _QuickEntryBar(
                    onAddMedication: () => _openAddMedication(context),
                    onAddSupplement: () => _openAddSupplement(context),
                    onAddMeasurement: () => _openAddMeasurement(context),
                  ),
                ),
              ),
            ),

          if (selectedAudience == AppCareContext.myCare)
            heroAsyncValue.when(
              data: (heroItem) {
                if (heroItem == null) {
                  return const SliverToBoxAdapter(child: SizedBox.shrink());
                }

                return SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                    child: AnimatedReveal(
                      delay: const Duration(milliseconds: 180),
                      child: _HeroMedicationCard(
                        item: heroItem,
                        l10n: l10n,
                        comfortMode: comfortMode,
                      ),
                    ),
                  ),
                );
              },
              loading: () => const SliverToBoxAdapter(child: SizedBox.shrink()),
              error: (_, __) => const SliverToBoxAdapter(child: SizedBox.shrink()),
            ),

          if (selectedAudience == AppCareContext.caregiving)
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: availableCaregivingContext ? 16 : 12,
                  bottom: 24,
                ),
                child: AnimatedReveal(
                  delay: const Duration(milliseconds: 90),
                  child: _CaregivingOverviewCard(
                    linkedPatientName:
                    caregiverCloudState.caregiverLinkedPatientName ??
                        l10n.defaultUserName,
                    alerts: caregiverCloudAlerts,
                    onMarkSeen: (alertId) {
                      ref
                          .read(caregiverCloudProvider.notifier)
                          .markAlertSeen(alertId);
                    },
                  ),
                ),
              ),
            ),

          if (selectedAudience == AppCareContext.myCare)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: AnimatedReveal(
                  delay: const Duration(milliseconds: 210),
                  child: caregiverAlertAsyncValue.when(
                    data: (alertSummary) {
                      if (alertSummary == null) {
                        return const SizedBox.shrink();
                      }
                      return _CaregiverAlertCard(
                        summary: alertSummary,
                        onReview: () => _showCaregiverAlertSheet(
                          context,
                          l10n,
                          theme,
                          displayName,
                          alertSummary,
                        ),
                      );
                    },
                    loading: () => const SizedBox.shrink(),
                    error: (_, __) => const SizedBox.shrink(),
                  ),
                ),
              ),
            ),

          if (selectedAudience == AppCareContext.myCare)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 18, 16, 0),
                child: AnimatedReveal(
                  delay: const Duration(milliseconds: 240),
                  child: _DayPlanHeader(
                    title: l10n.homeForThisDay,
                    subtitle: l10n.homeTimelineSubtitle,
                  ),
                ),
              ),
            ),

          if (selectedAudience == AppCareContext.myCare)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                child: AnimatedReveal(
                  delay: const Duration(milliseconds: 260),
                  child: _PremiumFilterTabs(
                    selectedFilter: selectedFilter,
                    labelBuilder: (filter) =>
                        _courseFilterLabel(context, filter),
                    onSelected: (filter) {
                      ref.read(selectedHomeCourseFilterProvider.notifier).state =
                          filter;
                    },
                  ),
                ),
              ),
            ),

          if (selectedAudience == AppCareContext.myCare)
            scheduleAsyncValue.when(
              data: (scheduleItems) {
                final currentHero = heroAsyncValue.valueOrNull;
                final filteredItems = scheduleItems
                    .where(
                      (item) =>
                  currentHero == null ||
                      item.doseLog.id != currentHero.doseLog.id,
                )
                    .toList();

                final visibleBundles = buildRoutineBundles(filteredItems);
                final allVisibleItems = [
                  if (currentHero != null) currentHero,
                  ...filteredItems,
                ];

                if (filteredItems.isEmpty && currentHero == null) {
                  return SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: AnimatedReveal(
                          delay: const Duration(milliseconds: 160),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: theme.primaryColor.withValues(alpha: 0.05),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.task_alt_rounded,
                                  size: 36,
                                  color: theme.primaryColor.withValues(alpha: 0.5),
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                _emptyStateTitle(context, selectedFilter),
                                style: theme.textTheme.titleMedium?.copyWith(
                                  color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                l10n.homeNoAttentionRightNow,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }

                if (filteredItems.isEmpty && currentHero != null) {
                  return SliverPadding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      top: 18,
                    ),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        _DailyDoseOverviewCard(items: allVisibleItems),
                      ]),
                    ),
                  );
                }

                return SliverPadding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 18,
                    bottom: 0,
                  ),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      _DailyDoseOverviewCard(items: allVisibleItems),
                      const SizedBox(height: 16),
                      ...List.generate(
                        visibleBundles.length,
                            (index) => Padding(
                          padding: const EdgeInsets.only(bottom: 22),
                          child: AnimatedReveal(
                            delay: Duration(milliseconds: 320 + (index * 55)),
                            offset: const Offset(0, 0.028),
                            child: _RoutineBundleCard(
                              bundle: visibleBundles[index],
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ),
                );
              },
              loading: () => SliverFillRemaining(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: StateCard(
                      icon: Icons.hourglass_top_rounded,
                      title: l10n.homeForThisDay,
                      subtitle: l10n.homeTimelineSubtitle,
                      color: theme.brandPrimary,
                    ),
                  ),
                ),
              ),
              error: (error, _) => SliverFillRemaining(
                child: Center(child: Text(l10n.errorPrefix(error.toString()))),
              ),
            ),

          if (selectedAudience == AppCareContext.myCare)
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: SosPanel(),
              ),
            ),

          SliverToBoxAdapter(
            child: SizedBox(height: universalBottomSpacer),
          ),
        ],
      ),
    );
  }
}

class _HomeTopHeader extends StatelessWidget {
  final String greeting;
  final String displayName;
  final AppCareContext selectedAudience;
  final VoidCallback onProfileTap;

  const _HomeTopHeader({
    required this.greeting,
    required this.displayName,
    required this.selectedAudience,
    required this.onProfileTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                greeting,
                style: theme.textTheme.labelMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.58),
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                displayName,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.6,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                selectedAudience == AppCareContext.myCare
                    ? l10n.homeTimelineSubtitle
                    : l10n.settingsCaregiverConnectedInboxTitle,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.55),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        MotionPressable(
          onTap: onProfileTap,
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: theme.colorScheme.surface.withValues(alpha: 0.92),
              border: Border.all(
                color: theme.primaryColor.withValues(alpha: 0.12),
                width: 1.4,
              ),
              boxShadow: [
                BoxShadow(
                  color: theme.primaryColor.withValues(alpha: 0.08),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              Icons.person_rounded,
              color: theme.primaryColor,
              size: 24,
            ),
          ),
        ),
      ],
    );
  }
}

class _QuickEntryBar extends StatelessWidget {
  final VoidCallback onAddMedication;
  final VoidCallback onAddSupplement;
  final VoidCallback onAddMeasurement;

  const _QuickEntryBar({
    required this.onAddMedication,
    required this.onAddSupplement,
    required this.onAddMeasurement,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionTitle(
          title: l10n.whatWouldYouLikeToDo,
          trailing: null,
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _QuickActionTile(
                icon: Icons.medication_rounded,
                label: l10n.addMedicationTitle,
                onTap: onAddMedication,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _QuickActionTile(
                icon: Icons.spa_rounded,
                label: l10n.homeAddSupplementTitle,
                onTap: onAddSupplement,
                isSecondary: true,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _QuickActionTile(
                icon: Icons.monitor_heart_rounded,
                label: l10n.addMeasurement,
                onTap: onAddMeasurement,
                isSecondary: true,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _QuickActionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isSecondary;

  const _QuickActionTile({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isSecondary = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = isSecondary ? theme.supplementAccent : theme.primaryColor;

    return MotionPressable(
      onTap: () {
        HapticFeedback.lightImpact();
        onTap();
      },
      borderRadius: BorderRadius.circular(20),
      child: GlassContainer(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        borderRadius: 20,
        color: color.withValues(alpha: 0.06),
        child: Column(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: color, size: 22),
            ),
            const SizedBox(height: 10),
            Text(
              label,
              style: theme.textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w800,
                color: theme.colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class _DayPlanHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const _DayPlanHeader({
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return _SectionTitle(
      title: title,
      trailing: Flexible(
        child: Text(
          subtitle,
          textAlign: TextAlign.right,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context)
                .colorScheme
                .onSurface
                .withValues(alpha: 0.55),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final Widget? trailing;

  const _SectionTitle({
    required this.title,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w900,
              letterSpacing: -0.2,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (trailing != null) ...[
          const SizedBox(width: 8),
          trailing!,
        ]
      ],
    );
  }
}

class _PremiumFilterTabs extends StatelessWidget {
  final CourseFilterType selectedFilter;
  final ValueChanged<CourseFilterType> onSelected;
  final String Function(CourseFilterType filter) labelBuilder;

  const _PremiumFilterTabs({
    required this.selectedFilter,
    required this.onSelected,
    required this.labelBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: theme.dividerColor.withValues(alpha: 0.08),
        ),
      ),
      child: Row(
        children: CourseFilterType.values.map((filter) {
          final isSelected = filter == selectedFilter;
          final color = filter == CourseFilterType.supplements
              ? theme.supplementAccent
              : theme.brandPrimary;

          return Expanded(
            child: MotionPressable(
              onTap: () {
                HapticFeedback.lightImpact();
                onSelected(filter);
              },
              pressedScale: 0.95,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOutCubic,
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? color : Colors.transparent,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: isSelected
                      ? [
                    BoxShadow(
                      color: color.withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                      : [],
                ),
                child: Center(
                  child: Text(
                    labelBuilder(filter),
                    style: TextStyle(
                      color: isSelected
                          ? theme.colorScheme.onPrimary
                          : theme.colorScheme.onSurface.withValues(alpha: 0.6),
                      fontWeight:
                      isSelected ? FontWeight.w800 : FontWeight.w600,
                      fontSize: 13,
                      letterSpacing: 0.2,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _DailyDoseOverviewCard extends StatelessWidget {
  final List<DoseScheduleItem> items;

  const _DailyDoseOverviewCard({
    required this.items,
  });

  int _countByStatus(DoseStatusEnum status) {
    return items.where((e) => e.doseLog.status == status).length;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    final total = items.length;
    final taken = _countByStatus(DoseStatusEnum.taken);
    final skipped = _countByStatus(DoseStatusEnum.skipped);
    final pending = items.where((e) {
      final status = e.doseLog.status;
      return status != DoseStatusEnum.taken && status != DoseStatusEnum.skipped;
    }).length;

    return GlassContainer(
      padding: const EdgeInsets.all(16),
      borderRadius: 22,
      color: theme.colorScheme.surface.withValues(alpha: 0.72),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.homeForThisDay,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            l10n.homeTimelineSubtitle,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.58),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: _MiniStatTile(
                  label: l10n.courseFilterAll,
                  value: '$total',
                  color: theme.primaryColor,
                  icon: Icons.medication_rounded,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _MiniStatTile(
                  label: l10n.takeNowAction,
                  value: '$taken',
                  color: theme.successAccent,
                  icon: Icons.check_circle_rounded,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _MiniStatTile(
                  label: l10n.homeNextUpTitle,
                  value: '$pending',
                  color: theme.warningAccent,
                  icon: Icons.schedule_rounded,
                ),
              ),
            ],
          ),
          if (skipped > 0) ...[
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: theme.dangerAccent.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    size: 18,
                    color: theme.dangerAccent,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '${l10n.skipDoseAction}: $skipped',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.dangerAccent,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _MiniStatTile extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  final IconData icon;

  const _MiniStatTile({
    required this.label,
    required this.value,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w900,
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _CaregivingOverviewCard extends StatelessWidget {
  final String linkedPatientName;
  final List<CaregiverCloudAlert> alerts;
  final ValueChanged<String> onMarkSeen;

  const _CaregivingOverviewCard({
    required this.linkedPatientName,
    required this.alerts,
    required this.onMarkSeen,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).languageCode;
    final timeFormat = DateFormat.MMMd(locale).add_Hm();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GlassContainer(
          padding: const EdgeInsets.all(16),
          borderRadius: 22,
          color: theme.warningAccent.withValues(alpha: 0.08),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: theme.warningAccent.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  Icons.groups_rounded,
                  color: theme.warningAccent,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.settingsCaregiverConnectedInboxTitle,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      l10n.settingsCaregiverConnectedModeCaregiver(
                        linkedPatientName,
                      ),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.68,
                        ),
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        if (alerts.isEmpty)
          StateCard(
            icon: Icons.check_circle_rounded,
            title: linkedPatientName,
            subtitle: l10n.settingsCaregiverConnectedInboxEmpty,
            color: theme.successAccent,
          )
        else
          ...alerts.map(
                (alert) => Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: GlassContainer(
                padding: const EdgeInsets.all(16),
                borderRadius: 22,
                color: theme.colorScheme.surface.withValues(alpha: 0.86),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            alert.patientName,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 4),
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
                    const SizedBox(width: 12),
                    IconButton(
                      onPressed: () => onMarkSeen(alert.id),
                      style: IconButton.styleFrom(
                        backgroundColor: theme.successAccent.withValues(
                          alpha: 0.12,
                        ),
                      ),
                      icon: Icon(
                        Icons.check_rounded,
                        color: theme.successAccent,
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

class _RoutineBundleCard extends StatelessWidget {
  final HomeRoutineBundle bundle;

  const _RoutineBundleCard({required this.bundle});

  String _bundleTitle(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final firstTime = bundle.items.first.doseLog.scheduledTime;
    final hour = firstTime.hour;

    if (hour >= 5 && hour < 12) return l10n.homeMorningRoutine;
    if (hour >= 12 && hour < 17) return l10n.homeAfternoonRoutine;
    if (hour >= 17 && hour < 22) return l10n.homeEveningRoutine;
    return l10n.homeNightRoutine;
  }

  String _bundleSubtitle(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    final start =
    DateFormat.Hm(locale).format(bundle.items.first.doseLog.scheduledTime);
    final end =
    DateFormat.Hm(locale).format(bundle.items.last.doseLog.scheduledTime);

    return '$start - $end';
  }

  IconData _getRoutineIcon() {
    final hour = bundle.items.first.doseLog.scheduledTime.hour;
    if (hour >= 5 && hour < 12) return Icons.wb_twilight_rounded;
    if (hour >= 12 && hour < 17) return Icons.wb_sunny_rounded;
    if (hour >= 17 && hour < 22) return Icons.nightlight_round;
    return Icons.mode_night_rounded;
  }

  Color _getRoutineColor(ThemeData theme) {
    final hour = bundle.items.first.doseLog.scheduledTime.hour;
    if (hour >= 5 && hour < 12) return theme.warningAccent;
    if (hour >= 12 && hour < 17) return theme.brandPrimary;
    if (hour >= 17 && hour < 22) return theme.primaryColor;
    return theme.supplementAccent;
  }

  int _takenCount() {
    return bundle.items
        .where((item) => item.doseLog.status == DoseStatusEnum.taken)
        .length;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accent = _getRoutineColor(theme);
    final total = bundle.items.length;
    final taken = _takenCount();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GlassContainer(
          padding: const EdgeInsets.all(14),
          borderRadius: 22,
          color: accent.withValues(alpha: 0.06),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  _getRoutineIcon(),
                  color: accent,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _bundleTitle(context),
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w900,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      _bundleSubtitle(context),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.58),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface.withValues(alpha: 0.88),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  children: [
                    Text(
                      '$taken/$total',
                      style: theme.textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w900,
                        color: accent,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        ...bundle.items.map(
              (item) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: DoseCard(item: item),
          ),
        ),
      ],
    );
  }
}

class _CaregiverAlertCard extends StatelessWidget {
  final CaregiverAlertSummary summary;
  final VoidCallback onReview;

  const _CaregiverAlertCard({required this.summary, required this.onReview});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return MotionPressable(
      onTap: onReview,
      borderRadius: BorderRadius.circular(22),
      pressedScale: 0.987,
      child: GlassContainer(
        padding: const EdgeInsets.all(16),
        borderRadius: 22,
        color: theme.warningAccent.withValues(alpha: 0.08),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: theme.warningAccent.withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                Icons.groups_rounded,
                color: theme.warningAccent,
                size: 21,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.caregiverAlertCardTitle,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    l10n.caregiverAlertCardSubtitle(
                      summary.caregiver.name,
                      summary.totalCount,
                    ),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                      height: 1.35,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: onReview,
                      icon: const Icon(Icons.copy_all_rounded),
                      label: Text(l10n.caregiverAlertReviewAction),
                    ),
                  ),
                ],
              ),
            ),
          ],
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
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).languageCode;
    final nextDose = summary.nextPendingDose;

    late final IconData icon;
    late final Color color;
    late final String title;
    late final String subtitle;
    String? trailingText;

    if (summary.overdueDoses > 0) {
      icon = Icons.warning_amber_rounded;
      color = theme.dangerAccent;
      title = l10n.homeNeedsAttentionTitle;
      subtitle = l10n.homeNeedsAttentionSubtitle(summary.overdueDoses);
      if (summary.lowStockMedicines > 0) {
        trailingText =
            l10n.homeRefillReminderSubtitle(summary.lowStockMedicines);
      }
    } else if (nextDose != null) {
      icon = Icons.schedule_rounded;
      color = theme.brandPrimary;
      title = l10n.homeNextUpTitle;
      subtitle =
      '${DateFormat.Hm(locale).format(nextDose.doseLog.scheduledTime)} - ${nextDose.medicine?.name ?? HomeScreen._kindLabel(context, nextDose.medicine)}';
      if (summary.lowStockMedicines > 0) {
        trailingText =
            l10n.homeRefillReminderSubtitle(summary.lowStockMedicines);
      }
    } else if (summary.lowStockMedicines > 0) {
      icon = Icons.inventory_2_rounded;
      color = theme.warningAccent;
      title = l10n.homeRefillReminderTitle;
      subtitle = l10n.homeRefillReminderSubtitle(summary.lowStockMedicines);
    } else {
      icon = Icons.check_circle_rounded;
      color = theme.successAccent;
      title = l10n.homeEverythingCalmTitle;
      subtitle = l10n.homeEverythingCalmSubtitle;
    }

    return GlassContainer(
      padding: EdgeInsets.all(comfortMode ? 16 : 14),
      color: theme.colorScheme.surface.withValues(alpha: 0.65),
      borderRadius: 22,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.68),
                    fontWeight: FontWeight.w500,
                    height: 1.3,
                  ),
                ),
                if (trailingText != null) ...[
                  const SizedBox(height: 5),
                  Text(
                    trailingText,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: color,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
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

  String _getKindActionLabel(MedicineEntity? medicine) {
    final kind = medicine?.kind ?? CourseKindEnum.medication;
    return switch (kind) {
      CourseKindEnum.medication => l10n.homeTakeMedicationNow,
      CourseKindEnum.supplement => l10n.homeTakeSupplementNow,
    };
  }

  Gradient _heroGradient(ThemeData theme, MedicineEntity? medicine) {
    final kind = medicine?.kind ?? CourseKindEnum.medication;
    final baseColor = kind == CourseKindEnum.supplement
        ? theme.supplementAccent
        : theme.brandPrimary;

    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        baseColor.withValues(alpha: 0.15),
        baseColor.withValues(alpha: 0.05),
      ],
    );
  }

  Color _heroPrimary(ThemeData theme, MedicineEntity? medicine) {
    final kind = medicine?.kind ?? CourseKindEnum.medication;
    return kind == CourseKindEnum.supplement
        ? theme.supplementAccent
        : theme.brandPrimary;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final medicine = item.medicine;
    final accentColor = _heroPrimary(theme, medicine);

    final timeString = DateFormat.Hm(
      Localizations.localeOf(context).languageCode,
    ).format(item.doseLog.scheduledTime);

    final rawDosage = item.doseLog.dosage > 0
        ? item.doseLog.dosage
        : (medicine?.dosage ?? 0);
    final dosage = rawDosage % 1 == 0
        ? rawDosage.toInt().toString()
        : rawDosage.toString();

    return GlassContainer(
      padding: EdgeInsets.all(comfortMode ? 20 : 18),
      gradient: _heroGradient(theme, medicine),
      borderRadius: 24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (medicine != null)
                Stack(
                  alignment: Alignment.center,
                  children: [
                    AmbientGlow(
                      color: Color(medicine.pillColor),
                      size: comfortMode ? 72 : 64,
                      opacity: 0.16,
                    ),
                    Container(
                      width: comfortMode ? 52 : 48,
                      height: comfortMode ? 52 : 48,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surface,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Color(medicine.pillColor)
                                .withValues(alpha: 0.25),
                            blurRadius: 14,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Center(
                        child: PillIconWidget(
                          shape: medicine.pillShape,
                          colorHex: medicine.pillColor,
                          size: comfortMode ? 24 : 22,
                        ),
                      ),
                    ),
                  ],
                ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          timeString,
                          style: theme.textTheme.titleLarge?.copyWith(
                            color: theme.colorScheme.onSurface,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: accentColor.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Text(
                              _getKindActionLabel(medicine),
                              style: theme.textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.w800,
                                color: accentColor,
                                fontSize: 10,
                                letterSpacing: 0.2,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
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
                      '$dosage ${medicine != null ? l10n.dosageUnitLabel(medicine.dosageUnit) : ''}',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                flex: 5,
                child: SizedBox(
                  height: comfortMode ? 54 : 50,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: accentColor,
                      foregroundColor: theme.colorScheme.onPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      elevation: 0,
                    ),
                    onPressed: () {
                      HapticFeedback.mediumImpact();
                      ref
                          .read(homeControllerProvider)
                          .updateDoseStatus(item.doseLog, DoseStatusEnum.taken);
                      ref.invalidate(heroDoseProvider);
                      ref.invalidate(homeDashboardProvider);
                    },
                    icon: const Icon(Icons.check_circle_rounded, size: 22),
                    label: Text(
                      l10n.takeNowAction,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.5,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 3,
                child: SizedBox(
                  height: comfortMode ? 54 : 50,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: accentColor.withValues(alpha: 0.35),
                        width: 1.5,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    onPressed: () {
                      HapticFeedback.lightImpact();
                      ref
                          .read(homeControllerProvider)
                          .updateDoseStatus(
                        item.doseLog,
                        DoseStatusEnum.skipped,
                      );
                      ref.invalidate(heroDoseProvider);
                      ref.invalidate(homeDashboardProvider);
                    },
                    child: Text(
                      l10n.skipDoseAction,
                      style: TextStyle(
                        color: accentColor,
                        fontWeight: FontWeight.w800,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}