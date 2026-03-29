import 'package:flutter/material.dart';

import '../../theme/app_motion.dart';

class MotionPressable extends StatefulWidget {
  const MotionPressable({
    super.key,
    required this.child,
    this.onTap,
    this.borderRadius,
    this.pressedScale = 0.985,
  });

  final Widget child;
  final VoidCallback? onTap;
  final BorderRadius? borderRadius;
  final double pressedScale;

  @override
  State<MotionPressable> createState() => _MotionPressableState();
}

class _MotionPressableState extends State<MotionPressable> {
  bool _pressed = false;

  void _setPressed(bool value) {
    if (_pressed == value) return;
    setState(() => _pressed = value);
  }

  @override
  Widget build(BuildContext context) {
    final reduceMotion =
        MediaQuery.maybeOf(context)?.disableAnimations ?? false;

    final child = AnimatedScale(
      duration: reduceMotion
          ? Duration.zero
          : const Duration(milliseconds: 180),
      curve: AppMotion.emphasizedCurve,
      scale: _pressed ? widget.pressedScale : 1,
      child: AnimatedSlide(
        duration: reduceMotion
            ? Duration.zero
            : const Duration(milliseconds: 180),
        curve: AppMotion.emphasizedCurve,
        offset: _pressed ? const Offset(0, 0.004) : Offset.zero,
        child: widget.child,
      ),
    );

    if (widget.onTap == null) {
      return child;
    }

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: widget.onTap,
      onTapDown: (_) => _setPressed(true),
      onTapUp: (_) => _setPressed(false),
      onTapCancel: () => _setPressed(false),
      child: ClipRRect(
        borderRadius: widget.borderRadius ?? BorderRadius.zero,
        child: child,
      ),
    );
  }
}
