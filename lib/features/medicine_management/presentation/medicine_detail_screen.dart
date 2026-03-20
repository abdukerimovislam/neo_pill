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
import 'edit_medicine_screen.dart';

final medicineHistoryProvider = FutureProvider.family<List<DoseLogEntity>, String>((ref, syncId) async {
  final isar = await ref.read(localDbProvider).db;
  return isar.doseLogEntitys
      .filter()
      .medicineSyncIdEqualTo(syncId)
      .not().statusEqualTo(DoseStatusEnum.pending)
      .sortByScheduledTimeDesc()
      .limit(5)
      .findAll();
});

class MedicineDetailScreen extends ConsumerStatefulWidget {
  final MedicineEntity medicine;
  const MedicineDetailScreen({super.key, required this.medicine});

  @override
  ConsumerState<MedicineDetailScreen> createState() => _MedicineDetailScreenState();
}

class _MedicineDetailScreenState extends ConsumerState<MedicineDetailScreen> {
  late bool _isPaused;

  @override
  void initState() {
    super.initState();
    _isPaused = widget.medicine.isPaused;
  }

  void _confirmDelete(BuildContext context, AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.deleteCourse),
        content: Text(l10n.deleteConfirmation),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(), child: Text(l10n.cancel)),
          TextButton(
            style: TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.error),
            onPressed: () async {
              Navigator.of(ctx).pop();
              await ref.read(homeControllerProvider).deleteMedicine(widget.medicine);
              if (mounted) Navigator.of(context).pop();
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)),
              const SizedBox(width: 16),
              Text(l10n.generatingReport),
            ],
          ),
          backgroundColor: Theme.of(context).primaryColor,
          duration: const Duration(seconds: 2),
        ),
      );

      final isar = await ref.read(localDbProvider).db;
      final logs = await isar.doseLogEntitys.filter().medicineSyncIdEqualTo(widget.medicine.syncId).findAll();

      await PdfGeneratorService.generateAndShareReport(medicine: widget.medicine, logs: logs, l10n: l10n);
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.errorGeneratingReport(e.toString())), backgroundColor: Theme.of(context).colorScheme.error));
    }
  }

  // 🚀 НОВОЕ: Отрисовка таблетки через Визуальный Конструктор
  Widget _buildMedicineImageOrIcon(ThemeData theme) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withOpacity(0.5),
        shape: BoxShape.circle,
        border: Border.all(color: Color(widget.medicine.pillColor).withOpacity(0.4), width: 3),
        boxShadow: [
          BoxShadow(
            color: Color(widget.medicine.pillColor).withOpacity(0.25),
            blurRadius: 24,
            spreadRadius: 4,
          )
        ],
      ),
      child: Center(
        child: PillIconWidget(
          shape: widget.medicine.pillShape,
          colorHex: widget.medicine.pillColor,
          size: 44, // Крупная таблетка для экрана деталей
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final historyAsync = ref.watch(medicineHistoryProvider(widget.medicine.syncId));

    final progress = widget.medicine.pillsInPackage > 0 ? widget.medicine.pillsRemaining / widget.medicine.pillsInPackage : 0.0;
    final rawDosage = widget.medicine.dosage;
    final dosage = rawDosage % 1 == 0 ? rawDosage.toInt().toString() : rawDosage.toString();

    return GradientScaffold(
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            centerTitle: true,
            expandedHeight: 100.0,
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
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditMedicineScreen(medicine: widget.medicine))).then((_) {
                    setState(() {});
                    ref.invalidate(medicineHistoryProvider(widget.medicine.syncId));
                  });
                },
              ),
              const SizedBox(width: 8),
            ],
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              titlePadding: const EdgeInsets.only(bottom: 16),
              title: Text(l10n.medicineDetails, style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: theme.colorScheme.onSurface)),
              background: Container(decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [theme.scaffoldBackgroundColor, theme.scaffoldBackgroundColor.withOpacity(0.0)]))),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate([

                // --- БЛОК 1: ГЛАВНАЯ ИНФО ---
                GlassContainer(
                  padding: const EdgeInsets.all(24),
                  color: _isPaused ? theme.disabledColor.withOpacity(0.05) : theme.colorScheme.surface.withOpacity(0.4),
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        _buildMedicineImageOrIcon(theme),
                        const SizedBox(height: 16),
                        Text(widget.medicine.name, style: theme.textTheme.displayLarge?.copyWith(fontSize: 28, color: _isPaused ? theme.disabledColor : null), textAlign: TextAlign.center),
                        const SizedBox(height: 8),
                        Text('$dosage ${widget.medicine.dosageUnit}', style: theme.textTheme.titleLarge?.copyWith(color: _isPaused ? theme.disabledColor : theme.colorScheme.secondary)),

                        if (_isPaused) ...[
                          const SizedBox(height: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(color: Colors.orange.withOpacity(0.1), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.orange.withOpacity(0.5))),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.pause_circle_filled, color: Colors.orange, size: 16),
                                const SizedBox(width: 6),
                                Text(l10n.coursePaused, style: theme.textTheme.bodyMedium?.copyWith(color: Colors.orange, fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ]
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // --- BENTO БЛОК 2: СКЛАД (С акцентом на окончание) ---
                Text('Inventory', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: theme.colorScheme.onSurface.withOpacity(0.6))),
                const SizedBox(height: 12),
                GlassContainer(
                  padding: const EdgeInsets.all(20),
                  color: widget.medicine.pillsRemaining == 0 ? theme.colorScheme.error.withOpacity(0.05) : theme.colorScheme.surface.withOpacity(0.4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(l10n.pillsRemaining, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                          if (widget.medicine.pillsRemaining == 0)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(color: theme.colorScheme.error.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                              child: Text(l10n.outOfStockBadge, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.error, fontWeight: FontWeight.bold)),
                            )
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
                                backgroundColor: theme.dividerColor.withOpacity(0.1),
                                color: widget.medicine.pillsRemaining == 0 ? theme.colorScheme.error : (progress > 0.2 ? theme.colorScheme.secondary : Colors.orange),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Text('${widget.medicine.pillsRemaining} / ${widget.medicine.pillsInPackage}', style: theme.textTheme.titleLarge),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // --- 🚀 BENTO БЛОК 3: НЕДАВНЯЯ ИСТОРИЯ ---
                Text(l10n.recentHistory, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: theme.colorScheme.onSurface.withOpacity(0.6))),
                const SizedBox(height: 12),
                GlassContainer(
                  padding: const EdgeInsets.all(16),
                  color: theme.colorScheme.surface.withOpacity(0.4),
                  child: historyAsync.when(
                    data: (logs) {
                      if (logs.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Center(child: Text(l10n.noHistoryYet, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurface.withOpacity(0.5)))),
                        );
                      }
                      return Column(
                        children: logs.map((log) {
                          final isTaken = log.status == DoseStatusEnum.taken;
                          final statusColor = isTaken ? theme.colorScheme.secondary : theme.colorScheme.error;
                          final dateStr = DateFormat('MMM d, HH:mm', Localizations.localeOf(context).languageCode).format(log.scheduledTime);

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: Row(
                              children: [
                                Icon(isTaken ? Icons.check_circle : Icons.cancel, color: statusColor, size: 20),
                                const SizedBox(width: 12),
                                Expanded(child: Text(dateStr, style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500))),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(color: statusColor.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                                  child: Text(isTaken ? l10n.statusTaken : l10n.statusSkipped, style: theme.textTheme.bodySmall?.copyWith(color: statusColor, fontWeight: FontWeight.bold)),
                                )
                              ],
                            ),
                          );
                        }).toList(),
                      );
                    },
                    loading: () => const Center(child: CircularProgressIndicator()),
                    error: (err, stack) => const Center(child: Text('Error')),
                  ),
                ),
                const SizedBox(height: 24),

                // --- БЛОК 4: УПРАВЛЕНИЕ ---
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: _isPaused ? theme.colorScheme.secondary.withOpacity(0.1) : Colors.orange.withOpacity(0.1),
                          foregroundColor: _isPaused ? theme.colorScheme.secondary : Colors.orange,
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                        onPressed: _togglePause,
                        icon: Icon(_isPaused ? Icons.play_arrow : Icons.pause),
                        label: Text(_isPaused ? l10n.resumeCourse : l10n.pauseCourse),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: theme.primaryColor.withOpacity(0.1),
                          foregroundColor: theme.primaryColor,
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                        onPressed: () => _generatePdfReport(l10n),
                        icon: const Icon(Icons.picture_as_pdf),
                        label: Text(l10n.doctorReport),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // КНОПКА УДАЛЕНИЯ
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: theme.colorScheme.error.withOpacity(0.1),
                      foregroundColor: theme.colorScheme.error,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    onPressed: () => _confirmDelete(context, l10n),
                    icon: const Icon(Icons.delete_outline),
                    label: Text(l10n.deleteCourse),
                  ),
                ),
                const SizedBox(height: 40),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}