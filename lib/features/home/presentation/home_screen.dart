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

  static String _kindActionLabel(
    BuildContext context,
    MedicineEntity? medicine,
  ) {
    final l10n = AppLocalizations.of(context)!;
    final kind = medicine?.kind ?? CourseKindEnum.medication;
    return switch (kind) {
      CourseKindEnum.medication => l10n.homeTakeMedicationNow,
      CourseKindEnum.supplement => l10n.homeTakeSupplementNow,
    };
  }

  static String _courseFilterLabel(
    BuildContext context,
    CourseFilterType filter,
  ) {
    return switch (filter) {
      CourseFilterType.all => AppLocalizations.of(context)!.courseFilterAll,
      CourseFilterType.medications => AppLocalizations.of(
        context,
      )!.courseFilterMedications,
      CourseFilterType.supplements => AppLocalizations.of(
        context,
      )!.courseFilterSupplements,
    };
  }

  static String _emptyStateTitle(
    BuildContext context,
    CourseFilterType filter,
  ) {
    return switch (filter) {
      CourseFilterType.all => AppLocalizations.of(context)!.homeEmptyAllTitle,
      CourseFilterType.medications => AppLocalizations.of(
        context,
      )!.homeEmptyMedicationsTitle,
      CourseFilterType.supplements => AppLocalizations.of(
        context,
      )!.homeEmptySupplementsTitle,
    };
  }

  // ignore: unused_element
  static String _emptyStateSubtitle(
    BuildContext context,
    CourseFilterType filter,
  ) {
    return switch (filter) {
      CourseFilterType.all => AppLocalizations.of(
        context,
      )!.homeEmptyAllSubtitle,
      CourseFilterType.medications => AppLocalizations.of(
        context,
      )!.homeEmptyMedicationsSubtitle,
      CourseFilterType.supplements => AppLocalizations.of(
        context,
      )!.homeEmptySupplementsSubtitle,
    };
  }

  void _showActionCenter(
    BuildContext context,
    ThemeData theme,
    AppLocalizations l10n,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return AnimatedReveal(
          duration: const Duration(milliseconds: 420),
          offset: const Offset(0, 0.05),
          scaleBegin: 0.975,
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: theme.scaffoldBackgroundColor,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(32),
              ),
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
                  AnimatedReveal(
                    delay: const Duration(milliseconds: 40),
                    offset: const Offset(0, 0.02),
                    child: _ActionCard(
                      icon: Icons.medication_rounded,
                      title: l10n.addMedicationTitle,
                      subtitle: l10n.scheduleNewTreatmentCourse,
                      color: theme.primaryColor,
                      theme: theme,
                      onTap: () {
                        final navigator = Navigator.of(context);
                        final messenger = ScaffoldMessenger.of(context);
                        Navigator.pop(context);
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
                                messenger.showSnackBar(
                                  SnackBar(content: Text(result)),
                                );
                              }
                            });
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  AnimatedReveal(
                    delay: const Duration(milliseconds: 90),
                    offset: const Offset(0, 0.02),
                    child: _ActionCard(
                      icon: Icons.spa_rounded,
                      title: l10n.homeAddSupplementTitle,
                      subtitle: l10n.homeAddSupplementSubtitle,
                      color: theme.supplementAccent,
                      theme: theme,
                      onTap: () {
                        final navigator = Navigator.of(context);
                        final messenger = ScaffoldMessenger.of(context);
                        Navigator.pop(context);
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
                                messenger.showSnackBar(
                                  SnackBar(content: Text(result)),
                                );
                              }
                            });
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  AnimatedReveal(
                    delay: const Duration(milliseconds: 140),
                    offset: const Offset(0, 0.02),
                    child: _ActionCard(
                      icon: Icons.monitor_heart_rounded,
                      title: l10n.addMeasurement,
                      subtitle: l10n.logHealthMetricsSubtitle,
                      color: theme.supplementAccent,
                      theme: theme,
                      onTap: () {
                        Navigator.pop(context);
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
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        );
      },
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
                      final scheduledTime = timeFormat.format(
                        alert.item.doseLog.scheduledTime,
                      );
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
                                color:
                                    (alert.reason ==
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
                                color:
                                    alert.reason == CaregiverAlertReason.overdue
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
                                  content: Text(l10n.caregiverAlertPhoneCopied),
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
    final totalBottomPadding = glassNavHeight + bottomSafeArea + 120.0;

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
          SliverAppBar(
            expandedHeight: 118.0,
            pinned: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            surfaceTintColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(
                left: 16,
                right: 16,
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
          if (availableCaregivingContext)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 12,
                  bottom: 12,
                ),
                child: AnimatedReveal(
                  delay: const Duration(milliseconds: 35),
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
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(top: 12, bottom: 20),
                child: AnimatedReveal(
                  delay: Duration(milliseconds: 40),
                  offset: Offset(0, 0.02),
                  child: HorizontalCalendar(),
                ),
              ),
            ),
          if (selectedAudience == AppCareContext.caregiving)
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: availableCaregivingContext ? 4 : 12,
                  bottom: totalBottomPadding,
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
            )
          else
            heroAsyncValue.when(
              data: (heroItem) {
                return SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      top: 8,
                      bottom: 18,
                    ),
                    child: AnimatedReveal(
                      delay: const Duration(milliseconds: 110),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          dashboardAsyncValue.when(
                            data: (summary) => Column(
                              children: [
                                caregiverAlertAsyncValue.when(
                                  data: (alertSummary) {
                                    if (alertSummary == null) {
                                      return const SizedBox.shrink();
                                    }
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 12,
                                      ),
                                      child: _CaregiverAlertCard(
                                        summary: alertSummary,
                                        onReview: () =>
                                            _showCaregiverAlertSheet(
                                              context,
                                              l10n,
                                              theme,
                                              displayName,
                                              alertSummary,
                                            ),
                                      ),
                                    );
                                  },
                                  loading: () => const SizedBox.shrink(),
                                  error: (_, stackTrace) =>
                                      const SizedBox.shrink(),
                                ),
                                _MedicationAssistCard(
                                  summary: summary,
                                  comfortMode: comfortMode,
                                ),
                              ],
                            ),
                            loading: () => const SizedBox.shrink(),
                            error: (_, stackTrace) => const SizedBox.shrink(),
                          ),
                          if (heroItem != null) ...[
                            const SizedBox(height: 16),
                            AnimatedReveal(
                              delay: const Duration(milliseconds: 180),
                              offset: const Offset(0, 0.03),
                              child: _HeroMedicationCard(
                                item: heroItem,
                                l10n: l10n,
                                comfortMode: comfortMode,
                              ),
                            ),
                          ],
                          if (MediaQuery.sizeOf(context).height < 0) ...[
                            const SizedBox(height: 16),
                            _HomeHintCard(
                              title: l10n.homeNothingDueTitle,
                              subtitle: l10n.homeUseDayWheelSubtitle,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                );
              },
              loading: () => const SliverToBoxAdapter(child: SizedBox.shrink()),
              error: (_, stackTrace) =>
                  const SliverToBoxAdapter(child: SizedBox.shrink()),
            ),
          if (selectedAudience == AppCareContext.myCare)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 10),
                child: AnimatedReveal(
                  delay: const Duration(milliseconds: 210),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          l10n.homeForThisDay,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w800),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 1,
                        color: theme.dividerColor.withValues(alpha: 0.08),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          if (selectedAudience == AppCareContext.myCare)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
                child: AnimatedReveal(
                  delay: const Duration(milliseconds: 260),
                  child: _CourseFilterChips(
                    selectedFilter: selectedFilter,
                    labelBuilder: (filter) =>
                        _courseFilterLabel(context, filter),
                    onSelected: (filter) {
                      ref
                              .read(selectedHomeCourseFilterProvider.notifier)
                              .state =
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

                if (filteredItems.isEmpty && currentHero == null) {
                  return SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: AnimatedReveal(
                          delay: const Duration(milliseconds: 160),
                          child: StateCard(
                            icon: Icons.task_alt_rounded,
                            title: _emptyStateTitle(context, selectedFilter),
                            subtitle: l10n.homeNoAttentionRightNow,
                            color: theme.supplementAccent,
                          ),
                        ),
                      ),
                    ),
                  );
                }

                if (filteredItems.isEmpty && currentHero != null) {
                  return const SliverToBoxAdapter(child: SizedBox(height: 12));
                }

                return SliverPadding(
                  padding: EdgeInsets.only(
                    left: 16,
                    right: 16,
                    bottom: totalBottomPadding,
                  ),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => Padding(
                        padding: const EdgeInsets.only(bottom: 18),
                        child: AnimatedReveal(
                          delay: Duration(milliseconds: 320 + (index * 55)),
                          offset: const Offset(0, 0.028),
                          child: _RoutineBundleCard(
                            bundle: visibleBundles[index],
                          ),
                        ),
                      ),
                      childCount: visibleBundles.length,
                    ),
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
            const SliverToBoxAdapter(child: SosPanel()),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: selectedAudience == AppCareContext.myCare
          ? Padding(
              padding: EdgeInsets.only(bottom: glassNavHeight + 16),
              child: _FloatingActionPulse(
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
                      l10n.homeAddItemFab,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
              ),
            )
          : null,
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

