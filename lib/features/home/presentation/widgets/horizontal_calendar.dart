import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../providers/home_provider.dart';

class HorizontalCalendar extends ConsumerStatefulWidget {
  const HorizontalCalendar({super.key});

  @override
  ConsumerState<HorizontalCalendar> createState() => _HorizontalCalendarState();
}

class _HorizontalCalendarState extends ConsumerState<HorizontalCalendar> {
  late ScrollController _scrollController;

  // 🚀 РАСШИРЕННОЕ ОКНО ВРЕМЕНИ: 10 дней назад, сегодня, 10 дней вперед
  final int _daysCount = 21;
  final double _itemWidth = 65.0; // Ширина карточки
  final double _itemMargin = 12.0; // Отступ между карточками

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    // 🚀 УМНОЕ ЦЕНТРИРОВАНИЕ: Скроллим к "Сегодня" при загрузке
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        final screenWidth = MediaQuery.of(context).size.width;
        final totalItemWidth = _itemWidth + _itemMargin;
        // Индекс "Сегодня" равен 10 (середина массива из 21)
        final offset = (10 * totalItemWidth) - (screenWidth / 2) + (_itemWidth / 2) + 16;

        _scrollController.jumpTo(offset);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedDate = ref.watch(selectedDateProvider);
    final theme = Theme.of(context);

    final today = DateTime.now();
    // Генерируем массив дат
    final dates = List.generate(_daysCount, (index) {
      final date = today.add(Duration(days: index - 10));
      return DateTime(date.year, date.month, date.day);
    });

    final pureToday = DateTime(today.year, today.month, today.day);

    return SizedBox(
      height: 95, // Чуть увеличили высоту для тени и индикатора
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: dates.length,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          final date = dates[index];
          final isSelected = date.isAtSameMomentAs(selectedDate);
          final isToday = date.isAtSameMomentAs(pureToday);

          final dayName = DateFormat.E(Localizations.localeOf(context).languageCode).format(date);
          final dayNumber = DateFormat.d().format(date);

          return GestureDetector(
            onTap: () {
              ref.read(selectedDateProvider.notifier).state = date;
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOutCubic, // Плавная, дорогая анимация
              margin: EdgeInsets.only(right: _itemMargin, bottom: 8, top: 4), // Воздух для тени
              width: _itemWidth,
              decoration: BoxDecoration(
                color: isSelected ? theme.primaryColor : theme.colorScheme.surface.withOpacity(0.4), // Стеклянный фон
                borderRadius: BorderRadius.circular(20), // BENTO стиль
                border: Border.all(
                  color: isSelected ? theme.primaryColor : theme.dividerColor.withOpacity(0.05),
                  width: 1.5,
                ),
                boxShadow: isSelected
                    ? [BoxShadow(color: theme.primaryColor.withOpacity(0.4), blurRadius: 12, offset: const Offset(0, 6))]
                    : [],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    dayName.toUpperCase(),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: isSelected ? Colors.white.withOpacity(0.9) : theme.colorScheme.onSurface.withOpacity(0.5),
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    dayNumber,
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: isSelected ? Colors.white : theme.colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),

                  // 🚀 НОВОЕ: Элегантный индикатор для "Сегодняшнего" дня
                  if (isToday) ...[
                    const SizedBox(height: 4),
                    Container(
                      width: 5,
                      height: 5,
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.white : theme.primaryColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ] else ...[
                    // Компенсируем высоту, чтобы цифры не "прыгали" у других дней
                    const SizedBox(height: 9),
                  ]
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}