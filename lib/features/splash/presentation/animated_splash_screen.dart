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
  late Animation<double> _slideAnimation; // Анимация всплытия
  late Animation<double> _spacingAnimation; // Анимация сборки букв

  @override
  void initState() {
    super.initState();

    // Увеличили длительность до 2.5 секунд для более глубокого эффекта
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );

    // 1. Появление (Fade) - быстрое начало
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.4, curve: Curves.easeIn),
      ),
    );

    // 2. Увеличение (Scale) - плавное, на протяжении всей анимации
    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 1.0, curve: Curves.linearToEaseOut),
      ),
    );

    // 3. Всплытие (Slide) - текст немного поднимается
    _slideAnimation = Tween<double>(begin: 30.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.8, curve: Curves.easeOutCubic),
      ),
    );

    // 4. Сборка букв (Letter Spacing) - от широкого к узкому
    _spacingAnimation = Tween<double>(begin: 20.0, end: 4.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 1.0, curve: Curves.linearToEaseOut),
      ),
    );

    _controller.forward();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    // Ждем окончания анимации (3.5 секунды)
    await Future.delayed(const Duration(milliseconds: 3500));

    if (!mounted) return;

    final nextScreen = widget.isOnboardingComplete
        ? const MainNavigationScreen()
        : const OnboardingScreen();

    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 800),
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
                // Добавили вертикальный сдвиг
                child: Transform.translate(
                  offset: Offset(0, _slideAnimation.value),
                  child: Text(
                    'Pillora',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF1E3A8A),
                      // Анимируем межбуквенное расстояние
                      letterSpacing: _spacingAnimation.value,
                      shadows: const [
                        Shadow(
                          color: Color(0x111E3A8A),
                          blurRadius: 15,
                          offset: Offset(0, 8),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}