import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:neo_pill/features/home/presentation/widgets/pill_icon_widget.dart';

import '../../../../core/presentation/widgets/glass_container.dart';
import '../../../../data/local/entities/dose_log_entity.dart';
import '../../../../data/local/entities/medicine_entity.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../medicine_management/presentation/medicine_detail_screen.dart';
import '../../providers/home_controller.dart';
import '../../providers/home_provider.dart';

class DoseCard extends ConsumerWidget {
  final DoseScheduleItem item;

  const DoseCard({super.key, required this.item});

  Widget _buildMedicineImageOrIcon(MedicineEntity? medicine, ThemeData theme) {
    if (medicine != null) {
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
        child:
            medicine.pillImagePath != null &&
                File(medicine.pillImagePath!).existsSync()
            ? ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.file(
                  File(medicine.pillImagePath!),
                  fit: BoxFit.cover,
                  width: 56,
                  height: 56,
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
        color: theme.primaryColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Icon(
        Icons.medication_rounded,
        size: 28,
        color: theme.primaryColor,
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
    Color color = theme.colorScheme.secondary;

    switch (food) {
      case FoodInstructionEnum.beforeFood:
        icon = Icons.restaurant_menu_rounded;
        text = l10n.foodBefore;
        color = theme.colorScheme.primary;
      case FoodInstructionEnum.withFood:
        icon = Icons.restaurant_rounded;
        text = l10n.foodWith;
      case FoodInstructionEnum.afterFood:
        icon = Icons.local_dining_rounded;
        text = l10n.foodAfter;
        color = Colors.orange.shade700;
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
    final medicineName = medicine?.name ?? l10n.unknownMedicine;
    final rawDosage = item.doseLog.dosage > 0
        ? item.doseLog.dosage
        : (medicine?.dosage ?? 0);
    final dosage = rawDosage % 1 == 0
        ? rawDosage.toInt().toString()
        : rawDosage.toString();
    final unit = medicine?.dosageUnit ?? '';
    final timeString = DateFormat.Hm(
      Localizations.localeOf(context).languageCode,
    ).format(item.doseLog.scheduledTime);
    final isFutureDose = item.doseLog.scheduledTime.isAfter(DateTime.now());
    final localeCode = Localizations.localeOf(context).languageCode;
    final statusLabel = switch (item.doseLog.status) {
      DoseStatusEnum.taken => l10n.statusTaken,
      DoseStatusEnum.skipped => l10n.statusSkipped,
      _ => isFutureDose
          ? (localeCode == 'ru' ? 'Запланировано' : 'Scheduled')
          : l10n.statusPending,
    };

    Color statusColor;
    IconData statusIcon;

    switch (item.doseLog.status) {
      case DoseStatusEnum.taken:
        statusColor = theme.colorScheme.secondary;
        statusIcon = Icons.check_circle_rounded;
      case DoseStatusEnum.skipped:
        statusColor = theme.colorScheme.error;
        statusIcon = Icons.cancel_rounded;
      default:
        statusColor = isFutureDose
            ? theme.primaryColor.withValues(alpha: 0.42)
            : theme.primaryColor;
        statusIcon = Icons.schedule_rounded;
    }

    return GestureDetector(
      onTap: () {
        if (medicine != null) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => MedicineDetailScreen(medicine: medicine),
            ),
          );
        }
      },
      child: GlassContainer(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(18),
        color: item.doseLog.status == DoseStatusEnum.taken
            ? theme.colorScheme.secondary.withValues(alpha: 0.06)
            : theme.colorScheme.surface.withValues(alpha: 0.84),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Icon(statusIcon, color: statusColor, size: 24),
                      const SizedBox(height: 6),
                      Text(
                        timeString,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: statusColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 14),
                _buildMedicineImageOrIcon(medicine, theme),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        medicineName,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: theme.colorScheme.onSurface,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '$dosage $unit',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.onSurface.withValues(
                            alpha: 0.66,
                          ),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (medicine != null && medicine.pillsRemaining == 0) ...[
                        const SizedBox(height: 8),
                        _InventoryBadge(
                          label: l10n.outOfStockBadge,
                          color: theme.colorScheme.error,
                        ),
                      ] else if (medicine != null &&
                          medicine.pillsRemaining <=
                              medicine.refillAlertThreshold) ...[
                        const SizedBox(height: 8),
                        _InventoryBadge(
                          label: l10n.lowStockBadge,
                          color: Colors.orange,
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface.withValues(alpha: 0.9),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: theme.dividerColor.withValues(alpha: 0.12),
                    ),
                  ),
                  child: Icon(
                    Icons.chevron_right_rounded,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.42),
                  ),
                ),
              ],
            ),
            if (medicine?.foodInstruction != null)
              _buildFoodTag(medicine!.foodInstruction, theme, l10n) ??
                  const SizedBox.shrink(),
            const SizedBox(height: 12),
            _StatusPill(
              label: statusLabel,
              color: statusColor,
            ),
            const SizedBox(height: 16),
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
                        color: theme.colorScheme.onSurface,
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
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.55),
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

  const _InventoryBadge({required this.label, required this.color});

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
      child: Text(
        label,
        style: theme.textTheme.bodySmall?.copyWith(
          color: color,
          fontWeight: FontWeight.w800,
          fontSize: 10,
        ),
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  final String label;
  final Color color;

  const _StatusPill({
    required this.label,
    required this.color,
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
      child: Text(
        label,
        style: theme.textTheme.bodySmall?.copyWith(
          color: color,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}
