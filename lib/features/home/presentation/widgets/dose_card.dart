import 'dart:io'; // 🚀 ДОБАВЛЕНО ДЛЯ РАБОТЫ С ФОТО
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

  // 🚀 ОБНОВЛЕНО: ТЕПЕРЬ ПОДДЕРЖИВАЕТ РЕАЛЬНЫЕ ФОТО ИЗ КАМЕРЫ
  Widget _buildMedicineImageOrIcon(MedicineEntity? medicine, ThemeData theme) {
    if (medicine != null) {
      return Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: theme.colorScheme.surface.withValues(alpha: 0.8),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Color(medicine.pillColor).withValues(alpha: 0.3), width: 2),
          boxShadow: [
            BoxShadow(color: Color(medicine.pillColor).withValues(alpha: 0.15), blurRadius: 12, offset: const Offset(0, 4))
          ],
        ),
        child: medicine.pillImagePath != null && File(medicine.pillImagePath!).existsSync()
            ? ClipRRect(
          borderRadius: BorderRadius.circular(14), // Скругление чуть меньше, чтобы влезло в рамку
          child: Image.file(
            File(medicine.pillImagePath!),
            fit: BoxFit.cover,
            width: 56,
            height: 56,
          ),
        )
            : Center(child: PillIconWidget(shape: medicine.pillShape, colorHex: medicine.pillColor, size: 28)),
      );
    }
    return Container(
      width: 56, height: 56,
      decoration: BoxDecoration(color: theme.primaryColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(16)),
      child: Icon(Icons.medication_rounded, size: 28, color: theme.primaryColor),
    );
  }

  Widget? _buildFoodTag(FoodInstructionEnum? food, ThemeData theme, AppLocalizations l10n) {
    if (food == null || food == FoodInstructionEnum.noMatter) return null;

    IconData icon; String text; Color color = theme.colorScheme.secondary;

    switch (food) {
      case FoodInstructionEnum.beforeFood: icon = Icons.restaurant_menu_rounded; text = l10n.foodBefore; color = theme.colorScheme.primary; break;
      case FoodInstructionEnum.withFood: icon = Icons.restaurant_rounded; text = l10n.foodWith; break;
      case FoodInstructionEnum.afterFood: icon = Icons.local_dining_rounded; text = l10n.foodAfter; color = Colors.orange.shade700; break;
      default: return null;
    }

    return Container(
      margin: const EdgeInsets.only(top: 10), padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8), border: Border.all(color: color.withValues(alpha: 0.2))),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color), const SizedBox(width: 6),
          Text(text, style: theme.textTheme.bodySmall?.copyWith(color: color, fontWeight: FontWeight.w800)),
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

    // Берем дозу из ЛОГА
    final rawDosage = item.doseLog.dosage > 0 ? item.doseLog.dosage : (medicine?.dosage ?? 0);
    final dosage = rawDosage % 1 == 0 ? rawDosage.toInt().toString() : rawDosage.toString();
    final unit = medicine?.dosageUnit ?? '';

    final timeString = DateFormat.Hm(Localizations.localeOf(context).languageCode).format(item.doseLog.scheduledTime);

    final now = DateTime.now();
    final endOfToday = DateTime(now.year, now.month, now.day, 23, 59, 59);
    final isFutureDay = item.doseLog.scheduledTime.isAfter(endOfToday);

    Color statusColor;
    IconData statusIcon;

    switch (item.doseLog.status) {
      case DoseStatusEnum.taken: statusColor = theme.colorScheme.secondary; statusIcon = Icons.check_circle_rounded; break;
      case DoseStatusEnum.skipped: statusColor = theme.colorScheme.error; statusIcon = Icons.cancel_rounded; break;
      default: statusColor = isFutureDay ? theme.primaryColor.withValues(alpha: 0.4) : theme.primaryColor; statusIcon = Icons.schedule_rounded;
    }

    return GestureDetector(
      onTap: () {
        if (medicine != null) Navigator.of(context).push(MaterialPageRoute(builder: (context) => MedicineDetailScreen(medicine: medicine)));
      },
      child: GlassContainer(
        margin: const EdgeInsets.only(bottom: 12), // Сделали карточки плотнее друг к другу
        padding: const EdgeInsets.all(16),
        color: item.doseLog.status == DoseStatusEnum.taken
            ? theme.colorScheme.secondary.withValues(alpha: 0.04) // Очень легкое зеленое свечение
            : theme.colorScheme.surface.withValues(alpha: 0.45),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: statusColor.withValues(alpha: 0.1),
                        shape: BoxShape.circle
                    ),
                    child: Icon(statusIcon, color: statusColor, size: 24)
                ),
                const SizedBox(height: 8),
                Text(timeString, style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w800, color: statusColor, fontSize: 16)),
              ],
            ),
            Container(height: 60, width: 1, margin: const EdgeInsets.symmetric(horizontal: 16), color: theme.dividerColor.withValues(alpha: 0.1)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildMedicineImageOrIcon(medicine, theme),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(medicineName, style: theme.textTheme.titleLarge?.copyWith(fontSize: 18, fontWeight: FontWeight.w800, color: theme.colorScheme.onSurface), maxLines: 1, overflow: TextOverflow.ellipsis),
                            const SizedBox(height: 2),
                            Text('$dosage $unit', style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurface.withValues(alpha: 0.6), fontWeight: FontWeight.w600)),

                            // Бейджи инвентаря
                            if (medicine != null && medicine.pillsRemaining == 0) ...[
                              const SizedBox(height: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(color: theme.colorScheme.error.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(6), border: Border.all(color: theme.colorScheme.error.withValues(alpha: 0.3))),
                                child: Text(l10n.outOfStockBadge, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.error, fontWeight: FontWeight.w800, fontSize: 10)),
                              ),
                            ] else if (medicine != null && medicine.pillsRemaining <= medicine.refillAlertThreshold) ...[
                              const SizedBox(height: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(color: Colors.orange.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(6), border: Border.all(color: Colors.orange.withValues(alpha: 0.3))),
                                child: Text(l10n.lowStockBadge, style: theme.textTheme.bodySmall?.copyWith(color: Colors.orange, fontWeight: FontWeight.w800, fontSize: 10)),
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

            // Дерзкие, крупные кнопки действий в стиле Pure Swiss
            if (item.doseLog.status == DoseStatusEnum.pending && !isFutureDay) ...[
              const SizedBox(width: 8),
              Column(
                children: [
                  IconButton(
                    style: IconButton.styleFrom(
                        backgroundColor: theme.colorScheme.secondary.withValues(alpha: 0.15),
                        padding: const EdgeInsets.all(14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))
                    ),
                    icon: Icon(Icons.check_rounded, color: theme.colorScheme.secondary, size: 28),
                    onPressed: () => controller.updateDoseStatus(item.doseLog, DoseStatusEnum.taken),
                  ),
                  const SizedBox(height: 8),
                  IconButton(
                    style: IconButton.styleFrom(
                        backgroundColor: theme.colorScheme.error.withValues(alpha: 0.1),
                        padding: const EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
                    ),
                    icon: Icon(Icons.close_rounded, color: theme.colorScheme.error, size: 22),
                    onPressed: () => controller.updateDoseStatus(item.doseLog, DoseStatusEnum.skipped),
                  ),
                ],
              ),
            ] else if (item.doseLog.status != DoseStatusEnum.pending) ...[
              const SizedBox(width: 8),
              IconButton(
                style: IconButton.styleFrom(
                    backgroundColor: theme.dividerColor.withValues(alpha: 0.05),
                    padding: const EdgeInsets.all(14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))
                ),
                icon: Icon(Icons.undo_rounded, color: theme.colorScheme.onSurface.withValues(alpha: 0.5), size: 26),
                onPressed: () => controller.undoDoseStatus(item.doseLog),
              ),
            ]
          ],
        ),
      ),
    );
  }
}