import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart';
import 'package:flutter_native_timezone_updated_gradle/flutter_native_timezone.dart';

class ReminderService {
  static final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  /// Initializes the flutter local notifications
  static Future<void> initialize() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings("ic_stat_android_app_icon");

    DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
            requestSoundPermission: false,
            requestBadgePermission: false,
            requestAlertPermission: false,
            onDidReceiveLocalNotification: (int id, String? title, String? body,
                String? payload) async {});

    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse response) async {});
  }

  /// Displays a notification when run (currently unused)
  static Future showNotification(
      {int id = 1, required String title, required String body}) {
    return notificationsPlugin.show(id, title, body, _notificationDetails());
  }

  /// Scheudles a daily notification at the specified time.
  static Future<void> scheduleDailyNotification(
      {int id = 0,
      required String title,
      required String body,
      required TimeOfDay time}) async {
    final initialScheduledDate = await _initialScheduledDate(time);

    await notificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      initialScheduledDate,
      _notificationDetails(),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.wallClockTime,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  /// Cancels the scheduled daily notification with the specified ID.
  static Future<void> cancelNotification({int id = 0}) async {
    await notificationsPlugin.cancel(id);
  }

  /// Returns the notification details for ios and android
  static NotificationDetails _notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails(
          'daily_notification',
          'Daily Notification',
          importance: Importance.max,
        ),
        iOS: DarwinNotificationDetails());
  }

  /// Calculates the initial time for the first occurrence of the notification based on the time zone of the device.
  static Future<TZDateTime> _initialScheduledDate(TimeOfDay notificationTime) async {
    final locationName = await FlutterNativeTimezone.getLocalTimezone();
    final location = getLocation(locationName);
    final now = TZDateTime.from(DateTime.now(), location);

    final scheduledDate = TZDateTime(
      location,
      now.year,
      now.month,
      now.day,
      notificationTime.hour,
      notificationTime.minute,
    );

    return scheduledDate.isBefore(now)
        ? scheduledDate.add(const Duration(days: 1))
        : scheduledDate;
  }
}
