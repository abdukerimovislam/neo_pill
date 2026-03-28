import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:ui';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../../data/local/entities/dose_log_entity.dart';
import '../../data/local/entities/measurement_entity.dart';
import '../../data/local/entities/medicine_entity.dart';

enum ReminderDayPeriod { morning, afternoon, evening, night }

@pragma('vm:entry-point')
void notificationTapBackground(
  NotificationResponse notificationResponse,
) async {
  WidgetsFlutterBinding.ensureInitialized();

  final actionId = notificationResponse.actionId;
  final payload = notificationResponse.payload;

  if (actionId != null && payload != null) {
    await _processDoseAction(actionId, payload);
  }
}

enum NotificationPayloadKind { legacyMedicine, daily, log }

class NotificationPayload {
  final NotificationPayloadKind kind;
  final String? medicineSyncId;
  final String? logSyncId;
  final int? hour;
  final int? minute;

  const NotificationPayload._({
    required this.kind,
    this.medicineSyncId,
    this.logSyncId,
    this.hour,
    this.minute,
  });

  static String daily({
    required String medicineSyncId,
    required int hour,
    required int minute,
  }) => 'daily|$medicineSyncId|$hour|$minute';

  static String log(String logSyncId) => 'log|$logSyncId';

  static NotificationPayload parse(String raw) {
    final parts = raw.split('|');
    if (parts.length == 2 && parts.first == 'log') {
      return NotificationPayload._(
        kind: NotificationPayloadKind.log,
        logSyncId: parts[1],
      );
    }
    if (parts.length == 4 && parts.first == 'daily') {
      return NotificationPayload._(
        kind: NotificationPayloadKind.daily,
        medicineSyncId: parts[1],
        hour: int.tryParse(parts[2]),
        minute: int.tryParse(parts[3]),
      );
    }
    return NotificationPayload._(
      kind: NotificationPayloadKind.legacyMedicine,
      medicineSyncId: raw,
    );
  }
}

