import 'dart:async';

import 'package:flutter/material.dart';

import '../../theme/app_motion.dart';

class AnimatedReveal extends StatefulWidget {
  const AnimatedReveal({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 520),
    this.offset = const Offset(0, 0.035),
    this.scaleBegin = 0.985,
  });

  final Widget child;
  final Duration delay;
  final Duration duration;
  final Offset offset;
  final double scaleBegin;

  @override
  State<AnimatedReveal> createState() => _AnimatedRevealState();
}

class _AnimatedRevealState extends State<AnimatedReveal> {
  Timer? _timer;
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    _timer = Timer(widget.delay, () {
      if (mounted) {
        setState(() => _isVisible = true);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reduceMotion =
        MediaQuery.maybeOf(context)?.disableAnimations ?? false;
    if (reduceMotion) {
      return widget.child;
    }

    return AnimatedOpacity(
      duration: widget.duration,
      curve: AppMotion.entranceCurve,
      opacity: _isVisible ? 1 : 0,
      child: AnimatedSlide(
        duration: widget.duration,
        curve: AppMotion.entranceCurve,
        offset: _isVisible ? Offset.zero : widget.offset,
        child: AnimatedScale(
          duration: widget.duration,
          curve: AppMotion.entranceCurve,
          scale: _isVisible ? 1 : widget.scaleBegin,
          child: widget.child,
        ),
      ),
    );
  }
}
