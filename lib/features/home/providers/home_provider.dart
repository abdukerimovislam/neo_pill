import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:intl/intl.dart'; // 🚀 Добавлен импорт для форматирования даты

import '../../../core/firebase/caregiver_cloud_repository.dart'; // 🚀 Добавлен импорт
import '../../../data/local/entities/dose_log_entity.dart';
import '../../../data/local/entities/medicine_entity.dart';
import '../../../data/local/isar_service.dart';
import '../../settings/provider/care_context_provider.dart'; // 🚀 Добавлен импорт
import '../../settings/provider/caregiver_cloud_provider.dart'; // 🚀 Добавлен импорт
import '../../settings/provider/settings_provider.dart';

enum CourseFilterType { all, medications, supplements }

bool get _isRussianLocale =>
    PlatformDispatcher.instance.locale.languageCode.toLowerCase() == 'ru';

final selectedDateProvider = StateProvider<DateTime>((ref) {
  final now = DateTime.now();
  return DateTime(now.year, now.month, now.day);
});

final selectedHomeCourseFilterProvider = StateProvider<CourseFilterType>(
      (ref) => CourseFilterType.all,
);

// 🚀 НОВОЕ: Выбранный пациент для просмотра (для опекуна)
final selectedCaregiverPatientProvider = StateProvider<LinkedPatient?>((ref) {
  final cloudState = ref.watch(caregiverCloudProvider);
  return cloudState.linkedPatients.isNotEmpty ? cloudState.linkedPatients.first : null;
});

// 🚀 НОВОЕ: Стрим расписания подопечного из Firebase
final remotePatientScheduleProvider = StreamProvider.autoDispose<List<CaregiverSharedDose>>((ref) {
  final selectedContext = ref.watch(selectedCareContextProvider);
  final selectedPatient = ref.watch(selectedCaregiverPatientProvider);

  if (selectedContext == AppCareContext.myCare || selectedPatient == null) {
    return Stream.value([]);
  }

  // Пока смотрим только на "сегодняшнее" расписание пациента
  final dateString = DateFormat('yyyy-MM-dd').format(DateTime.now());
  return ref.read(caregiverCloudRepositoryProvider).watchTodaySchedule(
    shareCode: selectedPatient.shareCode,
    dateString: dateString,
  );
});

class DoseScheduleItem {
  final DoseLogEntity doseLog;
  final MedicineEntity? medicine;

  DoseScheduleItem({required this.doseLog, required this.medicine});
}

class HomeRoutineBundle {
  final String id;
  final String label;
  final String subtitle;
  final List<DoseScheduleItem> items;

  const HomeRoutineBundle({
    required this.id,
    required this.label,
    required this.subtitle,
    required this.items,
  });
}

class HomeDashboardSummary {
  final int totalDoses;
  final int takenDoses;
  final int skippedDoses;
  final int pendingDoses;
  final int overdueDoses;
  final int activeMedicines;
  final int lowStockMedicines;
  final double todayProgress;
  final double weeklyAdherence;
  final int currentStreak;
  final DoseScheduleItem? nextPendingDose;
  final List<String> insightMessages;

  const HomeDashboardSummary({
    required this.totalDoses,
    required this.takenDoses,
    required this.skippedDoses,
    required this.pendingDoses,
    required this.overdueDoses,
    required this.activeMedicines,
    required this.lowStockMedicines,
    required this.todayProgress,
    required this.weeklyAdherence,
    required this.currentStreak,
    required this.nextPendingDose,
    required this.insightMessages,
  });
}

enum CaregiverAlertReason { overdue, skipped }

class CaregiverAlertItem {
  final DoseScheduleItem item;
  final CaregiverAlertReason reason;
  final int delayMinutes;

  const CaregiverAlertItem({
    required this.item,
    required this.reason,
    required this.delayMinutes,
  });
}

class CaregiverAlertSummary {
  final CaregiverProfile caregiver;
  final CaregiverAlertSettings settings;
  final List<CaregiverAlertItem> items;

  const CaregiverAlertSummary({
    required this.caregiver,
    required this.settings,
    required this.items,
  });

  int get overdueCount =>
      items.where((item) => item.reason == CaregiverAlertReason.overdue).length;

  int get skippedCount =>
      items.where((item) => item.reason == CaregiverAlertReason.skipped).length;

  int get totalCount => items.length;
}

