import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:isar/isar.dart';
import 'package:flutter_timezone/flutter_timezone.dart';

import '../../data/local/entities/dose_log_entity.dart';
import '../../data/local/entities/medicine_entity.dart';

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) async {
  WidgetsFlutterBinding.ensureInitialized();

  final actionId = notificationResponse.actionId;
  final payload = notificationResponse.payload;

  if (actionId != null && payload != null) {
    await _processDoseAction(actionId, payload);
  }
}

Future<void> _processDoseAction(String actionId, String medicineSyncId) async {
  try {
    Isar? isar = Isar.getInstance();
    if (isar == null) {
      final dir = await getApplicationDocumentsDirectory();
      isar = await Isar.open(
        [MedicineEntitySchema, DoseLogEntitySchema],
        directory: dir.path,
      );
    }

    final Isar db = isar!;
    final now = DateTime.now();

    final medicine = await db.medicineEntitys.filter().syncIdEqualTo(medicineSyncId).findFirst();
    if (medicine == null) return;

    final startOfDay = DateTime(now.year, now.month, now.day);
    final endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59);

    final pendingLogs = await db.doseLogEntitys.filter()
        .medicineSyncIdEqualTo(medicineSyncId)
        .statusEqualTo(DoseStatusEnum.pending)
        .scheduledTimeBetween(startOfDay, endOfDay)
        .sortByScheduledTime()
        .findAll();

    if (pendingLogs.isEmpty) return;

    final logToUpdate = pendingLogs.first;

    await db.writeTxn(() async {
      if (actionId == NotificationService.actionTake) {
        logToUpdate.status = DoseStatusEnum.taken;
        logToUpdate.actualTime = now;

        if (medicine.pillsRemaining > 0) {
          final oldStock = medicine.pillsRemaining;
          medicine.pillsRemaining -= 1;
          await db.medicineEntitys.put(medicine);

          if (oldStock > medicine.refillAlertThreshold &&
              medicine.pillsRemaining <= medicine.refillAlertThreshold) {
            await NotificationService().showImmediateNotification(
              id: medicine.id * 1000,
              title: '⚠️ Low Stock: ${medicine.name}',
              body: 'Only ${medicine.pillsRemaining} ${medicine.dosageUnit} left. Time to refill!',
            );
          }
        }
      } else if (actionId == NotificationService.actionSkip) {
        logToUpdate.status = DoseStatusEnum.skipped;

      } else if (actionId == NotificationService.actionSnooze) {
        // 🚀 НОВОЕ: Логика функции Отложить (Snooze)
        final snoozeTime = now.add(const Duration(minutes: 30));
        logToUpdate.scheduledTime = snoozeTime; // Сдвигаем время в базе

        // Планируем новый пуш на 30 минут вперед
        final stableNotificationId = (medicine.id * 100000) + snoozeTime.day * 1000 + snoozeTime.hour * 100 + snoozeTime.minute;
        await NotificationService().scheduleExactNotification(
          id: stableNotificationId,
          title: medicine.notificationTitle ?? 'Snoozed: ${medicine.name}',
          body: medicine.notificationBody ?? 'Time to take your medicine',
          scheduledTime: snoozeTime,
          payload: medicine.syncId,
        );
      }

      await db.doseLogEntitys.put(logToUpdate);
    });

    debugPrint('Successfully processed action: $actionId for $medicineSyncId');
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

  final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();

  static const String actionTake = 'action_take';
  static const String actionSkip = 'action_skip';
  static const String actionSnooze = 'action_snooze'; // 🚀 НОВАЯ КНОПКА
  static const String categoryMedication = 'category_medication';

  Future<void> init() async {
    tz.initializeTimeZones();

    final String timeZoneName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));

    const AndroidInitializationSettings androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');

    final List<DarwinNotificationCategory> iosCategories = [
      DarwinNotificationCategory(
        categoryMedication,
        actions: [
          DarwinNotificationAction.plain(actionTake, 'Take'),
          // 🚀 ДОБАВЛЯЕМ SNOOZE ДЛЯ iOS
          DarwinNotificationAction.plain(actionSnooze, 'Snooze 30m'),
          DarwinNotificationAction.plain(
            actionSkip,
            'Skip',
            options: <DarwinNotificationActionOption>{
              DarwinNotificationActionOption.destructive,
            },
          ),
        ],
        options: <DarwinNotificationCategoryOption>{
          DarwinNotificationCategoryOption.hiddenPreviewShowTitle,
        },
      )
    ];

    final DarwinInitializationSettings iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      notificationCategories: iosCategories,
    );

    final InitializationSettings initSettings = InitializationSettings(
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

    if (actionId != null && payload != null &&
        (actionId == actionTake || actionId == actionSkip || actionId == actionSnooze)) {
      await _processDoseAction(actionId, payload);
    } else {
      debugPrint('User simply tapped notification body: $payload');
    }
  }

  Future<void> requestPermissions() async {
    await _notificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    await _notificationsPlugin
        .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
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
        const AndroidNotificationAction(actionTake, 'Take', showsUserInterface: false),
        // 🚀 ДОБАВЛЯЕМ SNOOZE ДЛЯ ANDROID
        const AndroidNotificationAction(actionSnooze, 'Snooze 30m', showsUserInterface: false),
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
      id, title, body,
      NotificationDetails(
        android: _buildBasicAndroidDetails('system_alerts_channel'),
        iOS: const DarwinNotificationDetails(
          presentAlert: true, presentBadge: true, presentSound: true, interruptionLevel: InterruptionLevel.active,
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
      id, title, body,
      tz.TZDateTime.from(scheduledTime, tz.local),
      NotificationDetails(
        android: _buildAndroidDetails('medication_exact_channel'),
        iOS: _buildIOSDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
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
    var scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, now.day, time.hour, time.minute);

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    await _notificationsPlugin.zonedSchedule(
      id, title, body,
      scheduledDate,
      NotificationDetails(
        android: _buildAndroidDetails('medication_daily_channel'),
        iOS: _buildIOSDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
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