import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/presentation/widgets/glass_container.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../settings/provider/settings_provider.dart';
import '../../providers/home_provider.dart';

class HorizontalCalendar extends ConsumerStatefulWidget {
  const HorizontalCalendar({super.key});

  @override
  ConsumerState<HorizontalCalendar> createState() => _HorizontalCalendarState();
}

class _HorizontalCalendarState extends ConsumerState<HorizontalCalendar> {
  static const int _daysCount = 31;
  static const int _centerIndex = 15;

  late final FixedExtentScrollController _wheelController;
  int _focusedIndex = _centerIndex;
  int? _lastSyncedIndex;
  bool _hasTriggeredWheelHaptic = false;

  @override
  void initState() {
    super.initState();
    _wheelController = FixedExtentScrollController(initialItem: _centerIndex);
    _lastSyncedIndex = _centerIndex;
  }

  @override
  void dispose() {
    _wheelController.dispose();
    super.dispose();
  }

  DateTime _dateForIndex(int index) {
    final now = DateTime.now();
    final pureToday = DateTime(now.year, now.month, now.day);
    return pureToday.add(Duration(days: index - _centerIndex));
  }

  int _indexForDate(DateTime date) {
    final now = DateTime.now();
    final pureToday = DateTime(now.year, now.month, now.day);
    final normalized = DateTime(date.year, date.month, date.day);
    final diff = normalized.difference(pureToday).inDays;
    return (_centerIndex + diff).clamp(0, _daysCount - 1);
  }

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  void _commitFocusedDate(DateTime selectedDate) {
    final focusedDate = _dateForIndex(_focusedIndex);
    if (!_isSameDay(focusedDate, selectedDate)) {
      ref.read(selectedDateProvider.notifier).state = focusedDate;
    }
    _hasTriggeredWheelHaptic = false;
  }

  @override
  Widget build(BuildContext context) {
    final selectedDate = ref.watch(selectedDateProvider);
    final comfortMode = ref.watch(comfortModeProvider);
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context);