final dailyScheduleProvider =
FutureProvider.autoDispose<List<DoseScheduleItem>>((ref) async {
  final isarService = ref.read(localDbProvider);
  final isar = await isarService.db;
  final selectedDate = ref.watch(selectedDateProvider);

  final logs = await isarService.getLogsForDate(selectedDate);
  return _mapDoseScheduleItems(isar: isar, logs: logs);
});

final filteredDailyScheduleProvider =
FutureProvider.autoDispose<List<DoseScheduleItem>>((ref) async {
  final items = await ref.watch(dailyScheduleProvider.future);
  final filter = ref.watch(selectedHomeCourseFilterProvider);
  return _filterItemsByCourseType(items, filter);
});

final homeRoutineBundlesProvider =
FutureProvider.autoDispose<List<HomeRoutineBundle>>((ref) async {
  final items = await ref.watch(filteredDailyScheduleProvider.future);
  return buildRoutineBundles(items);
});

final homeDashboardProvider = FutureProvider.autoDispose<HomeDashboardSummary>((
    ref,
    ) async {
  final isarService = ref.read(localDbProvider);
  final isar = await isarService.db;
  final selectedDate = ref.watch(selectedDateProvider);
  final selectedFilter = ref.watch(selectedHomeCourseFilterProvider);
  final items = await ref.watch(filteredDailyScheduleProvider.future);

  final now = DateTime.now();
  final selectedDay = DateTime(
    selectedDate.year,
    selectedDate.month,
    selectedDate.day,
  );
  final todayDay = DateTime(now.year, now.month, now.day);
  final isTodaySelected = selectedDay.isAtSameMomentAs(todayDay);

  final totalDoses = items.length;
  final takenDoses = items
      .where((item) => item.doseLog.status == DoseStatusEnum.taken)
      .length;
  final skippedDoses = items
      .where((item) => item.doseLog.status == DoseStatusEnum.skipped)
      .length;
  final pendingDoses = items
      .where((item) => item.doseLog.status == DoseStatusEnum.pending)
      .length;
  final overdueDoses = isTodaySelected
      ? items.where((item) {
    return item.doseLog.status == DoseStatusEnum.pending &&
        item.doseLog.scheduledTime.isBefore(now);
  }).length
      : 0;

  final todayProgress = totalDoses > 0 ? takenDoses / totalDoses : 0.0;

  final allMedicines = await isar.medicineEntitys.where().findAll();
  final filteredCourses = allMedicines.where((medicine) {
    return switch (selectedFilter) {
      CourseFilterType.all => true,
      CourseFilterType.medications =>
      medicine.kind == CourseKindEnum.medication,
      CourseFilterType.supplements =>
      medicine.kind == CourseKindEnum.supplement,
    };
  }).toList();
  final activeMedicines = filteredCourses
      .where((medicine) => !medicine.isPaused)
      .length;
  final lowStockMedicines = filteredCourses
      .where(
        (medicine) => medicine.pillsRemaining <= medicine.refillAlertThreshold,
  )
      .length;

  final startOfToday = DateTime(now.year, now.month, now.day);
  final nextPendingDose = isTodaySelected
      ? items
      .where((item) => item.doseLog.status == DoseStatusEnum.pending)
      .where((item) => item.doseLog.scheduledTime.isAfter(now))
      .cast<DoseScheduleItem?>()
      .fold<DoseScheduleItem?>(null, (previous, item) {
    if (item == null) return previous;
    if (previous == null) return item;
    return item.doseLog.scheduledTime.isBefore(
      previous.doseLog.scheduledTime,
    )
        ? item
        : previous;
  })
      : null;

  final weeklyLogs = await isar.doseLogEntitys
      .filter()
      .scheduledTimeBetween(startOfToday.subtract(const Duration(days: 6)), now)
      .findAll();
  final finishedWeeklyLogs = weeklyLogs
      .where((log) => log.status != DoseStatusEnum.pending)
      .toList();
  final weeklyTaken = finishedWeeklyLogs
      .where((log) => log.status == DoseStatusEnum.taken)
      .length;
  final weeklyAdherence = finishedWeeklyLogs.isEmpty
      ? 0.0
      : (weeklyTaken / finishedWeeklyLogs.length) * 100;

  final currentStreak = await _calculateCurrentStreak(isar, now);

  final insightMessages = <String>[
    if (overdueDoses > 0)
      _isRussianLocale
          ? overdueDoses == 1
          ? '1 \u0437\u0430\u043f\u043b\u0430\u043d\u0438\u0440\u043e\u0432\u0430\u043d\u043d\u044b\u0439 \u043f\u0443\u043d\u043a\u0442 \u0442\u0440\u0435\u0431\u0443\u0435\u0442 \u0432\u043d\u0438\u043c\u0430\u043d\u0438\u044f \u043f\u0440\u044f\u043c\u043e \u0441\u0435\u0439\u0447\u0430\u0441.'
          : '$overdueDoses \u0437\u0430\u043f\u043b\u0430\u043d\u0438\u0440\u043e\u0432\u0430\u043d\u043d\u044b\u0445 \u043f\u0443\u043d\u043a\u0442\u043e\u0432 \u0442\u0440\u0435\u0431\u0443\u044e\u0442 \u0432\u043d\u0438\u043c\u0430\u043d\u0438\u044f \u043f\u0440\u044f\u043c\u043e \u0441\u0435\u0439\u0447\u0430\u0441.'
          : '$overdueDoses scheduled item${overdueDoses == 1 ? '' : 's'} need attention right now.',
    if (weeklyAdherence >= 85)
      _isRussianLocale
          ? '\u041d\u0430 \u044d\u0442\u043e\u0439 \u043d\u0435\u0434\u0435\u043b\u0435 \u043e\u0442\u043b\u0438\u0447\u043d\u0430\u044f \u0440\u0435\u0433\u0443\u043b\u044f\u0440\u043d\u043e\u0441\u0442\u044c. \u0412\u0430\u0448 \u0440\u0435\u0436\u0438\u043c \u0434\u0435\u0440\u0436\u0438\u0442\u0441\u044f \u0445\u043e\u0440\u043e\u0448\u043e.'
          : 'Excellent consistency this week. Your routine is holding up.',
    if (weeklyAdherence > 0 && weeklyAdherence < 85)
      _isRussianLocale
          ? '\u0420\u0435\u0436\u0438\u043c \u0435\u0449\u0435 \u043c\u043e\u0436\u043d\u043e \u0441\u0434\u0435\u043b\u0430\u0442\u044c \u0442\u043e\u0447\u043d\u0435\u0435. \u0421\u0444\u043e\u043a\u0443\u0441\u0438\u0440\u0443\u0439\u0442\u0435\u0441\u044c \u043d\u0430 \u0441\u043b\u0435\u0434\u0443\u044e\u0449\u0435\u043c \u043f\u0440\u0438\u0435\u043c\u0435.'
          : 'There is room to tighten the routine. Focus on the next due dose.',
    if (lowStockMedicines > 0)
      _isRussianLocale
          ? lowStockMedicines == 1
          ? '1 \u043a\u0443\u0440\u0441 \u0431\u043b\u0438\u0437\u043e\u043a \u043a \u0443\u0440\u043e\u0432\u043d\u044e \u043f\u043e\u043f\u043e\u043b\u043d\u0435\u043d\u0438\u044f.'
          : '$lowStockMedicines \u043a\u0443\u0440\u0441\u043e\u0432 \u0431\u043b\u0438\u0437\u043a\u0438 \u043a \u0443\u0440\u043e\u0432\u043d\u044e \u043f\u043e\u043f\u043e\u043b\u043d\u0435\u043d\u0438\u044f.'
          : '$lowStockMedicines course${lowStockMedicines == 1 ? '' : 's'} are close to refill level.',
    if (totalDoses == 0)
      _isRussianLocale
          ? '\u041d\u0430 \u044d\u0442\u0443 \u0434\u0430\u0442\u0443 \u043b\u0435\u043a\u0430\u0440\u0441\u0442\u0432\u0430 \u0438 \u0411\u0410\u0414\u044b \u043d\u0435 \u0437\u0430\u043f\u043b\u0430\u043d\u0438\u0440\u043e\u0432\u0430\u043d\u044b.'
          : 'No medications or supplements are scheduled for this date.',
  ];

  return HomeDashboardSummary(
    totalDoses: totalDoses,
    takenDoses: takenDoses,
    skippedDoses: skippedDoses,
    pendingDoses: pendingDoses,
    overdueDoses: overdueDoses,
    activeMedicines: activeMedicines,
    lowStockMedicines: lowStockMedicines,
    todayProgress: todayProgress,
    weeklyAdherence: weeklyAdherence,
    currentStreak: currentStreak,
    nextPendingDose: nextPendingDose,
    insightMessages: insightMessages.take(3).toList(),
  );
});

