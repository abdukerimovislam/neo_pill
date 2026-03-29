import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  Color _accentColor(MedicineEntity? medicine, ThemeData theme) {
    final kind = medicine?.kind ?? CourseKindEnum.medication;
    return kind == CourseKindEnum.supplement
        ? theme.supplementAccent
        : theme.brandPrimary;
  }

  Widget _buildMedicineImageOrIcon(MedicineEntity? medicine, ThemeData theme) {
    if (medicine != null) {
      final imagePath = medicine.pillImagePath;
      return Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: theme.colorScheme.surface.withValues(alpha: 0.95),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: Color(medicine.pillColor).withValues(alpha: 0.24),
            width: 1.4,
          ),
        ),
        child: imagePath != null
            ? ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.file(
            File(imagePath),
            fit: BoxFit.cover,
            width: 48,
            height: 48,
            errorBuilder: (context, error, stackTrace) => Center(
              child: PillIconWidget(
                shape: medicine.pillShape,
                colorHex: medicine.pillColor,
                size: 24,
              ),
            ),
          ),
        )
            : Center(
          child: PillIconWidget(
            shape: medicine.pillShape,
            colorHex: medicine.pillColor,
            size: 24,
          ),
        ),
      );
    }

    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: ((medicine?.kind ?? CourseKindEnum.medication) ==
            CourseKindEnum.supplement
            ? theme.supplementAccent
            : theme.brandPrimary)
            .withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Icon(
        (medicine?.kind ?? CourseKindEnum.medication) ==
            CourseKindEnum.supplement
            ? Icons.spa_rounded
            : Icons.medication_rounded,
        size: 24,
        color: (medicine?.kind ?? CourseKindEnum.medication) ==
            CourseKindEnum.supplement
            ? theme.supplementAccent
            : theme.brandPrimary,
      ),
    );
  }

  // Собираем дозировку, тип и еду в одну красивую строку
  String _buildSubtitle(
      MedicineEntity? medicine, DoseScheduleItem item, AppLocalizations l10n) {
    final parts = <String>[];

    final rawDosage = item.doseLog.dosage > 0
        ? item.doseLog.dosage
        : (medicine?.dosage ?? 0);
    final dosage = rawDosage % 1 == 0
        ? rawDosage.toInt().toString()
        : rawDosage.toString();

    final unit = medicine != null ? l10n.dosageUnitLabel(medicine.dosageUnit) : '';
    parts.add('$dosage $unit'.trim());

    parts.add(_kindLabel(medicine, l10n));

    if (medicine?.foodInstruction != null &&
        medicine!.foodInstruction != FoodInstructionEnum.noMatter) {
      switch (medicine.foodInstruction!) {
        case FoodInstructionEnum.beforeFood:
          parts.add(l10n.foodBefore);
          break;
        case FoodInstructionEnum.withFood:
          parts.add(l10n.foodWith);
          break;
        case FoodInstructionEnum.afterFood:
          parts.add(l10n.foodAfter);
          break;
        default:
          break;
      }
    }

    return parts.join(' • ');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final controller = ref.read(homeControllerProvider);

    final medicine = item.medicine;
    final isComplexCourse = _isComplexCourse(medicine);
    final medicineName = medicine?.name ?? l10n.unknownMedicine;

    final timeString = DateFormat.Hm(
      Localizations.localeOf(context).languageCode,
    ).format(item.doseLog.scheduledTime);

    final isFutureDose = item.doseLog.scheduledTime.isAfter(DateTime.now());

    final statusLabel = switch (item.doseLog.status) {
      DoseStatusEnum.taken => l10n.statusTaken,
      DoseStatusEnum.skipped => l10n.statusSkipped,
      _ => isFutureDose ? l10n.homeScheduledFor(timeString) : l10n.statusPending,
    };

    final semanticFullLabel =
        '$medicineName. ${_buildSubtitle(medicine, item, l10n)}. $timeString. $statusLabel';

    final statusColor = theme.doseStatusAccent(
      item.doseLog.status,
      isFutureDose: isFutureDose,
    );

    final primaryTextColor = _primaryTextColor(medicine);
    final secondaryTextColor = _secondaryTextColor(medicine);
    final accentColor = _accentColor(medicine, theme);

    IconData statusIcon;
    switch (item.doseLog.status) {
      case DoseStatusEnum.taken:
        statusIcon = Icons.check_circle_rounded;
        break;
      case DoseStatusEnum.skipped:
        statusIcon = Icons.cancel_rounded;
        break;
      default:
        statusIcon = Icons.schedule_rounded;
    }

    return Semantics(
      label: semanticFullLabel,
      button: true,
      child: MotionPressable(
        borderRadius: BorderRadius.circular(22),
        onTap: () async {
          HapticFeedback.lightImpact();
          if (medicine != null) {
            final result = await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => MedicineDetailScreen(
                  medicine: medicine,
                  heroTag: _heroTag(),
                ),
              ),
            );
            if (context.mounted && result is String && result.isNotEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(result)),
              );
            }
          }
        },
        child: GlassContainer(
          margin: const EdgeInsets.only(bottom: 6),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          color: theme.colorScheme.surface.withValues(alpha: 0.78),
          borderRadius: 22,
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 54,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.10),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          statusIcon,
                          color: statusColor,
                          size: 16,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          timeString,
                          style: theme.textTheme.labelMedium?.copyWith(
                            fontWeight: FontWeight.w900,
                            color: statusColor,
                          ),
                          textAlign: TextAlign.center,
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
                            fontWeight: FontWeight.w900,
                            color: primaryTextColor,
                            height: 1.1,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        // Единая, чистая текстовая строка с информацией (Без Wrap и тегов)
                        Text(
                          _buildSubtitle(medicine, item, l10n),
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: secondaryTextColor.withValues(alpha: 0.8),
                            fontWeight: FontWeight.w600,
                            height: 1.3,
                          ),
                        ),
                        // Показываем аллерты только если они есть (Сложное расписание или Заканчивается)
                        if (isComplexCourse ||
                            (medicine != null &&
                                medicine.pillsRemaining <=
                                    medicine.refillAlertThreshold))
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Wrap(
                              spacing: 6,
                              runSpacing: 6,
                              children: [
                                if (isComplexCourse)
                                  _AlertTag(
                                    label: l10n.scheduleComplexTitle,
                                    color: theme.brandPrimary,
                                    icon: Icons.timeline_rounded,
                                  ),
                                if (medicine != null &&
                                    medicine.pillsRemaining <= 0)
                                  _AlertTag(
                                    label: l10n.outOfStockBadge,
                                    color: theme.dangerAccent,
                                    icon: Icons.error_outline_rounded,
                                  )
                                else if (medicine != null &&
                                    medicine.pillsRemaining <=
                                        medicine.refillAlertThreshold)
                                  _AlertTag(
                                    label: l10n.lowStockBadge,
                                    color: theme.warningAccent,
                                    icon: Icons.inventory_2_rounded,
                                  ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.chevron_right_rounded,
                    color: accentColor.withValues(alpha: 0.38),
                    size: 20,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _DoseActionRow(
                item: item,
                medicineName: medicineName,
                statusColor: statusColor,
                primaryTextColor: primaryTextColor,
                onTake: () {
                  HapticFeedback.mediumImpact();
                  controller.updateDoseStatus(
                    item.doseLog,
                    DoseStatusEnum.taken,
                  );
                },
                onSkip: () {
                  HapticFeedback.mediumImpact();
                  controller.updateDoseStatus(
                    item.doseLog,
                    DoseStatusEnum.skipped,
                  );
                },
                onUndo: () {
                  HapticFeedback.mediumImpact();
                  controller.undoDoseStatus(item.doseLog);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DoseActionRow extends StatelessWidget {
  final DoseScheduleItem item;
  final String medicineName;
  final Color statusColor;
  final Color primaryTextColor;
  final VoidCallback onTake;
  final VoidCallback onSkip;
  final VoidCallback onUndo;

  const _DoseActionRow({
    required this.item,
    required this.medicineName,
    required this.statusColor,
    required this.primaryTextColor,
    required this.onTake,
    required this.onSkip,
    required this.onUndo,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final now = DateTime.now();
    final isFutureDose = item.doseLog.scheduledTime.isAfter(now);

    if (item.doseLog.status == DoseStatusEnum.pending && !isFutureDose) {
      return Row(
        children: [
          Expanded(
            child: Semantics(
              label: '${l10n.takeAction} $medicineName',
              button: true,
              child: SizedBox(
                height: 44,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: onTake,
                  icon: const Icon(Icons.check_circle_rounded, size: 20),
                  label: Text(
                    l10n.takeAction,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Semantics(
              label: '${l10n.skipAction} $medicineName',
              button: true,
              child: SizedBox(
                height: 44,
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: onSkip,
                  icon: const Icon(Icons.close_rounded, size: 20),
                  label: Text(
                    l10n.skipAction,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }

    if (item.doseLog.status != DoseStatusEnum.pending) {
      final isTaken = item.doseLog.status == DoseStatusEnum.taken;

      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: statusColor.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Icon(
              isTaken ? Icons.check_circle_rounded : Icons.cancel_rounded,
              color: statusColor,
              size: 20,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                isTaken ? l10n.statusTaken : l10n.statusSkipped,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: primaryTextColor,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Semantics(
              label: '${l10n.undoAction} $medicineName',
              button: true,
              child: SizedBox(
                height: 36,
                child: TextButton.icon(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                  ),
                  onPressed: onUndo,
                  icon: const Icon(Icons.undo_rounded, size: 18),
                  label: Text(
                    l10n.undoAction,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: statusColor.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        l10n.statusPending,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: primaryTextColor.withValues(alpha: 0.76),
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

// Новый безопасный тег с использованием Text.rich
// Он никогда не вызывает Overflow
class _AlertTag extends StatelessWidget {
  final String label;
  final Color color;
  final IconData icon;

  const _AlertTag({
    required this.label,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: color.withValues(alpha: 0.16),
        ),
      ),
      child: Text.rich(
        TextSpan(
          children: [
            WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: Padding(
                padding: const EdgeInsets.only(right: 4),
                child: Icon(icon, size: 14, color: color),
              ),
            ),
            TextSpan(
              text: label,
              style: theme.textTheme.labelSmall?.copyWith(
                color: color,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}