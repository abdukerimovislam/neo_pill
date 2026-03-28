import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:neo_pill/features/home/presentation/widgets/pill_icon_widget.dart';

import '../../../../core/presentation/widgets/glass_container.dart';
import '../../../../core/presentation/widgets/motion_pressable.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../data/local/entities/dose_log_entity.dart';
import '../../../../data/local/entities/medicine_entity.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../l10n/l10n_extensions.dart';
import '../../../medicine_management/presentation/medicine_detail_screen.dart';
import '../../providers/home_controller.dart';
import '../../providers/home_provider.dart';

class DoseCard extends ConsumerWidget {
  final DoseScheduleItem item;

  const DoseCard({super.key, required this.item});

  bool _isComplexCourse(MedicineEntity? medicine) {
    if (medicine == null) return false;
    if (medicine.frequency == FrequencyTypeEnum.tapering) return true;
    return item.doseLog.dosage > 0 &&
        (item.doseLog.dosage - medicine.dosage).abs() > 0.001;
  }

  String _kindLabel(MedicineEntity? medicine, AppLocalizations l10n) {
    final kind = medicine?.kind ?? CourseKindEnum.medication;
    return l10n.courseKindLabel(kind);
  }

  String _heroTag() => 'dose-card-${item.doseLog.id}';

