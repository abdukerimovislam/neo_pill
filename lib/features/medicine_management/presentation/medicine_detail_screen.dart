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
import '../../home/presentation/widgets/pill_icon_widget.dart';
import '../../home/providers/home_controller.dart';
import '../../../core/presentation/widgets/gradient_scaffold.dart';
import '../../../core/presentation/widgets/glass_container.dart';
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

class MedicineDetailScreen extends ConsumerStatefulWidget {
  final MedicineEntity medicine;
  const MedicineDetailScreen({super.key, required this.medicine});

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
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);

    _breathingAnimation = Tween<double>(begin: 1.0, end: 1.08).animate(
      CurvedAnimation(
        parent: _breathingController,
        curve: Curves.easeInOutSine,
      ),
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
        title: Text(l10n.deleteCourse),
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
              if (mounted) navigator.pop();
            },
            child: Text(l10n.delete),
          ),
        ],
      ),
    );
  }

  Future<void> _togglePause() async {
    await ref.read(homeControllerProvider).togglePauseMedicine(widget.medicine);
    setState(() => _isPaused = !_isPaused);
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

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final historyAsync = ref.watch(
      medicineHistoryProvider(widget.medicine.syncId),
    );

    final progress = widget.medicine.pillsInPackage > 0
        ? widget.medicine.pillsRemaining / widget.medicine.pillsInPackage
        : 0.0;
    final rawDosage = widget.medicine.dosage;
    final dosage = rawDosage % 1 == 0
        ? rawDosage.toInt().toString()
        : rawDosage.toString();

    String freqStr = widget.medicine.frequency.name.toUpperCase();
    if (widget.medicine.frequency == FrequencyTypeEnum.asNeeded) {
      freqStr = l10n.asNeededFrequency;
    }
    if (widget.medicine.frequency == FrequencyTypeEnum.tapering) {
      freqStr = l10n.taperingFrequency;
    }

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
                      .then((_) {
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
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // 🚀 АНИМИРОВАННАЯ КАРТОЧКА: ФОТО ИЛИ ИКОНКА
                  ScaleTransition(
                    scale: _breathingAnimation,
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
                      child:
                          widget.medicine.pillImagePath != null &&
                              File(widget.medicine.pillImagePath!).existsSync()
                          ? ClipOval(
                              child: Image.file(
                                File(widget.medicine.pillImagePath!),
                                width: 140,
                                height: 140,
                                fit: BoxFit.cover,
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
                  const SizedBox(height: 24),

                  Text(
                    widget.medicine.name,
                    style: theme.textTheme.displayLarge?.copyWith(
                      fontSize: 32,
                      letterSpacing: -1.0,
                      color: _isPaused ? theme.disabledColor : null,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: theme.primaryColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '$dosage ${widget.medicine.dosageUnit}',
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: theme.primaryColor,
                        fontWeight: FontWeight.w900,
                      ),
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
                        color: Colors.orange.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.orange.withValues(alpha: 0.5),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.pause_circle_filled,
                            color: Colors.orange,
                            size: 16,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            l10n.coursePaused,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  const SizedBox(height: 32),

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
                        widget.medicine.form.name.toUpperCase(),
                        Icons.medication_rounded,
                        theme.colorScheme.secondary,
                        theme,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  GlassContainer(
                    padding: const EdgeInsets.all(20),
                    color: widget.medicine.pillsRemaining == 0
                        ? theme.colorScheme.error.withValues(alpha: 0.05)
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
                                  color: theme.colorScheme.error.withValues(
                                    alpha: 0.12,
                                  ),
                                  borderRadius: BorderRadius.circular(999),
                                ),
                                child: Text(
                                  l10n.outOfStockBadge,
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: theme.colorScheme.error,
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
                                  color: Colors.orange.withValues(alpha: 0.12),
                                  borderRadius: BorderRadius.circular(999),
                                ),
                                child: Text(
                                  l10n.lowStockAlert,
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: Colors.orange,
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
                                      ? theme.colorScheme.error
                                      : (progress > 0.2
                                            ? theme.colorScheme.secondary
                                            : Colors.orange),
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
                        return Center(
                          child: Text(
                            l10n.noHistoryYet,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurface.withValues(
                                alpha: 0.55,
                              ),
                            ),
                          ),
                        );
                      }
                      return Column(
                        children: logs.map((log) {
                          final isTaken = log.status == DoseStatusEnum.taken;
                          final statusColor = isTaken
                              ? theme.colorScheme.secondary
                              : theme.colorScheme.error;
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
                    error: (err, stack) => const Center(child: Text('Error')),
                  ),
                  const SizedBox(height: 32),

                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            backgroundColor: _isPaused
                                ? theme.colorScheme.secondary.withValues(
                                    alpha: 0.1,
                                  )
                                : Colors.orange.withValues(alpha: 0.1),
                            foregroundColor: _isPaused
                                ? theme.colorScheme.secondary
                                : Colors.orange,
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
                            backgroundColor: theme.primaryColor.withValues(
                              alpha: 0.1,
                            ),
                            foregroundColor: theme.primaryColor,
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
                      foregroundColor: theme.colorScheme.error,
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