    final targetIndex = _indexForDate(selectedDate);
    if (_lastSyncedIndex != targetIndex) {
      _lastSyncedIndex = targetIndex;
      _focusedIndex = targetIndex;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_wheelController.hasClients) {
          _wheelController.animateToItem(
            targetIndex,
            duration: const Duration(milliseconds: 260),
            curve: Curves.easeOutCubic,
          );
        }
      });
    }

    final displayedDate = _dateForIndex(_focusedIndex);
    final today = _dateForIndex(_centerIndex);
    final displayedIsToday = _isSameDay(displayedDate, today);
    final weekdayTitle = displayedIsToday
        ? l10n.calendarToday
        : DateFormat.EEEE(locale.languageCode).format(displayedDate);
    final fullDate = DateFormat.yMMMMd(
      locale.languageCode,
    ).format(displayedDate);
    final shortMonth = DateFormat.MMMM(
      locale.languageCode,
    ).format(displayedDate);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        height: comfortMode ? 236 : 216,
        child: GlassContainer(
          padding: EdgeInsets.zero,
          borderRadius: 30,
          color: theme.colorScheme.surface.withValues(alpha: 0.84),
          child: Row(
            children: [
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final compact = constraints.maxHeight < 188;
                    return Padding(
                      padding: EdgeInsets.fromLTRB(
                        20,
                        compact ? 18 : (comfortMode ? 24 : 22),
                        18,
                        compact ? 18 : (comfortMode ? 24 : 22),
                      ),
                      child: SingleChildScrollView(
                        physics: const ClampingScrollPhysics(),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n.calendarSelectedDay,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurface.withValues(
                                  alpha: 0.52,
                                ),
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.2,
                              ),
                            ),
                            SizedBox(height: compact ? 2 : 8),
                            Text(
                              _capitalize(weekdayTitle),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style:
                                  (compact
                                          ? theme.textTheme.titleLarge
                                          : theme.textTheme.headlineSmall)
                                      ?.copyWith(
                                        fontWeight: FontWeight.w900,
                                        color: theme.colorScheme.onSurface,
                                        height: 1.05,
                                      ),
                            ),
                            SizedBox(height: compact ? 4 : 6),
                            Text(
                              fullDate,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style:
                                  (compact
                                          ? theme.textTheme.titleSmall
                                          : theme.textTheme.titleMedium)
                                      ?.copyWith(
                                        color: theme.primaryColor,
                                        fontWeight: FontWeight.w800,
                                      ),
                            ),
                            SizedBox(height: compact ? 8 : 14),
                            _StatusPill(
                              compact: compact,
                              icon: displayedIsToday
                                  ? Icons.bolt_rounded
                                  : Icons.autorenew_rounded,
                              text: displayedIsToday
                                  ? l10n.calendarShowingToday
                                  : l10n.calendarBrowseNearbyDays,
                            ),
                            if (!compact) ...[
                              const SizedBox(height: 10),
                              Text(
                                l10n.calendarPreviewAnotherDay,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: theme.colorScheme.onSurface.withValues(
                                    alpha: 0.6,
                                  ),
                                  height: 1.35,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                _capitalize(shortMonth),
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.onSurface.withValues(
                                    alpha: 0.46,
                                  ),
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.3,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                width: 1,
                margin: const EdgeInsets.symmetric(vertical: 24),
                color: theme.dividerColor.withValues(alpha: 0.14),
              ),
              SizedBox(
                width: comfortMode ? 132 : 118,
                child: ClipRRect(
                  borderRadius: const BorderRadius.horizontal(
                    right: Radius.circular(30),
                  ),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.centerRight,
                              end: Alignment.centerLeft,
                              colors: [
                                theme.primaryColor.withValues(alpha: 0.18),
                                theme.primaryColor.withValues(alpha: 0.09),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 18,
                        bottom: 18,
                        left: 12,
                        right: 10,
                        child: IgnorePointer(
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(999),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.22),
                              ),
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.white.withValues(alpha: 0.16),
                                  Colors.white.withValues(alpha: 0.04),
                                  Colors.white.withValues(alpha: 0.16),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: comfortMode ? 88 : 82,
                        right: 10,
                        left: 22,
                        height: comfortMode ? 64 : 58,
                        child: IgnorePointer(
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              color: Colors.white.withValues(alpha: 0.14),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.26),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: theme.primaryColor.withValues(
                                    alpha: 0.18,
                                  ),
                                  blurRadius: 18,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: -36,
                        top: 0,
                        bottom: 0,
                        width: comfortMode ? 168 : 154,
                        child: NotificationListener<ScrollEndNotification>(
                          onNotification: (_) {
                            _commitFocusedDate(selectedDate);
                            return false;
                          },
                          child: ShaderMask(
                            shaderCallback: (bounds) {
                              return const LinearGradient(
                                begin: Alignment.centerRight,
                                end: Alignment.centerLeft,
                                colors: [
                                  Colors.transparent,
                                  Colors.black,
                                  Colors.black,
                                ],
                                stops: [0.0, 0.28, 1.0],
                              ).createShader(bounds);
                            },
                            blendMode: BlendMode.dstIn,
                            child: Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.diagonal3Values(
                                -1.0,
                                1.0,
                                1.0,
                              ),
                              child: ListWheelScrollView.useDelegate(
                                controller: _wheelController,
                                itemExtent: comfortMode ? 60 : 54,
                                physics: const FixedExtentScrollPhysics(),
                                perspective: 0.0028,
                                diameterRatio: 1.22,
                                offAxisFraction: 1.28,
                                squeeze: 0.9,
                                useMagnifier: true,
                                magnification: 1.16,
                                onSelectedItemChanged: (index) {
                                  if (_focusedIndex != index) {
                                    if (_hasTriggeredWheelHaptic) {
                                      HapticFeedback.selectionClick();
                                    } else {
                                      _hasTriggeredWheelHaptic = true;
                                    }
                                    setState(() {
                                      _focusedIndex = index;
                                    });
                                  }
                                },
                                childDelegate: ListWheelChildBuilderDelegate(
                                  childCount: _daysCount,
                                  builder: (context, index) {
                                    final date = _dateForIndex(index);
                                    return Transform(
                                      alignment: Alignment.center,
                                      transform: Matrix4.diagonal3Values(
                                        -1.0,
                                        1.0,
                                        1.0,
                                      ),
                                      child: _WheelDayItem(
                                        date: date,
                                        isSelected: index == _focusedIndex,
                                        isToday: _isSameDay(date, today),
                                        comfortMode: comfortMode,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 18,
                        right: 18,
                        child: _WheelSideBadge(
                          label: l10n.calendarDayWheelSemantics,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _capitalize(String value) {
    if (value.isEmpty) return value;
    return value[0].toUpperCase() + value.substring(1);
  }
}

class _WheelDayItem extends StatelessWidget {
  final DateTime date;
  final bool isSelected;
  final bool isToday;
  final bool comfortMode;

  const _WheelDayItem({
    required this.date,
    required this.isSelected,
    required this.isToday,
    required this.comfortMode,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).languageCode;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOutCubic,
      width: isSelected ? (comfortMode ? 94 : 86) : (comfortMode ? 84 : 76),
      padding: EdgeInsets.symmetric(
        horizontal: isSelected ? 13 : 11,
        vertical: isSelected ? 9 : 8,
      ),
      decoration: BoxDecoration(
        color: isSelected
            ? theme.primaryColor
            : theme.colorScheme.surface.withValues(alpha: 0.36),
        borderRadius: BorderRadius.circular(isSelected ? 22 : 20),
        border: Border.all(
          color: isSelected
              ? Colors.white.withValues(alpha: 0.18)
              : theme.colorScheme.onSurface.withValues(alpha: 0.06),
        ),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: theme.primaryColor.withValues(alpha: 0.26),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ]
            : null,
      ),
      child: AnimatedScale(
        scale: isSelected ? 1.06 : 0.94,
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                DateFormat.E(locale).format(date).toUpperCase(),
                style: theme.textTheme.labelSmall?.copyWith(
                  color: isSelected
                      ? Colors.white.withValues(alpha: 0.92)
                      : theme.colorScheme.onSurface.withValues(alpha: 0.48),
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.35,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                DateFormat.d().format(date),
                style: theme.textTheme.titleLarge?.copyWith(
                  color: isSelected
                      ? Colors.white
                      : theme.colorScheme.onSurface,
                  fontWeight: FontWeight.w900,
                  fontSize: isSelected
                      ? (comfortMode ? 24 : 22)
                      : (comfortMode ? 21 : 19),
                ),
              ),
              const SizedBox(height: 3),
              AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                width: isSelected ? 7 : 6,
                height: isSelected ? 7 : 6,
                decoration: BoxDecoration(
                  color: isToday
                      ? (isSelected ? Colors.white : theme.primaryColor)
                      : Colors.transparent,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WheelSideBadge extends StatelessWidget {
  final String label;

  const _WheelSideBadge({required this.label});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(999),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.55),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: Colors.white.withValues(alpha: 0.35)),
          ),
          child: Text(
            label,
            style: theme.textTheme.labelMedium?.copyWith(
              color: theme.primaryColor,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool compact;

  const _StatusPill({
    required this.icon,
    required this.text,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 10 : 12,
        vertical: compact ? 8 : 10,
      ),
      decoration: BoxDecoration(
        color: theme.primaryColor.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, size: compact ? 16 : 18, color: theme.primaryColor),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              maxLines: compact ? 1 : 2,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.74),
                fontWeight: FontWeight.w700,
                height: 1.32,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