class _CourseFilterChips extends StatelessWidget {
  final CourseFilterType selectedFilter;
  final ValueChanged<CourseFilterType> onSelected;
  final String Function(CourseFilterType filter) labelBuilder;

  const _CourseFilterChips({
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
        children: CourseFilterType.values.map((filter) {
          final isSelected = filter == selectedFilter;
          final color = filter == CourseFilterType.supplements
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
                    : theme.colorScheme.onSurface.withValues(alpha: 0.72),
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

class _RoutineBundleCard extends StatelessWidget {
  final HomeRoutineBundle bundle;

  const _RoutineBundleCard({required this.bundle});

  String _bundleTitle(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final firstTime = bundle.items.first.doseLog.scheduledTime;
    final hour = firstTime.hour;
    if (hour >= 5 && hour < 12) {
      return l10n.homeMorningRoutine;
    }
    if (hour >= 12 && hour < 17) {
      return l10n.homeAfternoonRoutine;
    }
    if (hour >= 17 && hour < 22) {
      return l10n.homeEveningRoutine;
    }
    return l10n.homeNightRoutine;
  }

  String _bundleSubtitle(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).languageCode;
    final start = DateFormat.Hm(
      locale,
    ).format(bundle.items.first.doseLog.scheduledTime);
    final end = DateFormat.Hm(
      locale,
    ).format(bundle.items.last.doseLog.scheduledTime);
    final count = bundle.items.length;
    final countLabel = l10n.homeRoutineItemCount(count);

    return '$start-$end | $countLabel';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: theme.primaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.auto_awesome_rounded,
                  color: theme.primaryColor,
                  size: 17,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _bundleTitle(context),
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      _bundleSubtitle(context),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.64,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        ...bundle.items.map((item) => DoseCard(item: item)),
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
        trailingText = l10n.homeRefillReminderSubtitle(
          summary.lowStockMedicines,
        );
      }
    } else if (nextDose != null) {
      icon = Icons.schedule_rounded;
      color = theme.brandPrimary;
      title = l10n.homeNextUpTitle;
      subtitle =
          '${DateFormat.Hm(locale).format(nextDose.doseLog.scheduledTime)} - ${nextDose.medicine?.name ?? HomeScreen._kindLabel(context, nextDose.medicine)}';
      if (summary.lowStockMedicines > 0) {
        trailingText = l10n.homeRefillReminderSubtitle(
          summary.lowStockMedicines,
        );
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
      padding: EdgeInsets.all(comfortMode ? 18 : 16),
      color: theme.colorScheme.surface.withValues(
        alpha: comfortMode ? 0.92 : 0.46,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: comfortMode ? 42 : 38,
            height: comfortMode ? 42 : 38,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: color, size: comfortMode ? 22 : 20),
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
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.68),
                  ),
                ),
                if (trailingText != null) ...[
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      trailingText,
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.64,
                        ),
                      ),
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

  Gradient _heroGradient(MedicineEntity? medicine) {
    final kind = medicine?.kind ?? CourseKindEnum.medication;
    if (kind == CourseKindEnum.supplement) {
      return LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          const Color(0xFFBFD7F2).withValues(alpha: 0.92),
          const Color(0xFF9FB8D4).withValues(alpha: 0.98),
        ],
      );
    }

    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        const Color(0xFF8ED1A6).withValues(alpha: 0.92),
        const Color(0xFF6BBFB2).withValues(alpha: 0.98),
      ],
    );
  }

  Color _heroPrimary(MedicineEntity? medicine) {
    final kind = medicine?.kind ?? CourseKindEnum.medication;
    return kind == CourseKindEnum.supplement
        ? const Color(0xFF24415F)
        : const Color(0xFF1C4A3A);
  }

  Color _heroSecondary(MedicineEntity? medicine) {
    final kind = medicine?.kind ?? CourseKindEnum.medication;
    return kind == CourseKindEnum.supplement
        ? const Color(0xFF355675)
        : const Color(0xFF2B6050);
  }

  Color _heroAccent(MedicineEntity? medicine, ThemeData theme) {
    final kind = medicine?.kind ?? CourseKindEnum.medication;
    return kind == CourseKindEnum.supplement
        ? theme.supplementAccent
        : theme.brandPrimary;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final medicine = item.medicine;
    final heroPrimary = _heroPrimary(medicine);
    final heroSecondary = _heroSecondary(medicine);
    final heroAccent = _heroAccent(medicine, theme);
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
        GlassContainer(
          padding: EdgeInsets.all(comfortMode ? 18 : 16),
          gradient: _heroGradient(medicine),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.52),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  HomeScreen._kindActionLabel(context, medicine),
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: heroPrimary,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  if (medicine != null)
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        AmbientGlow(
                          color: Color(medicine.pillColor),
                          size: comfortMode ? 86 : 78,
                          opacity: 0.16,
                        ),
                        Container(
                          width: comfortMode ? 58 : 54,
                          height: comfortMode ? 58 : 54,
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
                              size: comfortMode ? 28 : 26,
                            ),
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          timeString,
                          style: theme.textTheme.titleLarge?.copyWith(
                            color: heroPrimary,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          medicine?.name ?? l10n.unknownMedicine,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                            color: heroPrimary,
                          ),
                        ),
                        if (medicine != null) ...[
                          const SizedBox(height: 5),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.46),
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  medicine.kind == CourseKindEnum.supplement
                                      ? Icons.spa_rounded
                                      : Icons.local_hospital_rounded,
                                  size: 14,
                                  color: heroAccent,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  HomeScreen._kindLabel(context, medicine),
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: heroAccent,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                        const SizedBox(height: 2),
                        Text(
                          '$dosage ${medicine != null ? l10n.dosageUnitLabel(medicine.dosageUnit) : ''}',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: heroSecondary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          l10n.homeScheduledFor(timeString),
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: heroSecondary.withValues(alpha: 0.92),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: comfortMode ? 60 : 56,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: heroPrimary,
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
              const SizedBox(height: 8),
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

  const _HomeHintCard({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GlassContainer(
      padding: const EdgeInsets.all(16),
      borderRadius: 22,
      color: theme.colorScheme.surface.withValues(alpha: 0.86),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: theme.supplementAccent.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              Icons.event_available_rounded,
              color: theme.supplementAccent,
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
                const SizedBox(height: 5),
                Text(
                  subtitle,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.65),
                    height: 1.4,
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
    return MotionPressable(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22),
      pressedScale: 0.982,
      child: GlassContainer(
        padding: const EdgeInsets.all(16),
        borderRadius: 22,
        color: color.withValues(alpha: 0.05),
        child: Row(
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(icon, color: color, size: 24),
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
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                      height: 1.35,
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

class _FloatingActionPulse extends StatefulWidget {
  final Widget child;

  const _FloatingActionPulse({required this.child});

  @override
  State<_FloatingActionPulse> createState() => _FloatingActionPulseState();
}

class _FloatingActionPulseState extends State<_FloatingActionPulse>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..forward();
    _scaleAnimation = Tween<double>(
      begin: 0.985,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reduceMotion =
        MediaQuery.maybeOf(context)?.disableAnimations ?? false;
    if (reduceMotion) {
      return widget.child;
    }

    return ScaleTransition(scale: _scaleAnimation, child: widget.child);
  }
}
