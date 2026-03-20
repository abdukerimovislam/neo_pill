import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:neo_pill/features/home/presentation/widgets/pill_icon_widget.dart';
import '../../../../data/local/entities/dose_log_entity.dart';
import '../../../../data/local/entities/medicine_entity.dart';
import '../../../../l10n/app_localizations.dart';
import '../../providers/home_provider.dart';
import '../../providers/home_controller.dart';
import '../../../medicine_management/presentation/medicine_detail_screen.dart';
import '../../../../core/presentation/widgets/glass_container.dart';

class DoseCard extends ConsumerWidget {
  final DoseScheduleItem item;

  const DoseCard({super.key, required this.item});

  // 🚀 НОВОЕ: Отрисовка таблетки через Визуальный Конструктор
  Widget _buildMedicineImageOrIcon(MedicineEntity? medicine, ThemeData theme) {
    if (medicine != null) {
      return Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: theme.colorScheme.surface.withOpacity(0.5),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Color(medicine.pillColor).withOpacity(0.3), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Color(medicine.pillColor).withOpacity(0.15),
              blurRadius: 8,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Center(
          child: PillIconWidget(
            shape: medicine.pillShape,
            colorHex: medicine.pillColor,
            size: 20,
          ),
        ),
      );
    }

    // Если лекарство не найдено (ошибка базы)
    return Container(
      width: 48, height: 48,
      decoration: BoxDecoration(color: theme.primaryColor.withOpacity(0.1), borderRadius: BorderRadius.circular(14)),
      child: Icon(Icons.medication, size: 24, color: theme.primaryColor),
    );
  }

  Widget? _buildFoodTag(FoodInstructionEnum? food, ThemeData theme, AppLocalizations l10n) {
    if (food == null || food == FoodInstructionEnum.noMatter) return null;

    IconData icon;
    String text;
    Color color = theme.colorScheme.secondary;

    switch (food) {
      case FoodInstructionEnum.beforeFood:
        icon = Icons.restaurant_menu;
        text = l10n.foodBefore;
        color = theme.colorScheme.primary;
        break;
      case FoodInstructionEnum.withFood:
        icon = Icons.restaurant;
        text = l10n.foodWith;
        break;
      case FoodInstructionEnum.afterFood:
        icon = Icons.local_dining;
        text = l10n.foodAfter;
        color = Colors.orange.shade700;
        break;
      default: return null;
    }

    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(text, style: theme.textTheme.bodySmall?.copyWith(color: color, fontWeight: FontWeight.w600)),
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
    final rawDosage = medicine?.dosage ?? 0;
    final dosage = rawDosage % 1 == 0 ? rawDosage.toInt().toString() : rawDosage.toString();
    final unit = medicine?.dosageUnit ?? '';

    final timeString = DateFormat.Hm(Localizations.localeOf(context).languageCode).format(item.doseLog.scheduledTime);

    final now = DateTime.now();
    final endOfToday = DateTime(now.year, now.month, now.day, 23, 59, 59);
    final isFutureDay = item.doseLog.scheduledTime.isAfter(endOfToday);

    Color statusColor;
    IconData statusIcon;

    switch (item.doseLog.status) {
      case DoseStatusEnum.taken:
        statusColor = theme.colorScheme.secondary;
        statusIcon = Icons.check_circle;
        break;
      case DoseStatusEnum.skipped:
        statusColor = theme.colorScheme.error;
        statusIcon = Icons.cancel;
        break;
      default:
        statusColor = isFutureDay ? theme.primaryColor.withOpacity(0.4) : theme.primaryColor;
        statusIcon = Icons.schedule;
    }

    return GestureDetector(
      onTap: () {
        if (medicine != null) {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => MedicineDetailScreen(medicine: medicine)));
        }
      },
      child: GlassContainer(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(statusIcon, color: statusColor, size: 28),
                const SizedBox(height: 8),
                Text(timeString, style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold, color: statusColor)),
              ],
            ),
            Container(height: 50, width: 1, margin: const EdgeInsets.symmetric(horizontal: 16), color: theme.dividerColor.withOpacity(0.2)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildMedicineImageOrIcon(medicine, theme),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(medicineName, style: theme.textTheme.titleLarge?.copyWith(fontSize: 18), maxLines: 1, overflow: TextOverflow.ellipsis),
                            const SizedBox(height: 2),
                            Text('$dosage $unit', style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurface.withOpacity(0.7), fontWeight: FontWeight.w500)),

                            if (medicine != null && medicine.pillsRemaining == 0) ...[
                              const SizedBox(height: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(color: theme.colorScheme.error.withOpacity(0.15), borderRadius: BorderRadius.circular(4), border: Border.all(color: theme.colorScheme.error)),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.error_outline, size: 12, color: theme.colorScheme.error),
                                    const SizedBox(width: 4),
                                    Text(l10n.outOfStockBadge, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.error, fontWeight: FontWeight.bold, fontSize: 10)),
                                  ],
                                ),
                              ),
                            ] else if (medicine != null && medicine.pillsRemaining <= medicine.refillAlertThreshold) ...[
                              const SizedBox(height: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(color: Colors.orange.withOpacity(0.15), borderRadius: BorderRadius.circular(4), border: Border.all(color: Colors.orange.withOpacity(0.5))),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.warning_amber_rounded, size: 12, color: Colors.orange),
                                    const SizedBox(width: 4),
                                    Text(l10n.lowStockBadge, style: theme.textTheme.bodySmall?.copyWith(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 10)),
                                  ],
                                ),
                              ),
                            ]
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (medicine?.foodInstruction != null) ...[
                    _buildFoodTag(medicine!.foodInstruction, theme, l10n) ?? const SizedBox.shrink(),
                  ]
                ],
              ),
            ),
            if (item.doseLog.status == DoseStatusEnum.pending && !isFutureDay) ...[
              const SizedBox(width: 8),
              Column(
                children: [
                  IconButton(
                    style: IconButton.styleFrom(backgroundColor: theme.colorScheme.secondary.withOpacity(0.1), padding: const EdgeInsets.all(12)),
                    icon: Icon(Icons.check, color: theme.colorScheme.secondary),
                    onPressed: () => controller.updateDoseStatus(item.doseLog, DoseStatusEnum.taken),
                  ),
                  const SizedBox(height: 8),
                  IconButton(
                    style: IconButton.styleFrom(padding: const EdgeInsets.all(8)),
                    icon: Icon(Icons.close, color: theme.colorScheme.error, size: 20),
                    onPressed: () => controller.updateDoseStatus(item.doseLog, DoseStatusEnum.skipped),
                  ),
                ],
              ),
            ] else if (item.doseLog.status != DoseStatusEnum.pending) ...[
              const SizedBox(width: 8),
              IconButton(
                style: IconButton.styleFrom(backgroundColor: theme.dividerColor.withOpacity(0.05), padding: const EdgeInsets.all(12)),
                icon: Icon(Icons.undo, color: theme.colorScheme.onSurface.withOpacity(0.5)),
                onPressed: () => controller.undoDoseStatus(item.doseLog),
              ),
            ]
          ],
        ),
      ),
    );
  }
}