final heroDoseProvider = FutureProvider.autoDispose<DoseScheduleItem?>((
    ref,
    ) async {
  final selectedDate = ref.watch(selectedDateProvider);
  final now = DateTime.now();
  final pureSelected = DateTime(
    selectedDate.year,
    selectedDate.month,
    selectedDate.day,
  );
  final pureToday = DateTime(now.year, now.month, now.day);

  if (!pureSelected.isAtSameMomentAs(pureToday)) return null;

  final items = await ref.watch(filteredDailyScheduleProvider.future);
  final windowEnd = now.add(const Duration(minutes: 30));

  final candidates =
  items
      .where((item) => item.doseLog.status == DoseStatusEnum.pending)
      .where((item) => !item.doseLog.scheduledTime.isBefore(pureToday))
      .where((item) => item.doseLog.scheduledTime.isBefore(windowEnd))
      .toList()
    ..sort(
          (a, b) => a.doseLog.scheduledTime.compareTo(b.doseLog.scheduledTime),
    );

  return candidates.isEmpty ? null : candidates.first;
});

final caregiverAlertSummaryProvider =
FutureProvider.autoDispose<CaregiverAlertSummary?>((ref) async {
  final items = await ref.watch(dailyScheduleProvider.future);
  final caregiver = ref.watch(caregiverProfileProvider);
  final settings = ref.watch(caregiverAlertSettingsProvider);
  final selectedDate = ref.watch(selectedDateProvider);

  return buildCaregiverAlertSummary(
    items: items,
    caregiver: caregiver,
    settings: settings,
    selectedDate: selectedDate,
  );
});

