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

  final int _daysCount = 21;
  final double _itemWidth = 65.0;
  final double _itemMargin = 12.0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        final screenWidth = MediaQuery.of(context).size.width;
        final totalItemWidth = _itemWidth + _itemMargin;
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
    final dates = List.generate(_daysCount, (index) {
      final date = today.add(Duration(days: index - 10));
      return DateTime(date.year, date.month, date.day);
    });

    final pureToday = DateTime(today.year, today.month, today.day);

    return SizedBox(
      height: 95,
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
              curve: Curves.easeOutCubic,
              margin: EdgeInsets.only(right: _itemMargin, bottom: 8, top: 4),
              width: _itemWidth,
              decoration: BoxDecoration(
                color: isSelected ? theme.primaryColor : theme.colorScheme.surface.withOpacity(0.6),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? theme.primaryColor : theme.dividerColor.withOpacity(0.05),
                  width: 1.5,
                ),
                // 🚀 НОВОЕ: Мощное неоновое свечение для выбранного дня
                boxShadow: isSelected
                    ? [BoxShadow(color: theme.primaryColor.withOpacity(0.5), blurRadius: 16, offset: const Offset(0, 6))]
                    : [],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    dayName.toUpperCase(),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: isSelected ? Colors.white.withOpacity(0.9) : theme.colorScheme.onSurface.withOpacity(0.5),
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    dayNumber,
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: isSelected ? Colors.white : theme.colorScheme.onSurface,
                      fontWeight: FontWeight.w900,
                      fontSize: 24, // 🚀 Сделали цифры чуть крупнее
                    ),
                  ),
                  if (isToday) ...[
                    const SizedBox(height: 4),
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.white : theme.primaryColor,
                        shape: BoxShape.circle,
                        boxShadow: isSelected ? [] : [BoxShadow(color: theme.primaryColor.withOpacity(0.5), blurRadius: 4)],
                      ),
                    ),
                  ] else ...[
                    const SizedBox(height: 10),
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