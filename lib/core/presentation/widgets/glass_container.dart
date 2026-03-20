import 'dart:ui';
import 'package:flutter/material.dart';

class GlassContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double borderRadius;
  final Color? color;
  final VoidCallback? onTap;

  const GlassContainer({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.borderRadius = 24.0, // 🚀 Сделали углы более круглыми и современными
    this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Премиальный акрил: чуть больше непрозрачности и очень сильное размытие
    final defaultColor = isDark
        ? Colors.white.withOpacity(0.06)
        : Colors.white.withOpacity(0.4);

    final borderColor = isDark
        ? Colors.white.withOpacity(0.15) // Резкая белая граница в темноте
        : Colors.white.withOpacity(0.8); // Плотная белая граница на свету

    final container = Container(
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          // Глубокая, мягкая тень для отрыва от фона
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.3 : 0.05),
            blurRadius: 24,
            offset: const Offset(0, 8),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0), // 🚀 Сильный блюр (Apple style)
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              color: color ?? defaultColor,
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(color: borderColor, width: 1.5), // 🚀 Выделяем границы
            ),
            child: child,
          ),
        ),
      ),
    );

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: container,
      );
    }

    return container;
  }
}