Future<void> _processDoseAction(String actionId, String rawPayload) async {
  try {
    Isar? isar = Isar.getInstance();
    if (isar == null) {
      final dir = await getApplicationDocumentsDirectory();
      isar = await Isar.open([
        MedicineEntitySchema,
        DoseLogEntitySchema,
        MeasurementEntitySchema,
      ], directory: dir.path);
    }

    final db = isar;
    final now = DateTime.now();
    final parsedPayload = NotificationPayload.parse(rawPayload);

    DoseLogEntity? logToUpdate;

    if (parsedPayload.kind == NotificationPayloadKind.log &&
        parsedPayload.logSyncId != null) {
      logToUpdate = await db.doseLogEntitys
          .filter()
          .syncIdEqualTo(parsedPayload.logSyncId!)
          .findFirst();
    } else if (parsedPayload.kind == NotificationPayloadKind.daily &&
        parsedPayload.medicineSyncId != null &&
        parsedPayload.hour != null &&
        parsedPayload.minute != null) {
      final startOfDay = DateTime(now.year, now.month, now.day);
      final endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59);
      final pendingLogs = await db.doseLogEntitys
          .filter()
          .medicineSyncIdEqualTo(parsedPayload.medicineSyncId!)
          .statusEqualTo(DoseStatusEnum.pending)
          .scheduledTimeBetween(startOfDay, endOfDay)
          .findAll();

      for (final log in pendingLogs) {
        if (log.scheduledTime.hour == parsedPayload.hour &&
            log.scheduledTime.minute == parsedPayload.minute) {
          logToUpdate = log;
          break;
        }
      }

      logToUpdate ??= pendingLogs.isEmpty ? null : pendingLogs.first;
    } else if (parsedPayload.medicineSyncId != null) {
      final startOfDay = DateTime(now.year, now.month, now.day);
      final endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59);
      logToUpdate = await db.doseLogEntitys
          .filter()
          .medicineSyncIdEqualTo(parsedPayload.medicineSyncId!)
          .statusEqualTo(DoseStatusEnum.pending)
          .scheduledTimeBetween(startOfDay, endOfDay)
          .sortByScheduledTime()
          .findFirst();
    }

    if (logToUpdate == null) return;

    final medicine = await db.medicineEntitys
        .filter()
        .syncIdEqualTo(logToUpdate.medicineSyncId)
        .findFirst();
    if (medicine == null) return;

    await db.writeTxn(() async {
      if (actionId == NotificationService.actionTake) {
        logToUpdate!.status = DoseStatusEnum.taken;
        logToUpdate.actualTime = now;

        if (medicine.pillsRemaining > 0) {
          final oldStock = medicine.pillsRemaining;
          final deduction = logToUpdate.dosage > 0
              ? logToUpdate.dosage.ceil()
              : (medicine.dosage > 0 ? medicine.dosage.ceil() : 1);
          medicine.pillsRemaining -= deduction;
          if (medicine.pillsRemaining < 0) {
            medicine.pillsRemaining = 0;
          }
          await db.medicineEntitys.put(medicine);

          if (oldStock > medicine.refillAlertThreshold &&
              medicine.pillsRemaining <= medicine.refillAlertThreshold) {
            await NotificationService().showImmediateNotification(
              id: medicine.id * 1000,
              title: NotificationService.buildLowStockTitle(medicine),
              body: NotificationService.buildLowStockBody(medicine),
            );
          }
        }
      } else if (actionId == NotificationService.actionSkip) {
        logToUpdate!.status = DoseStatusEnum.skipped;
      } else if (actionId == NotificationService.actionSnooze) {
        final snoozeTime = now.add(const Duration(minutes: 30));
        logToUpdate!.scheduledTime = snoozeTime;

        final stableNotificationId =
            (medicine.id * 100000) +
            snoozeTime.day * 1000 +
            snoozeTime.hour * 100 +
            snoozeTime.minute;
        await NotificationService().scheduleExactNotification(
          id: stableNotificationId,
          title: NotificationService.buildSmartReminderTitle(
            medicine: medicine,
            scheduledTime: snoozeTime,
            snoozed: true,
          ),
          body: NotificationService.buildSmartReminderBody(
            medicine: medicine,
            scheduledTime: snoozeTime,
            dosage: logToUpdate.dosage > 0
                ? logToUpdate.dosage
                : medicine.dosage,
          ),
          scheduledTime: snoozeTime,
          payload: NotificationPayload.log(logToUpdate.syncId),
        );
      }

      await db.doseLogEntitys.put(logToUpdate!);
    });

    debugPrint('Successfully processed action: $actionId for $rawPayload');
  } catch (e) {
    debugPrint('Background Error: $e');
  }
}

