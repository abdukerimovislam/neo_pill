import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/presentation/main_navigation_screen.dart';
import '../../onboarding/presentation/onboarding_screen.dart';

class AnimatedSplashScreen extends ConsumerStatefulWidget {
  final bool isOnboardingComplete;

  const AnimatedSplashScreen({
    super.key,
    required this.isOnboardingComplete,
  });

  @override
  ConsumerState<AnimatedSplashScreen> createState() => _AnimatedSplashScreenState();
}

class _AnimatedSplashScreenState extends ConsumerState<AnimatedSplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _slideAnimation; // Анимация всплытия текста
  late Animation<double> _spacingAnimation; // Анимация сборки букв
  late Animation<double> _capsuleDistanceAnimation; // Анимация смыкания капсулы

  @override
  void initState() {
    super.initState();

    // 🚀 Сделали анимацию медленнее и благороднее (3.5 секунды)
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3500),
    );

    // 1. Появление (Fade) - плавное начало
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.4, curve: Curves.easeIn),
      ),
    );

    // 2. Увеличение (Scale) - очень плавный зум на всем протяжении
    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 1.0, curve: Curves.easeOutCubic),
      ),
    );

    // 3. Всплытие (Slide) - текст медленно поднимается
    _slideAnimation = Tween<double>(begin: 30.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.8, curve: Curves.easeOutCubic),
      ),
    );

    // 4. Сборка букв (Letter Spacing)
    _spacingAnimation = Tween<double>(begin: 20.0, end: 4.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.9, curve: Curves.easeOutCubic),
      ),
    );

    // 5. 🚀 Смыкание капсулы: Стартуют дальше (120) и плавно соединяются.
    // easeOutBack дает эффект мягкого "щелчка" в замок без лишнего дрожания
    _capsuleDistanceAnimation = Tween<double>(begin: 120.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 0.9, curve: Curves.easeOutBack),
      ),
    );

    _controller.forward();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    // Ждем 4.5 секунды, чтобы дать анимации полностью завершиться и немного повисеть на экране
    await Future.delayed(const Duration(milliseconds: 4500));

    if (!mounted) return;

    final nextScreen = widget.isOnboardingComplete
        ? const MainNavigationScreen()
        : const OnboardingScreen();

    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 1000), // Более плавный переход на следующий экран
        pageBuilder: (context, animation, secondaryAnimation) => nextScreen,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // 🚀 ОБНОВЛЕННЫЙ ВИДЖЕТ: Половинки стали длиннее
  Widget _buildCapsuleHalf({required bool isLeft, required Color color, required double offset}) {
    return Transform.translate(
      offset: Offset(isLeft ? -offset : offset, 0),
      child: Container(
        width: 64, // 🚀 Сделали капсулу длиннее (было 44)
        height: 44, // Высота осталась прежней
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.horizontal(
            left: isLeft ? const Radius.circular(100) : Radius.zero,
            right: !isLeft ? const Radius.circular(100) : Radius.zero,
          ),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.25),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Opacity(
              opacity: _fadeAnimation.value,
              child: Transform.scale(
                scale: _scaleAnimation.value,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // ТЕКСТ PILLORA
                    Transform.translate(
                      offset: Offset(0, _slideAnimation.value),
                      child: Text(
                        'Pillora',
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.w900,
                          color: const Color(0xFF1E3A8A), // Основной синий
                          letterSpacing: _spacingAnimation.value,
                          shadows: const [
                            Shadow(
                              color: Color(0x151E3A8A),
                              blurRadius: 20,
                              offset: Offset(0, 10),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // 🚀 КАПСУЛА
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildCapsuleHalf(
                          isLeft: true,
                          color: const Color(0xFF1E3A8A), // Левая часть (темно-синяя)
                          offset: _capsuleDistanceAnimation.value,
                        ),
                        _buildCapsuleHalf(
                          isLeft: false,
                          color: const Color(0xFF0EA5E9), // Правая часть (светло-голубая)
                          offset: _capsuleDistanceAnimation.value,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}