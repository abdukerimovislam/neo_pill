import 'package:flutter/material.dart';

class AppMotion {
  static const Duration pageTransitionDuration = Duration(milliseconds: 420);
  static const Duration pageTransitionReverseDuration = Duration(
    milliseconds: 320,
  );
  static const Duration tabSwitchDuration = Duration(milliseconds: 380);
  static const Curve emphasizedCurve = Curves.easeOutCubic;
  static const Curve entranceCurve = Curves.easeOutQuart;

  static PageTransitionsTheme get pageTransitionsTheme =>
      const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: _PremiumPageTransitionsBuilder(),
          TargetPlatform.iOS: _PremiumPageTransitionsBuilder(),
          TargetPlatform.macOS: _PremiumPageTransitionsBuilder(),
          TargetPlatform.windows: _PremiumPageTransitionsBuilder(),
          TargetPlatform.linux: _PremiumPageTransitionsBuilder(),
        },
      );
}

class _PremiumPageTransitionsBuilder extends PageTransitionsBuilder {
  const _PremiumPageTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    if (route.fullscreenDialog) {
      return child;
    }

    final curved = CurvedAnimation(
      parent: animation,
      curve: AppMotion.entranceCurve,
      reverseCurve: Curves.easeOutCubic,
    );

    return FadeTransition(
      opacity: Tween<double>(begin: 0, end: 1).animate(curved),
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0.035, 0.02),
          end: Offset.zero,
        ).animate(curved),
        child: ScaleTransition(
          scale: Tween<double>(begin: 0.985, end: 1).animate(curved),
          child: child,
        ),
      ),
    );
  }
}
