import 'package:flutter/material.dart';
import 'package:neo_pill/data/local/entities/dose_log_entity.dart';
import 'package:neo_pill/data/local/entities/medicine_entity.dart';

extension NeoPillThemeColors on ThemeData {
  Color get brandPrimary => colorScheme.primary;
  Color get infoAccent => colorScheme.primary;

  // 🔥 Теперь берем наш свежий мятный цвет прямо из ядра темы (colorScheme.secondary)
  // Это гарантирует 100% консистентность по всему приложению
  Color get supplementAccent => colorScheme.secondary;

  Color get successAccent => const Color(0xFF2C7A7B);
  Color get warningAccent => colorScheme.tertiary;
  Color get dangerAccent => colorScheme.error;
  Color get neutralStrong => colorScheme.onSurface;
  Color get neutralMuted => brightness == Brightness.dark
      ? const Color(0xFFB6C2D2)
      : const Color(0xFF718096);
  Color get calmSurface => colorScheme.surface;
  Color get calmBorder => dividerColor;

  Color courseAccent(CourseKindEnum kind) {
    return kind == CourseKindEnum.supplement ? supplementAccent : brandPrimary;
  }

  Color doseStatusAccent(DoseStatusEnum status, {required bool isFutureDose}) {
    switch (status) {
      case DoseStatusEnum.taken:
        return successAccent;
      case DoseStatusEnum.skipped:
        return dangerAccent;
      case DoseStatusEnum.snoozed:
        return warningAccent;
      case DoseStatusEnum.pending:
        return isFutureDose
            ? brandPrimary.withValues(alpha: 0.42)
            : brandPrimary;
    }
  }

  Color inventoryAccent({
    required bool isOutOfStock,
    required bool isLowStock,
    required CourseKindEnum kind,
  }) {
    if (isOutOfStock) return dangerAccent;
    if (isLowStock) return warningAccent;
    return courseAccent(kind);
  }
}