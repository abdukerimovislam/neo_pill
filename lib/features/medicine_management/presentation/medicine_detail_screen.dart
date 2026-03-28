import 'dart:io'; // 🚀 ДОБАВЛЕН ИМПОРТ ДЛЯ РАБОТЫ С ФАЙЛАМИ ФОТО
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';

import '../../../data/local/entities/dose_log_entity.dart';
import '../../../data/local/isar_service.dart';
import '../../../core/utils/pdf_generator_service.dart';
import '../../../data/local/entities/medicine_entity.dart';
import '../../../l10n/app_localizations.dart';
import '../../../l10n/l10n_extensions.dart';
import '../../home/presentation/widgets/pill_icon_widget.dart';
import '../../home/providers/home_controller.dart';
import '../../../core/presentation/widgets/gradient_scaffold.dart';
import '../../../core/presentation/widgets/glass_container.dart';
import '../../../core/presentation/widgets/animated_reveal.dart';
import '../../../core/presentation/widgets/ambient_glow.dart';
import '../../../core/presentation/widgets/state_card.dart';
import '../../../core/theme/app_colors.dart';
import '../../settings/provider/settings_provider.dart';
import 'edit_medicine_screen.dart';

final medicineHistoryProvider =
    FutureProvider.family<List<DoseLogEntity>, String>((ref, syncId) async {
      final isar = await ref.read(localDbProvider).db;
      return isar.doseLogEntitys
          .filter()
          .medicineSyncIdEqualTo(syncId)
          .not()
          .statusEqualTo(DoseStatusEnum.pending)
          .sortByScheduledTimeDesc()
          .limit(5)
          .findAll();
    });

final medicineSchedulePreviewProvider =
    FutureProvider.family<List<DoseLogEntity>, String>((ref, syncId) async {
      final isar = await ref.read(localDbProvider).db;
      final pendingLogs = await isar.doseLogEntitys
          .filter()
          .medicineSyncIdEqualTo(syncId)
          .statusEqualTo(DoseStatusEnum.pending)
          .findAll();

      pendingLogs.sort((a, b) => a.scheduledTime.compareTo(b.scheduledTime));
      if (pendingLogs.isEmpty) return [];

      final firstDay = DateTime(
        pendingLogs.first.scheduledTime.year,
        pendingLogs.first.scheduledTime.month,
        pendingLogs.first.scheduledTime.day,
      );

      return pendingLogs.where((log) {
        final currentDay = DateTime(
          log.scheduledTime.year,
          log.scheduledTime.month,
          log.scheduledTime.day,
        );
        return currentDay.isAtSameMomentAs(firstDay);
      }).toList();
    });

class MedicineDetailScreen extends ConsumerStatefulWidget {
  final MedicineEntity medicine;
  final String? heroTag;

  const MedicineDetailScreen({super.key, required this.medicine, this.heroTag});

  @override
  ConsumerState<MedicineDetailScreen> createState() =>
      _MedicineDetailScreenState();
}