List<DoseScheduleItem> _filterItemsByCourseType(
    List<DoseScheduleItem> items,
    CourseFilterType filter,
    ) {
  return switch (filter) {
    CourseFilterType.all => items,
    CourseFilterType.medications =>
        items
            .where(
              (item) =>
          (item.medicine?.kind ?? CourseKindEnum.medication) ==
              CourseKindEnum.medication,
        )
            .toList(),
    CourseFilterType.supplements =>
        items
            .where((item) => item.medicine?.kind == CourseKindEnum.supplement)
            .toList(),
  };
}

List<HomeRoutineBundle> buildRoutineBundles(List<DoseScheduleItem> items) {
  if (items.isEmpty) return const [];

  final sorted = [
    ...items,
  ]..sort((a, b) => a.doseLog.scheduledTime.compareTo(b.doseLog.scheduledTime));
  final groups = <List<DoseScheduleItem>>[];
  List<DoseScheduleItem> currentGroup = [];

  for (final item in sorted) {
    if (currentGroup.isEmpty) {
      currentGroup.add(item);
      continue;
    }

    final previous = currentGroup.last.doseLog.scheduledTime;
    final current = item.doseLog.scheduledTime;
    final difference = current.difference(previous).inMinutes.abs();
    if (difference <= 90) {
      currentGroup.add(item);
    } else {
      groups.add(currentGroup);
      currentGroup = [item];
    }
  }

  if (currentGroup.isNotEmpty) {
    groups.add(currentGroup);
  }

  return groups.map((group) {
    final start = group.first.doseLog.scheduledTime;
    final end = group.last.doseLog.scheduledTime;
    final label = _bundleLabelForTime(start);
    final itemCount = group.length;
    final bundleType =
    group.every((item) => item.medicine?.kind == CourseKindEnum.supplement)
        ? (_isRussianLocale ? 'БАДы' : 'supplements')
        : group.every(
          (item) =>
      (item.medicine?.kind ?? CourseKindEnum.medication) ==
          CourseKindEnum.medication,
    )
        ? (_isRussianLocale ? 'лекарства' : 'medications')
        : (_isRussianLocale ? 'смешанный режим' : 'mixed');
    final subtitle = _isRussianLocale
        ? '$itemCount ${_russianItemWord(itemCount)} • ${_formatBundleTime(start)}-${_formatBundleTime(end)} • $bundleType'
        : '$itemCount ${itemCount == 1 ? 'item' : 'items'} • ${_formatBundleTime(start)}-${_formatBundleTime(end)} • $bundleType';

    return HomeRoutineBundle(
      id: '${start.toIso8601String()}_${group.length}',
      label: label,
      subtitle: subtitle,
      items: group,
    );
  }).toList();
}

