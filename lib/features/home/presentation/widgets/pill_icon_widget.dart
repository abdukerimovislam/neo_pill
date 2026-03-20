import 'package:flutter/material.dart';
import '../../../../data/local/entities/medicine_entity.dart';

class PillIconWidget extends StatelessWidget {
  final PillShapeEnum shape;
  final int colorHex;
  final double size;

  const PillIconWidget({
    super.key,
    required this.shape,
    required this.colorHex,
    this.size = 40.0,
  });

  @override
  Widget build(BuildContext context) {
    final color = Color(colorHex);

    switch (shape) {
      case PillShapeEnum.circle:
        return Container(width: size, height: size, decoration: BoxDecoration(color: color, shape: BoxShape.circle));
      case PillShapeEnum.capsule:
        return Container(
          width: size * 1.5, height: size * 0.6,
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(size)),
        );
      case PillShapeEnum.oval:
        return Container(
          width: size * 1.2, height: size * 0.8,
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.all(Radius.elliptical(size * 1.2, size * 0.8))),
        );
      case PillShapeEnum.square:
        return Container(
          width: size * 0.9, height: size * 0.9,
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(size * 0.2)),
        );
      case PillShapeEnum.diamond:
        return Transform.rotate(
          angle: 0.785398, // Поворот на 45 градусов
          child: Container(
            width: size * 0.75, height: size * 0.75,
            decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(size * 0.15)),
          ),
        );
    }
  }
}