class _MedicineDetailScreenState extends ConsumerState<MedicineDetailScreen>
    with SingleTickerProviderStateMixin {
  late bool _isPaused;
  late AnimationController _breathingController;
  late Animation<double> _breathingAnimation;

  @override
  void initState() {
    super.initState();
    _isPaused = widget.medicine.isPaused;

    _breathingController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..forward();

    _breathingAnimation = Tween<double>(begin: 0.985, end: 1.0).animate(
      CurvedAnimation(parent: _breathingController, curve: Curves.easeOutCubic),
    );
  }

  @override
  void dispose() {
    _breathingController.dispose();
    super.dispose();
  }

  void _confirmDelete(BuildContext context, AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('${l10n.deleteCourse}: ${widget.medicine.name}'),
        content: Text(l10n.deleteConfirmation),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(l10n.cancel),
          ),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
            onPressed: () async {
              final navigator = Navigator.of(context);
              Navigator.of(ctx).pop();
              await ref
                  .read(homeControllerProvider)
                  .deleteMedicine(widget.medicine);
              if (mounted) {
                final kindLabel =
                    widget.medicine.kind == CourseKindEnum.supplement
                    ? l10n.courseKindSupplement
                    : l10n.courseKindMedication;
                navigator.pop(
                  l10n.courseDeletedMessage(kindLabel, widget.medicine.name),
                );
              }
            },
            child: Text(l10n.delete),
          ),
        ],
      ),
    );
  }

  Future<void> _togglePause() async {
    await ref.read(homeControllerProvider).togglePauseMedicine(widget.medicine);
    if (!mounted) return;
    final l10n = AppLocalizations.of(context)!;
    final nextPausedState = !_isPaused;
    final kindLabel = widget.medicine.kind == CourseKindEnum.supplement
        ? l10n.courseKindSupplement
        : l10n.courseKindMedication;
    setState(() => _isPaused = nextPausedState);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          nextPausedState
              ? l10n.coursePausedMessage(kindLabel, widget.medicine.name)
              : l10n.courseResumedMessage(kindLabel, widget.medicine.name),
        ),
      ),
    );
  }

  Future<void> _generatePdfReport(AppLocalizations l10n) async {
    try {
      final patientName = ref.read(userNameProvider);
      final caregiver = ref.read(caregiverProfileProvider);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 16),
              Text(l10n.generatingReport),
            ],
          ),
          backgroundColor: Theme.of(context).primaryColor,
          duration: const Duration(seconds: 2),
        ),
      );
      final isar = await ref.read(localDbProvider).db;
      final logs = await isar.doseLogEntitys
          .filter()
          .medicineSyncIdEqualTo(widget.medicine.syncId)
          .sortByScheduledTimeDesc()
          .findAll();
      await PdfGeneratorService.generateAndShareReport(
        medicine: widget.medicine,
        logs: logs,
        l10n: l10n,
        patientName: patientName,
        caregiver: caregiver?.shareReports == true ? caregiver : null,
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.errorGeneratingReport(e.toString())),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }

  Widget _buildBentoCard(
    String title,
    String value,
    IconData icon,
    Color color,
    ThemeData theme,
  ) {
    return Expanded(
      child: GlassContainer(
        padding: const EdgeInsets.all(16),
        color: color.withValues(alpha: 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 22),
            ),
            const SizedBox(height: 14),
            Text(
              value,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
                color: theme.colorScheme.onSurface,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.55),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _localizedFrequency(AppLocalizations l10n) {
    return switch (widget.medicine.frequency) {
      FrequencyTypeEnum.daily => l10n.medicineFrequencyDaily,
      FrequencyTypeEnum.asNeeded => l10n.asNeededFrequency,
      FrequencyTypeEnum.tapering => l10n.taperingFrequency,
      FrequencyTypeEnum.specificDays => l10n.medicineFrequencySpecificDays,
      FrequencyTypeEnum.interval => l10n.medicineFrequencyInterval,
      FrequencyTypeEnum.cycle => l10n.medicineFrequencyCycle,
    };
  }

  String _localizedForm(AppLocalizations l10n) {
    return switch (widget.medicine.form) {
      MedicineFormEnum.pill => l10n.medicineFormTablet,
      MedicineFormEnum.capsule => l10n.medicineFormCapsule,
      MedicineFormEnum.liquid => l10n.medicineFormLiquid,
      MedicineFormEnum.injection => l10n.medicineFormInjection,
      MedicineFormEnum.drops => l10n.medicineFormDrops,
      MedicineFormEnum.ointment => l10n.medicineFormOintment,
      MedicineFormEnum.spray => l10n.medicineFormSpray,
      MedicineFormEnum.inhaler => l10n.medicineFormInhaler,
      MedicineFormEnum.patch => l10n.medicineFormPatch,
      MedicineFormEnum.suppository => l10n.medicineFormSuppository,
    };
  }

  String _formatDosage(double dosage) {
    return dosage % 1 == 0 ? dosage.toInt().toString() : dosage.toString();
  }

  Widget _buildCourseTypeBadge({
    required ThemeData theme,
    required bool isComplexCourse,
  }) {
    final label = isComplexCourse
        ? AppLocalizations.of(context)!.medicineComplexCourse
        : AppLocalizations.of(context)!.medicineStandardCourse;
    final color = widget.medicine.kind == CourseKindEnum.supplement
        ? theme.supplementAccent
        : theme.brandPrimary;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.18)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isComplexCourse ? Icons.timeline_rounded : Icons.checklist_rounded,
            size: 16,
            color: color,
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  String _kindLabel() {
    return switch (widget.medicine.kind) {
      CourseKindEnum.medication => AppLocalizations.of(
        context,
      )!.courseKindMedication,
      CourseKindEnum.supplement => AppLocalizations.of(
        context,
      )!.courseKindSupplement,
    };
  }

  IconData _kindIcon() {
    return widget.medicine.kind == CourseKindEnum.supplement
        ? Icons.spa_rounded
        : Icons.local_hospital_rounded;
  }

  Gradient _heroGradient() {
    if (widget.medicine.kind == CourseKindEnum.supplement) {
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

  Color _heroPrimaryColor() {
    return widget.medicine.kind == CourseKindEnum.supplement
        ? const Color(0xFF24415F)
        : const Color(0xFF1C4A3A);
  }

  Color _heroSecondaryColor() {
    return widget.medicine.kind == CourseKindEnum.supplement
        ? const Color(0xFF355675)
        : const Color(0xFF2B6050);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final heroPrimaryColor = _heroPrimaryColor();
    final heroSecondaryColor = _heroSecondaryColor();
    final historyAsync = ref.watch(
      medicineHistoryProvider(widget.medicine.syncId),
    );
    final schedulePreviewAsync = ref.watch(
      medicineSchedulePreviewProvider(widget.medicine.syncId),
    );

    final progress = widget.medicine.pillsInPackage > 0
        ? widget.medicine.pillsRemaining / widget.medicine.pillsInPackage
        : 0.0;
    final rawDosage = widget.medicine.dosage;
    final dosage = rawDosage % 1 == 0
        ? rawDosage.toInt().toString()
        : rawDosage.toString();

    final freqStr = _localizedFrequency(l10n);
    final formLabel = _localizedForm(l10n);

    return GradientScaffold(
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            centerTitle: true,
            expandedHeight: 80.0,
            floating: false,
            pinned: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: IconThemeData(color: theme.colorScheme.onSurface),
            actions: [
              IconButton(
                icon: const Icon(Icons.edit_outlined),
                tooltip: l10n.editCourse,
                onPressed: () {
                  Navigator.of(context)
                      .push(
                        MaterialPageRoute(
                          builder: (context) =>
                              EditMedicineScreen(medicine: widget.medicine),
                        ),
                      )
                      .then((result) {
                        if (!context.mounted) return;
                        if (result is String && result.isNotEmpty) {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text(result)));
                        }
                        setState(() {});
                        ref.invalidate(
                          medicineHistoryProvider(widget.medicine.syncId),
                        );
                      });
                },
              ),
              const SizedBox(width: 8),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      theme.scaffoldBackgroundColor,
                      theme.scaffoldBackgroundColor.withValues(alpha: 0.0),
                    ],
                  ),
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // 🚀 АНИМИРОВАННАЯ КАРТОЧКА: ФОТО ИЛИ ИКОНКА
                  AnimatedReveal(
                    delay: const Duration(milliseconds: 40),
                    child: ScaleTransition(
                      scale: _breathingAnimation,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          AmbientGlow(
                            color: Color(widget.medicine.pillColor),
                            size: 210,
                            opacity: 0.16,
                          ),
                          Hero(
                            tag:
                                widget.heroTag ??
                                'medicine-${widget.medicine.syncId}',
                            child: Material(
                              color: Colors.transparent,
                              child: Container(
                                width: 140,
                                height: 140,
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.surface,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Color(
                                      widget.medicine.pillColor,
                                    ).withValues(alpha: 0.3),
                                    width: 3,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(
                                        widget.medicine.pillColor,
                                      ).withValues(alpha: 0.2),
                                      blurRadius: 40,
                                      spreadRadius: 10,
                                    ),
                                  ],
                                ),
                                child: widget.medicine.pillImagePath != null
                                    ? ClipOval(
                                        child: Image.file(
                                          File(widget.medicine.pillImagePath!),
                                          width: 140,
                                          height: 140,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (
                                                context,
                                                error,
                                                stackTrace,
                                              ) => Center(
                                                child: PillIconWidget(
                                                  shape:
                                                      widget.medicine.pillShape,
                                                  colorHex:
                                                      widget.medicine.pillColor,
                                                  size: 60,
                                                ),
                                              ),
                                        ),
                                      )
                                    : Center(
                                        child: PillIconWidget(
                                          shape: widget.medicine.pillShape,
                                          colorHex: widget.medicine.pillColor,
                                          size: 60,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  AnimatedReveal(
                    delay: const Duration(milliseconds: 100),
                    child: Text(
                      widget.medicine.name,
                      style: theme.textTheme.displayLarge?.copyWith(
                        fontSize: 32,
                        letterSpacing: -1.0,
                        fontWeight: FontWeight.w900,
                        color: _isPaused ? theme.disabledColor : null,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 8),
                  AnimatedReveal(
                    delay: const Duration(milliseconds: 130),
                    child: GlassContainer(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      gradient: _heroGradient(),
                      borderRadius: 20,
                      child: Text(
                        '$dosage ${l10n.dosageUnitLabel(widget.medicine.dosageUnit)}',
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: heroPrimaryColor,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.46),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(_kindIcon(), size: 14, color: heroPrimaryColor),
                        const SizedBox(width: 6),
                        Text(
                          _kindLabel(),
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: heroPrimaryColor,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  AnimatedReveal(
                    delay: const Duration(milliseconds: 170),
                    child: GlassContainer(
                      padding: const EdgeInsets.all(14),
                      gradient: _heroGradient(),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            widget.medicine.kind == CourseKindEnum.supplement
                                ? Icons.spa_rounded
                                : Icons.local_hospital_rounded,
                            size: 18,
                            color: heroPrimaryColor,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              widget.medicine.kind == CourseKindEnum.supplement
                                  ? l10n.medicineTimelineSupplementInfo
                                  : l10n.medicineTimelineMedicationInfo,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: heroSecondaryColor,
                                height: 1.35,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  schedulePreviewAsync.when(
                    data: (logs) {
                      final uniqueDosages = logs
                          .map((log) => _formatDosage(log.dosage))
                          .toSet();
                      final isComplexCourse =
                          widget.medicine.frequency ==
                              FrequencyTypeEnum.tapering ||
                          uniqueDosages.length > 1;
                      return _buildCourseTypeBadge(
                        theme: theme,
                        isComplexCourse: isComplexCourse,
                      );
                    },
                    loading: () => _buildCourseTypeBadge(
                      theme: theme,
                      isComplexCourse:
                          widget.medicine.frequency ==
                          FrequencyTypeEnum.tapering,
                    ),
                    error: (error, stack) => _buildCourseTypeBadge(
                      theme: theme,
                      isComplexCourse:
                          widget.medicine.frequency ==
                          FrequencyTypeEnum.tapering,
                    ),
                  ),

                  if (_isPaused) ...[
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: theme.warningAccent.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: theme.warningAccent.withValues(alpha: 0.5),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.pause_circle_filled,
                            color: theme.warningAccent,
                            size: 16,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            l10n.coursePaused,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.warningAccent,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  const SizedBox(height: 32),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      l10n.scheduleAndRules,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  AnimatedReveal(
                    delay: const Duration(milliseconds: 220),
                    child: GlassContainer(
                      padding: const EdgeInsets.all(16),
                      color: theme.colorScheme.surface.withValues(alpha: 0.45),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              _buildBentoCard(
                                l10n.frequency,
                                freqStr,
                                Icons.calendar_month_rounded,
                                theme.primaryColor,
                                theme,
                              ),
                              const SizedBox(width: 16),
                              _buildBentoCard(
                                l10n.form,
                                formLabel,
                                widget.medicine.kind ==
                                        CourseKindEnum.supplement
                                    ? Icons.spa_rounded
                                    : Icons.medication_rounded,
                                widget.medicine.kind ==
                                        CourseKindEnum.supplement
                                    ? theme.supplementAccent
                                    : theme.brandPrimary,
                                theme,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          schedulePreviewAsync.when(
                            data: (logs) {
                              final uniqueDosages = logs
                                  .map((log) => _formatDosage(log.dosage))
                                  .toSet();
                              if (logs.isEmpty ||
                                  widget.medicine.frequency ==
                                      FrequencyTypeEnum.asNeeded ||
                                  uniqueDosages.length <= 1) {
                                return const SizedBox.shrink();
                              }

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    l10n.medicineDoseScheduleTitle,
                                    style: theme.textTheme.titleMedium
                                        ?.copyWith(fontWeight: FontWeight.w800),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    l10n.medicineDoseScheduleSubtitle,
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: theme.colorScheme.onSurface
                                          .withValues(alpha: 0.6),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Wrap(
                                    spacing: 10,
                                    runSpacing: 10,
                                    children: logs.map((log) {
                                      final time = DateFormat.Hm(
                                        Localizations.localeOf(
                                          context,
                                        ).languageCode,
                                      ).format(log.scheduledTime);
                                      return Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 14,
                                          vertical: 12,
                                        ),
                                        decoration: BoxDecoration(
                                          color: theme.brandPrimary.withValues(
                                            alpha: 0.08,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            14,
                                          ),
                                          border: Border.all(
                                            color: theme.brandPrimary
                                                .withValues(alpha: 0.12),
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              time,
                                              style: theme.textTheme.titleMedium
                                                  ?.copyWith(
                                                    color: theme.brandPrimary,
                                                    fontWeight: FontWeight.w800,
                                                  ),
                                            ),
                                            const SizedBox(height: 2),
                                            Text(
                                              '${_formatDosage(log.dosage)} ${l10n.dosageUnitLabel(widget.medicine.dosageUnit)}',
                                              style: theme.textTheme.bodyMedium
                                                  ?.copyWith(
                                                    fontWeight: FontWeight.w700,
                                                    color: theme
                                                        .colorScheme
                                                        .onSurface,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              );
                            },
                            loading: () => const SizedBox.shrink(),
                            error: (error, stack) => const SizedBox.shrink(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  GlassContainer(
                    padding: const EdgeInsets.all(16),
                    color: widget.medicine.pillsRemaining == 0
                        ? theme.dangerAccent.withValues(alpha: 0.05)
                        : theme.colorScheme.surface.withValues(alpha: 0.45),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              l10n.inventory,
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w800,
                                color: theme.colorScheme.onSurface,
                              ),
                            ),
                            if (widget.medicine.pillsRemaining == 0)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: theme.dangerAccent.withValues(
                                    alpha: 0.12,
                                  ),
                                  borderRadius: BorderRadius.circular(999),
                                ),
                                child: Text(
                                  l10n.outOfStockBadge,
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: theme.dangerAccent,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            if (widget.medicine.pillsRemaining > 0 &&
                                widget.medicine.pillsRemaining <=
                                    widget.medicine.refillAlertThreshold)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: theme.warningAccent.withValues(
                                    alpha: 0.12,
                                  ),
                                  borderRadius: BorderRadius.circular(999),
                                ),
                                child: Text(
                                  l10n.lowStockAlert,
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: theme.warningAccent,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: LinearProgressIndicator(
                                  value: progress,
                                  minHeight: 12,
                                  backgroundColor: theme.dividerColor
                                      .withValues(alpha: 0.15),
                                  color: widget.medicine.pillsRemaining == 0
                                      ? theme.dangerAccent
                                      : (progress > 0.2
                                            ? theme.successAccent
                                            : theme.warningAccent),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Text(
                              '${widget.medicine.pillsRemaining} / ${widget.medicine.pillsInPackage}',
                              style: theme.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      l10n.recentHistory,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  historyAsync.when(
                    data: (logs) {
                      if (logs.isEmpty) {
                        return StateCard(
                          icon: Icons.history_rounded,
                          title: l10n.recentHistory,
                          subtitle: l10n.noHistoryYet,
                          color: theme.brandPrimary,
                        );
                      }
                      return Column(
                        children: logs.map((log) {
                          final isTaken = log.status == DoseStatusEnum.taken;
                          final statusColor = isTaken
                              ? theme.successAccent
                              : theme.dangerAccent;
                          final dateStr = DateFormat(
                            'MMM d',
                            Localizations.localeOf(context).languageCode,
                          ).format(log.scheduledTime);
                          final timeStr = DateFormat(
                            'HH:mm',
                            Localizations.localeOf(context).languageCode,
                          ).format(log.scheduledTime);

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      dateStr,
                                      style: theme.textTheme.labelSmall
                                          ?.copyWith(
                                            color: theme.colorScheme.onSurface
                                                .withValues(alpha: 0.55),
                                          ),
                                    ),
                                    Text(
                                      timeStr,
                                      style: theme.textTheme.titleMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.w800,
                                          ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 16),
                                Container(
                                  width: 14,
                                  height: 14,
                                  decoration: BoxDecoration(
                                    color: statusColor,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: theme.scaffoldBackgroundColor,
                                      width: 3,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: statusColor.withValues(
                                          alpha: 0.5,
                                        ),
                                        blurRadius: 8,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 12,
                                    ),
                                    decoration: BoxDecoration(
                                      color: statusColor.withValues(
                                        alpha: 0.08,
                                      ),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Text(
                                      isTaken
                                          ? l10n.statusTaken
                                          : l10n.statusSkipped,
                                      style: theme.textTheme.bodyMedium
                                          ?.copyWith(
                                            color: statusColor,
                                            fontWeight: FontWeight.w700,
                                          ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      );
                    },
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (err, stack) =>
                        Center(child: Text(l10n.medicineHistoryLoadError)),
                  ),
                  const SizedBox(height: 32),

                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            backgroundColor: _isPaused
                                ? theme.successAccent.withValues(alpha: 0.1)
                                : theme.warningAccent.withValues(alpha: 0.1),
                            foregroundColor: _isPaused
                                ? theme.successAccent
                                : theme.warningAccent,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          onPressed: _togglePause,
                          icon: Icon(
                            _isPaused
                                ? Icons.play_arrow_rounded
                                : Icons.pause_rounded,
                          ),
                          label: Text(
                            _isPaused ? l10n.resumeCourse : l10n.pauseCourse,
                            style: const TextStyle(fontWeight: FontWeight.w800),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            backgroundColor: theme.brandPrimary.withValues(
                              alpha: 0.1,
                            ),
                            foregroundColor: theme.brandPrimary,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          onPressed: () => _generatePdfReport(l10n),
                          icon: const Icon(Icons.picture_as_pdf_rounded),
                          label: Text(
                            l10n.doctorReport,
                            style: const TextStyle(fontWeight: FontWeight.w800),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  TextButton.icon(
                    style: TextButton.styleFrom(
                      foregroundColor: theme.dangerAccent,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: () => _confirmDelete(context, l10n),
                    icon: const Icon(Icons.delete_outline_rounded),
                    label: Text(
                      l10n.deleteCourse,
                      style: const TextStyle(fontWeight: FontWeight.w800),
                    ),
                  ),
                  const SizedBox(height: 60),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
