import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../settings/provider/settings_provider.dart';
import '../../providers/home_provider.dart';

class HorizontalCalendar extends ConsumerStatefulWidget {
  const HorizontalCalendar({super.key});

  @override
  ConsumerState<HorizontalCalendar> createState() => _HorizontalCalendarState();
}

class _HorizontalCalendarState extends ConsumerState<HorizontalCalendar> {
  late final PageController _pageController;

  // 61 день: 15 назад, сегодня, 45 вперед
  static const int _daysCount = 61;
  static const int _todayIndex = 15;

  bool _isUserScrolling = false;

  DateTime get _pureToday {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  DateTime _dateForIndex(int index) {
    return _pureToday.add(Duration(days: index - _todayIndex));
  }

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  @override
  void initState() {
    super.initState();

    final initialDate = ref.read(selectedDateProvider);
    final initialDiff = initialDate.difference(_pureToday).inDays;

    _pageController = PageController(
      viewportFraction: 0.19,
      initialPage: (_todayIndex + initialDiff).clamp(0, _daysCount - 1),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedDate = ref.watch(selectedDateProvider);
    final comfortMode = ref.watch(comfortModeProvider);
    final locale = Localizations.localeOf(context).languageCode;
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final isTodaySelected = _isSameDay(selectedDate, _pureToday);

    ref.listen<DateTime>(selectedDateProvider, (previous, next) {
      if (!_isUserScrolling && previous != null && !_isSameDay(previous, next)) {
        final targetDiff = next.difference(_pureToday).inDays;
        final targetPage = (_todayIndex + targetDiff).clamp(0, _daysCount - 1);

        if (_pageController.hasClients) {
          final currentPage = _pageController.page?.round();
          if (currentPage != targetPage) {
            _pageController.animateToPage(
              targetPage,
              duration: const Duration(milliseconds: 320),
              curve: Curves.easeOutCubic,
            );
          }
        }
      }
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 0),
          child: Row(
            children: [
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 220),
                  transitionBuilder: (child, animation) =>
                      FadeTransition(opacity: animation, child: child),
                  child: Column(
                    key: ValueKey('${selectedDate.year}-${selectedDate.month}'),
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat.yMMMM(locale).format(selectedDate),
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: theme.colorScheme.onSurface,
                          height: 1.1,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        DateFormat.yMMMMEEEEd(locale).format(selectedDate),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurface.withValues(alpha: 0.58),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              AnimatedOpacity(
                opacity: isTodaySelected ? 0.0 : 1.0,
                duration: const Duration(milliseconds: 180),
                child: IgnorePointer(
                  ignoring: isTodaySelected,
                  child: GestureDetector(
                    onTap: () {
                      HapticFeedback.mediumImpact();
                      ref.read(selectedDateProvider.notifier).state = _pureToday;
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withValues(alpha: 0.10),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: theme.colorScheme.primary.withValues(alpha: 0.18),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.my_location_rounded,
                            size: 14,
                            color: theme.colorScheme.primary,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            l10n.calendarToday,
                            style: theme.textTheme.labelMedium?.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        SizedBox(
          height: comfortMode ? 96 : 86,
          child: NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification is ScrollStartNotification) {
                _isUserScrolling = true;
              } else if (notification is ScrollEndNotification) {
                _isUserScrolling = false;
              }
              return false;
            },
            child: PageView.builder(
              controller: _pageController,
              physics: const BouncingScrollPhysics(),
              itemCount: _daysCount,
              padEnds: true,
              onPageChanged: (index) {
                HapticFeedback.selectionClick();
                ref.read(selectedDateProvider.notifier).state = _dateForIndex(index);
              },
              itemBuilder: (context, index) {
                return AnimatedBuilder(
                  animation: _pageController,
                  builder: (context, child) {
                    double page;
                    if (_pageController.hasClients &&
                        _pageController.position.hasContentDimensions) {
                      page = _pageController.page ?? _pageController.initialPage.toDouble();
                    } else {
                      page = _pageController.initialPage.toDouble();
                    }

                    final distance = (page - index).abs();
                    final isSelected = distance < 0.5;

                    final scale = (1 - (distance * 0.10)).clamp(0.92, 1.0);
                    final opacity = (1 - (distance * 0.18)).clamp(0.72, 1.0);
                    final translateY = distance * 6;

                    return Center(
                      child: Transform.translate(
                        offset: Offset(0, translateY),
                        child: Transform.scale(
                          scale: scale,
                          child: Opacity(
                            opacity: opacity,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4),
                              child: _CompactCalendarItem(
                                date: _dateForIndex(index),
                                locale: locale,
                                theme: theme,
                                comfortMode: comfortMode,
                                isSelected: isSelected,
                                onTap: () {
                                  if (!isSelected) {
                                    _pageController.animateToPage(
                                      index,
                                      duration: const Duration(milliseconds: 260),
                                      curve: Curves.easeOutCubic,
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _CompactCalendarItem extends StatelessWidget {
  final DateTime date;
  final String locale;
  final ThemeData theme;
  final bool comfortMode;
  final bool isSelected;
  final VoidCallback onTap;

  const _CompactCalendarItem({
    required this.date,
    required this.locale,
    required this.theme,
    required this.comfortMode,
    required this.isSelected,
    required this.onTap,
  });

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final isToday = _isSameDay(date, today);

    final weekday = DateFormat.E(locale).format(date);
    final dayNumber = DateFormat.d(locale).format(date);

    final selectedBg = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        theme.colorScheme.primary.withValues(alpha: 0.95),
        theme.colorScheme.primary,
      ],
    );

    final unselectedBg = BoxDecoration(
      color: theme.colorScheme.surface.withValues(alpha: 0.72),
      borderRadius: BorderRadius.circular(22),
      border: Border.all(
        color: isToday
            ? theme.colorScheme.primary.withValues(alpha: 0.34)
            : theme.colorScheme.outline.withValues(alpha: 0.10),
      ),
    );

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        width: comfortMode ? 68 : 62,
        height: comfortMode ? 88 : 78,
        decoration: isSelected
            ? BoxDecoration(
          gradient: selectedBg,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.primary.withValues(alpha: 0.24),
              blurRadius: 18,
              spreadRadius: 0,
              offset: const Offset(0, 8),
            ),
          ],
        )
            : unselectedBg,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              weekday.substring(0, weekday.length >= 2 ? 2 : weekday.length).toUpperCase(),
              style: theme.textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.w800,
                color: isSelected
                    ? Colors.white.withValues(alpha: 0.90)
                    : theme.colorScheme.onSurface.withValues(alpha: 0.58),
                letterSpacing: 0.4,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              dayNumber,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w900,
                fontSize: comfortMode
                    ? (isSelected ? 24 : 21)
                    : (isSelected ? 22 : 19),
                color: isSelected
                    ? Colors.white
                    : theme.colorScheme.onSurface,
                height: 1.0,
              ),
            ),
            const SizedBox(height: 6),
            AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              width: isSelected ? 18 : 6,
              height: 6,
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.white.withValues(alpha: 0.95)
                    : isToday
                    ? theme.colorScheme.primary
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          ],
        ),
      ),
    );
  }
}