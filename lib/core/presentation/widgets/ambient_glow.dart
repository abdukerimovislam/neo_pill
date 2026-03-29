import 'package:flutter/material.dart';

class AmbientGlow extends StatelessWidget {
  const AmbientGlow({
    super.key,
    required this.color,
    this.size = 180,
    this.opacity = 0.16,
  });

  final Color color;
  final double size;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              color.withValues(alpha: opacity * 0.85),
              color.withValues(alpha: 0),
            ],
          ),
        ),
      ),
    );
  }
}