CaregiverAlertSummary? buildCaregiverAlertSummary({
  required List<DoseScheduleItem> items,
  required CaregiverProfile? caregiver,
  required CaregiverAlertSettings settings,
  required DateTime selectedDate,
  DateTime? now,
}) {
  final currentTime = now ?? DateTime.now();
  final selectedDay = DateTime(
    selectedDate.year,
    selectedDate.month,
    selectedDate.day,
  );
  final today = DateTime(currentTime.year, currentTime.month, currentTime.day);

  if (caregiver == null ||
      caregiver.name.trim().isEmpty ||
      !settings.enabled ||
      selectedDay != today) {
    return null;
  }

  final alertItems = <CaregiverAlertItem>[];

  for (final item in items) {
    final isSupplement = item.medicine?.kind == CourseKindEnum.supplement;
    if (isSupplement && !settings.includeSupplements) {
      continue;
    }

    if (settings.includeSkipped &&
        item.doseLog.status == DoseStatusEnum.skipped) {
      alertItems.add(
        CaregiverAlertItem(
          item: item,
          reason: CaregiverAlertReason.skipped,
          delayMinutes: 0,
        ),
      );
      continue;
    }

    if (!settings.includeOverdue ||
        item.doseLog.status != DoseStatusEnum.pending ||
        !item.doseLog.scheduledTime.isBefore(currentTime)) {
      continue;
    }

    final delayMinutes = currentTime
        .difference(item.doseLog.scheduledTime)
        .inMinutes;
    if (delayMinutes < settings.graceMinutes) {
      continue;
    }

    alertItems.add(
      CaregiverAlertItem(
        item: item,
        reason: CaregiverAlertReason.overdue,
        delayMinutes: delayMinutes,
      ),
    );
  }

  if (alertItems.isEmpty) {
    return null;
  }

  alertItems.sort(
        (a, b) =>
        a.item.doseLog.scheduledTime.compareTo(b.item.doseLog.scheduledTime),
  );

  return CaregiverAlertSummary(
    caregiver: caregiver,
    settings: settings,
    items: alertItems,
  );
}

String _bundleLabelForTime(DateTime time) {
  final hour = time.hour;
  if (hour >= 5 && hour < 12) {
    return _isRussianLocale
        ? 'Утренний режим'
        : 'Morning routine';
  }
  if (hour >= 12 && hour < 17) {
    return _isRussianLocale
        ? 'Дневной режим'
        : 'Afternoon routine';
  }
  if (hour >= 17 && hour < 22) {
    return _isRussianLocale
        ? 'Вечерний режим'
        : 'Evening routine';
  }
  return _isRussianLocale
      ? 'Ночной режим'
      : 'Night routine';
}

String _russianItemWord(int count) {
  final mod10 = count % 10;
  final mod100 = count % 100;
  if (mod10 == 1 && mod100 != 11) return 'пункт';
  if (mod10 >= 2 && mod10 <= 4 && (mod100 < 12 || mod100 > 14)) {
    return 'пункта';
  }
  return 'пунктов';
}

String _formatBundleTime(DateTime time) {
  final hour = time.hour.toString().padLeft(2, '0');
  final minute = time.minute.toString().padLeft(2, '0');
  return '$hour:$minute';
}

Future<List<DoseScheduleItem>> _mapDoseScheduleItems({
  required Isar isar,
  required List<DoseLogEntity> logs,
}) async {
  final medicineIds = logs.map((log) => log.medicineSyncId).toSet().toList();
  final medicines = medicineIds.isEmpty
      ? <MedicineEntity>[]
      : await isar.medicineEntitys
      .filter()
      .anyOf(medicineIds, (q, String id) => q.syncIdEqualTo(id))
      .findAll();

  final medicineMap = {
    for (final medicine in medicines) medicine.syncId: medicine,
  };

  return logs
      .map(
        (log) => DoseScheduleItem(
      doseLog: log,
      medicine: medicineMap[log.medicineSyncId],
    ),
  )
      .toList();
}

Future<int> _calculateCurrentStreak(Isar isar, DateTime now) async {
  int streak = 0;

  for (int dayOffset = 0; dayOffset < 60; dayOffset++) {
    final date = DateTime(
      now.year,
      now.month,
      now.day,
    ).subtract(Duration(days: dayOffset));
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59);

    final logs = await isar.doseLogEntitys
        .filter()
        .scheduledTimeBetween(startOfDay, endOfDay)
        .findAll();

    if (logs.isEmpty) {
      continue;
    }

    final finishedLogs = logs
        .where((log) => log.status != DoseStatusEnum.pending)
        .toList();
    if (finishedLogs.isEmpty) {
      if (dayOffset == 0) {
        continue;
      }
      break;
    }

    final allTaken = finishedLogs.every(
          (log) => log.status == DoseStatusEnum.taken,
    );
    if (!allTaken) {
      break;
    }

    streak++;
  }

  return streak;
}