  Gradient _cardGradient(MedicineEntity? medicine, ThemeData theme) {
    final kind = medicine?.kind ?? CourseKindEnum.medication;
    final isTaken = item.doseLog.status == DoseStatusEnum.taken;

    if (kind == CourseKindEnum.supplement) {
      return LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          const Color(0xFFBFD7F2).withValues(alpha: isTaken ? 0.82 : 0.92),
          const Color(0xFF9FB8D4).withValues(alpha: isTaken ? 0.9 : 0.98),
        ],
      );
    }

    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        const Color(0xFF8ED1A6).withValues(alpha: isTaken ? 0.82 : 0.92),
        const Color(0xFF6BBFB2).withValues(alpha: isTaken ? 0.9 : 0.98),
      ],
    );
  }

  Color _primaryTextColor(MedicineEntity? medicine) {
    final kind = medicine?.kind ?? CourseKindEnum.medication;
    return kind == CourseKindEnum.supplement
        ? const Color(0xFF24415F)
        : const Color(0xFF1C4A3A);
  }

  Color _secondaryTextColor(MedicineEntity? medicine) {
    final kind = medicine?.kind ?? CourseKindEnum.medication;
    return kind == CourseKindEnum.supplement
        ? const Color(0xFF355675)
        : const Color(0xFF2B6050);
  }

  Color _softPanelColor(MedicineEntity? medicine) {
    final kind = medicine?.kind ?? CourseKindEnum.medication;
    return (kind == CourseKindEnum.supplement
            ? const Color(0xFFF6FAFF)
            : const Color(0xFFF7FFFA))
        .withValues(alpha: 0.82);
  }

  Widget _buildMedicineImageOrIcon(MedicineEntity? medicine, ThemeData theme) {
    if (medicine != null) {
      final imagePath = medicine.pillImagePath;
      return Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: theme.colorScheme.surface.withValues(alpha: 0.92),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Color(medicine.pillColor).withValues(alpha: 0.3),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Color(medicine.pillColor).withValues(alpha: 0.12),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: imagePath != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.file(
                  File(imagePath),
                  fit: BoxFit.cover,
                  width: 56,
                  height: 56,
                  errorBuilder: (context, error, stackTrace) => Center(
                    child: PillIconWidget(
                      shape: medicine.pillShape,
                      colorHex: medicine.pillColor,
                      size: 28,
                    ),
                  ),
                ),
              )
            : Center(
                child: PillIconWidget(
                  shape: medicine.pillShape,
                  colorHex: medicine.pillColor,
                  size: 28,
                ),
              ),
      );
    }

    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color:
            ((medicine?.kind ?? CourseKindEnum.medication) ==
                        CourseKindEnum.supplement
                    ? theme.supplementAccent
                    : theme.brandPrimary)
                .withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Icon(
        (medicine?.kind ?? CourseKindEnum.medication) ==
                CourseKindEnum.supplement
            ? Icons.spa_rounded
            : Icons.medication_rounded,
        size: 28,
        color:
            (medicine?.kind ?? CourseKindEnum.medication) ==
                CourseKindEnum.supplement
            ? theme.supplementAccent
            : theme.brandPrimary,
      ),
    );
  }

  Widget? _buildFoodTag(
    FoodInstructionEnum? food,
    ThemeData theme,
    AppLocalizations l10n,
  ) {
    if (food == null || food == FoodInstructionEnum.noMatter) {
      return null;
    }

    IconData icon;
    String text;
    Color color = theme.supplementAccent;

    switch (food) {
      case FoodInstructionEnum.beforeFood:
        icon = Icons.restaurant_menu_rounded;
        text = l10n.foodBefore;
        color = theme.brandPrimary;
      case FoodInstructionEnum.withFood:
        icon = Icons.restaurant_rounded;
        text = l10n.foodWith;
      case FoodInstructionEnum.afterFood:
        icon = Icons.local_dining_rounded;
        text = l10n.foodAfter;
        color = theme.warningAccent;
      default:
        return null;
    }

    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 6),
          Text(
            text,
            style: theme.textTheme.bodySmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final controller = ref.read(homeControllerProvider);

    final medicine = item.medicine;
    final isComplexCourse = _isComplexCourse(medicine);
    final medicineName = medicine?.name ?? l10n.unknownMedicine;
    final rawDosage = item.doseLog.dosage > 0
        ? item.doseLog.dosage
        : (medicine?.dosage ?? 0);
    final dosage = rawDosage % 1 == 0
        ? rawDosage.toInt().toString()
        : rawDosage.toString();
    final unit = medicine != null
        ? l10n.dosageUnitLabel(medicine.dosageUnit)
        : '';
    final timeString = DateFormat.Hm(
      Localizations.localeOf(context).languageCode,
    ).format(item.doseLog.scheduledTime);
    final isFutureDose = item.doseLog.scheduledTime.isAfter(DateTime.now());
    final statusLabel = switch (item.doseLog.status) {
      DoseStatusEnum.taken => l10n.statusTaken,
      DoseStatusEnum.skipped => l10n.statusSkipped,
      _ =>
        isFutureDose ? l10n.homeScheduledFor(timeString) : l10n.statusPending,
    };

    final statusColor = theme.doseStatusAccent(
      item.doseLog.status,
      isFutureDose: isFutureDose,
    );
    final primaryTextColor = _primaryTextColor(medicine);
    final secondaryTextColor = _secondaryTextColor(medicine);
    final softPanelColor = _softPanelColor(medicine);
    IconData statusIcon;

    switch (item.doseLog.status) {
      case DoseStatusEnum.taken:
        statusIcon = Icons.check_circle_rounded;
      case DoseStatusEnum.skipped:
        statusIcon = Icons.cancel_rounded;
      default:
        statusIcon = Icons.schedule_rounded;
    }

    return MotionPressable(
      borderRadius: BorderRadius.circular(24),
      onTap: () async {
        if (medicine != null) {
          final result = await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>
                  MedicineDetailScreen(medicine: medicine, heroTag: _heroTag()),
            ),
          );
          if (context.mounted && result is String && result.isNotEmpty) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(result)));
          }
        }
      },
      child: GlassContainer(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(14),
        gradient: _cardGradient(medicine, theme),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: softPanelColor,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: statusColor.withValues(alpha: 0.18),
                    ),
                  ),
                  child: Column(
                    children: [
                      Icon(statusIcon, color: statusColor, size: 20),
                      const SizedBox(height: 2),
                      Text(
                        timeString,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: statusColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Hero(
                  tag: _heroTag(),
                  child: Material(
                    color: Colors.transparent,
                    child: _buildMedicineImageOrIcon(medicine, theme),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        medicineName,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: primaryTextColor,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 3),
                      Text(
                        '$dosage $unit',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: secondaryTextColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: [
                          if (isComplexCourse)
                            _InventoryBadge(
                              label: l10n.scheduleComplexTitle,
                              color: theme.brandPrimary,
                              icon: Icons.timeline_rounded,
                            ),
                          if (medicine != null)
                            _InventoryBadge(
                              label: _kindLabel(medicine, l10n),
                              color: theme.courseAccent(medicine.kind),
                              icon: medicine.kind == CourseKindEnum.supplement
                                  ? Icons.spa_rounded
                                  : Icons.local_hospital_rounded,
                            ),
                          if (medicine != null && medicine.pillsRemaining == 0)
                            _InventoryBadge(
                              label: l10n.outOfStockBadge,
                              color: theme.dangerAccent,
                              icon: Icons.error_outline_rounded,
                            )
                          else if (medicine != null &&
                              medicine.pillsRemaining <=
                                  medicine.refillAlertThreshold)
                            _InventoryBadge(
                              label: l10n.lowStockBadge,
                              color: theme.warningAccent,
                              icon: Icons.inventory_2_rounded,
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: softPanelColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: primaryTextColor.withValues(alpha: 0.12),
                    ),
                  ),
                  child: Icon(
                    Icons.chevron_right_rounded,
                    color: primaryTextColor.withValues(alpha: 0.5),
                  ),
                ),
              ],
            ),
            if (medicine?.foodInstruction != null)
              _buildFoodTag(medicine!.foodInstruction, theme, l10n) ??
                  const SizedBox.shrink(),
            const SizedBox(height: 10),
            _StatusPill(
              label: statusLabel,
              color: statusColor,
              icon: statusIcon,
            ),
            const SizedBox(height: 14),
            if (item.doseLog.status == DoseStatusEnum.pending && !isFutureDose)
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => controller.updateDoseStatus(
                        item.doseLog,
                        DoseStatusEnum.taken,
                      ),
                      icon: const Icon(Icons.check_circle_rounded),
                      label: Text(l10n.takeAction),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => controller.updateDoseStatus(
                        item.doseLog,
                        DoseStatusEnum.skipped,
                      ),
                      icon: const Icon(Icons.close_rounded),
                      label: Text(l10n.skipAction),
                    ),
                  ),
                ],
              )
            else if (item.doseLog.status != DoseStatusEnum.pending)
              Row(
                children: [
                  Icon(statusIcon, color: statusColor, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      item.doseLog.status == DoseStatusEnum.taken
                          ? l10n.statusTaken
                          : l10n.statusSkipped,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: primaryTextColor,
                      ),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () => controller.undoDoseStatus(item.doseLog),
                    icon: const Icon(Icons.undo_rounded),
                    label: Text(l10n.undoAction),
                  ),
                ],
              )
            else
              Text(
                l10n.statusPending,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: secondaryTextColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _InventoryBadge extends StatelessWidget {
  final String label;
  final Color color;
  final IconData? icon;

  const _InventoryBadge({
    required this.label,
    required this.color,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.26)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: color),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w800,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  final String label;
  final Color color;
  final IconData icon;

  const _StatusPill({
    required this.label,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.18)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }
}
