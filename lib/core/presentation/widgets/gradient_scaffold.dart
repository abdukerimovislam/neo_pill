import 'dart:ui';
import 'package:flutter/material.dart';

class GradientScaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final bool extendBodyBehindAppBar;
  final Widget? bottomNavigationBar;
  final bool useSafeArea;
  final EdgeInsetsGeometry? padding;

  const GradientScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.extendBodyBehindAppBar = false,
    this.bottomNavigationBar,
    this.useSafeArea = true,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final primaryGlow = theme.colorScheme.primary.withValues(
      alpha: isDark ? 0.18 : 0.10,
    );
    final secondaryGlow = theme.colorScheme.secondary.withValues(
      alpha: isDark ? 0.12 : 0.06,
    );

    Widget content = Padding(
      padding: padding ?? EdgeInsets.zero,
      child: body,
    );

    if (useSafeArea) {
      content = SafeArea(
        top: !extendBodyBehindAppBar,
        bottom: false,
        child: content,
      );
    }

    return Scaffold(
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: appBar,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      bottomNavigationBar: bottomNavigationBar,
      body: Stack(
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    theme.scaffoldBackgroundColor,
                    theme.scaffoldBackgroundColor,
                    theme.colorScheme.surface.withValues(
                      alpha: isDark ? 0.92 : 0.96,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: -120,
            left: -90,
            child: _GlowOrb(
              size: 280,
              color: primaryGlow,
              blur: 140,
            ),
          ),
          Positioned(
            bottom: -100,
            right: -70,
            child: _GlowOrb(
              size: 240,
              color: secondaryGlow,
              blur: 130,
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
              child: const SizedBox.expand(),
            ),
          ),
          content,
        ],
      ),
    );
  }
}

class _GlowOrb extends StatelessWidget {
  final double size;
  final double blur;
  final Color color;

  const _GlowOrb({
    required this.size,
    required this.blur,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        boxShadow: [
          BoxShadow(
            color: color,
            blurRadius: blur,
            spreadRadius: blur / 3,
          ),
        ],
      ),
    );
  }
}