final notificationServiceProvider = Provider<NotificationService>((ref) {
  return NotificationService();
});

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static const String actionTake = 'action_take';
  static const String actionSkip = 'action_skip';
  static const String actionSnooze = 'action_snooze';
  static const String categoryMedication = 'category_medication';

  static ReminderDayPeriod periodForTime(DateTime scheduledTime) {
    final hour = scheduledTime.hour;
    if (hour >= 5 && hour < 12) return ReminderDayPeriod.morning;
    if (hour >= 12 && hour < 17) return ReminderDayPeriod.afternoon;
    if (hour >= 17 && hour < 22) return ReminderDayPeriod.evening;
    return ReminderDayPeriod.night;
  }

  static String _periodLabel(ReminderDayPeriod period) {
    return switch (period) {
      ReminderDayPeriod.morning => _isRussian ? 'Утренний' : 'Morning',
      ReminderDayPeriod.afternoon => _isRussian ? 'Дневной' : 'Afternoon',
      ReminderDayPeriod.evening => _isRussian ? 'Вечерний' : 'Evening',
      ReminderDayPeriod.night => _isRussian ? 'Ночной' : 'Night',
    };
  }

  static String _formatDosage(double dosage) {
    return dosage % 1 == 0 ? dosage.toInt().toString() : dosage.toString();
  }

  static bool get _isRussian =>
      PlatformDispatcher.instance.locale.languageCode.toLowerCase() == 'ru';

  static String _localizedUnit(String unit) {
    return switch (unit.toLowerCase()) {
      'mg' => _isRussian ? 'мг' : 'mg',
      'ml' => _isRussian ? 'мл' : 'ml',
      'drops' => _isRussian ? 'капель' : 'drops',
      'pcs' => _isRussian ? 'шт' : 'pcs',
      'g' => _isRussian ? 'г' : 'g',
      'mcg' => _isRussian ? 'мкг' : 'mcg',
      'iu' => _isRussian ? 'МЕ' : 'IU',
      _ => unit,
    };
  }

  static String _foodCue(
    FoodInstructionEnum instruction,
    ReminderDayPeriod period,
  ) {
    return switch (instruction) {
      FoodInstructionEnum.beforeFood =>
        _isRussian ? 'Принимайте до еды.' : 'Take before food.',
      FoodInstructionEnum.withFood =>
        _isRussian ? 'Принимайте во время еды.' : 'Take with food.',
      FoodInstructionEnum.afterFood => switch (period) {
        ReminderDayPeriod.morning =>
          _isRussian ? 'Лучше после завтрака.' : 'Best after breakfast.',
        ReminderDayPeriod.afternoon =>
          _isRussian ? 'Лучше после обеда.' : 'Best after lunch.',
        ReminderDayPeriod.evening =>
          _isRussian ? 'Лучше после ужина.' : 'Best after dinner.',
        ReminderDayPeriod.night =>
          _isRussian
              ? 'Примите после вечернего приема пищи.'
              : 'Take after your evening meal.',
      },
      FoodInstructionEnum.noMatter => switch (period) {
        ReminderDayPeriod.morning =>
          _isRussian
              ? 'Хорошее время, чтобы закрепить утренний режим.'
              : 'A good time to anchor your morning routine.',
        ReminderDayPeriod.afternoon =>
          _isRussian
              ? 'Короткая проверка помогает не сбиться в течение дня.'
              : 'A quick check-in keeps your day on track.',
        ReminderDayPeriod.evening =>
          _isRussian
              ? 'Спокойный вечерний режим помогает сохранять регулярность.'
              : 'A calm evening routine helps you stay consistent.',
        ReminderDayPeriod.night =>
          _isRussian
              ? 'Примите, когда будете готовиться ко сну.'
              : 'Take it when you are settling down for the night.',
      },
    };
  }

  static String buildSmartReminderTitle({
    required MedicineEntity medicine,
    required DateTime scheduledTime,
    bool snoozed = false,
  }) {
    final period = _periodLabel(periodForTime(scheduledTime));
    final typeLead = medicine.kind == CourseKindEnum.supplement
        ? (_isRussian ? 'wellness' : 'wellness')
        : (_isRussian ? 'курс' : 'care');
    if (snoozed) {
      return _isRussian
          ? '$period напоминание: ${medicine.name}'
          : '$period $typeLead reminder: ${medicine.name}';
    }
    return _isRussian
        ? '$period прием: ${medicine.name}'
        : '$period $typeLead: ${medicine.name}';
  }

  static String buildSmartReminderBody({
    required MedicineEntity medicine,
    required DateTime scheduledTime,
    required double dosage,
  }) {
    final amount =
        '${_formatDosage(dosage)} ${_localizedUnit(medicine.dosageUnit)}'
            .trim();
    final cue = _foodCue(
      medicine.foodInstruction,
      periodForTime(scheduledTime),
    );
    final lead = medicine.kind == CourseKindEnum.supplement
        ? (_isRussian
              ? 'Мягкое напоминание для вашего режима.'
              : 'A gentle check-in for your routine.')
        : (_isRussian
              ? 'Спокойное напоминание по вашему курсу.'
              : 'A calm reminder for your treatment plan.');
    return '$lead $amount. $cue';
  }

  static String buildLowStockTitle(MedicineEntity medicine) {
    return _isRussian
        ? '⚠️ Заканчивается: ${medicine.name}'
        : '⚠️ Low Stock: ${medicine.name}';
  }

  static String buildLowStockBody(MedicineEntity medicine) {
    final unit = _localizedUnit(medicine.dosageUnit);
    return _isRussian
        ? 'Осталось только ${medicine.pillsRemaining} $unit. Пора пополнить запас.'
        : 'Only ${medicine.pillsRemaining} $unit left. Time to refill!';
  }

  Future<void> init() async {
    tz.initializeTimeZones();

    final String timeZoneName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));

    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    final iosCategories = [
      DarwinNotificationCategory(
        categoryMedication,
        actions: [
          DarwinNotificationAction.plain(
            actionTake,
            _isRussian ? 'Принять' : 'Take',
          ),
          DarwinNotificationAction.plain(
            actionSnooze,
            _isRussian ? 'Отложить 30м' : 'Snooze 30m',
          ),
          DarwinNotificationAction.plain(
            actionSkip,
            _isRussian ? 'Пропустить' : 'Skip',
            options: <DarwinNotificationActionOption>{
              DarwinNotificationActionOption.destructive,
            },
          ),
        ],
        options: <DarwinNotificationCategoryOption>{
          DarwinNotificationCategoryOption.hiddenPreviewShowTitle,
        },
      ),
    ];

    final iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      notificationCategories: iosCategories,
    );

    final initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _handleNotificationAction,
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );
  }

  void _handleNotificationAction(NotificationResponse response) async {
    final actionId = response.actionId;
    final payload = response.payload;

    if (actionId != null &&
        payload != null &&
        (actionId == actionTake ||
            actionId == actionSkip ||
            actionId == actionSnooze)) {
      await _processDoseAction(actionId, payload);
    } else {
      debugPrint('User simply tapped notification body: $payload');
    }
  }

  Future<void> requestPermissions() async {
    await _notificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();

    await _notificationsPlugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >()
        ?.requestPermissions(alert: true, badge: true, sound: true);
  }

  AndroidNotificationDetails _buildAndroidDetails(String channelId) {
    return AndroidNotificationDetails(
      channelId,
      'Medication Reminders',
      channelDescription: 'Reminders to take your medicines',
      importance: Importance.max,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
      enableVibration: true,
      actions: [
        const AndroidNotificationAction(
          actionTake,
          'Take',
          showsUserInterface: false,
        ),
        const AndroidNotificationAction(
          actionSnooze,
          'Snooze 30m',
          showsUserInterface: false,
        ),
        const AndroidNotificationAction(
          actionSkip,
          'Skip',
          showsUserInterface: false,
          titleColor: Color.fromARGB(255, 255, 0, 0),
        ),
      ],
    );
  }

  DarwinNotificationDetails _buildIOSDetails() {
    return const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      interruptionLevel: InterruptionLevel.critical,
      categoryIdentifier: categoryMedication,
    );
  }

  AndroidNotificationDetails _buildBasicAndroidDetails(String channelId) {
    return AndroidNotificationDetails(
      channelId,
      'System Alerts',
      channelDescription: 'Important system alerts like low stock',
      importance: Importance.max,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
      enableVibration: true,
      color: const Color(0xFFE53935),
    );
  }

  Future<void> showImmediateNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {
    await _notificationsPlugin.show(
      id,
      title,
      body,
      NotificationDetails(
        android: _buildBasicAndroidDetails('system_alerts_channel'),
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
          interruptionLevel: InterruptionLevel.active,
        ),
      ),
      payload: payload,
    );
  }

  Future<void> scheduleExactNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledTime,
    String? payload,
  }) async {
    if (scheduledTime.isBefore(DateTime.now())) return;

    await _notificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledTime, tz.local),
      NotificationDetails(
        android: _buildAndroidDetails('medication_exact_channel'),
        iOS: _buildIOSDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: payload,
    );
  }

  Future<void> scheduleDailyRepeatingNotification({
    required int id,
    required String title,
    required String body,
    required TimeOfDay time,
    String? payload,
  }) async {
    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    await _notificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduledDate,
      NotificationDetails(
        android: _buildAndroidDetails('medication_daily_channel'),
        iOS: _buildIOSDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: payload,
    );
  }

  Future<void> cancelAll() async {
    await _notificationsPlugin.cancelAll();
  }

  Future<void> cancelNotification(int id) async {
    await _notificationsPlugin.cancel(id);
  }
}
