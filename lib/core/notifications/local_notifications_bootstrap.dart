import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

/// Notification id for the shopping-notes daily reminder channel.
const int kDailyReminderNotificationId = 9001;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

bool _localNotificationsInitialized = false;

/// Loads timezone data and prepares the plugin (safe to call once from [main]).
Future<void> initializeLocalNotificationsPlugin() async {
  if (_localNotificationsInitialized) {
    return;
  }
  try {
    tz_data.initializeTimeZones();
    final String zoneName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(zoneName));
    const AndroidInitializationSettings androidInit =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings iosInit = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    const InitializationSettings initSettings = InitializationSettings(
      android: androidInit,
      iOS: iosInit,
      macOS: iosInit,
    );
    await flutterLocalNotificationsPlugin.initialize(initSettings);
    _localNotificationsInitialized = true;
  } on Object catch (e, st) {
    developer.log(
      'Local notifications init failed',
      error: e,
      stackTrace: st,
    );
  }
}

/// Requests OS permission where required (iOS; Android 13+ handled separately).
Future<bool> requestLocalNotificationPermissions() async {
  if (kIsWeb) {
    return false;
  }
  try {
    final bool? ios = await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >()
        ?.requestPermissions(alert: true, badge: true, sound: true);
    final bool? macos = await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          MacOSFlutterLocalNotificationsPlugin
        >()
        ?.requestPermissions(alert: true, badge: true, sound: true);
    if (ios == true || macos == true) {
      return true;
    }
    return ios ?? macos ?? true;
  } on Object catch (e, st) {
    developer.log(
      'Notification permission request failed',
      error: e,
      stackTrace: st,
    );
    return false;
  }
}

/// Cancels the daily reminder if scheduled.
Future<void> cancelDailyReminderNotification() async {
  await flutterLocalNotificationsPlugin.cancel(kDailyReminderNotificationId);
}

/// Schedules a daily notification at [hour]:[minute] local time.
Future<void> scheduleDailyReminder({
  required int hour,
  required int minute,
  required String title,
  required String body,
}) async {
  if (kIsWeb || !_localNotificationsInitialized) {
    return;
  }
  final tz.TZDateTime next = _nextInstanceOfTime(hour, minute);
  const AndroidNotificationDetails android = AndroidNotificationDetails(
    'daily_reminder_channel',
    'Daily reminders',
    channelDescription: 'Reminders for shopping notes',
    importance: Importance.defaultImportance,
    priority: Priority.defaultPriority,
  );
  const DarwinNotificationDetails ios = DarwinNotificationDetails();
  const NotificationDetails details = NotificationDetails(
    android: android,
    iOS: ios,
    macOS: ios,
  );
  await flutterLocalNotificationsPlugin.zonedSchedule(
    kDailyReminderNotificationId,
    title,
    body,
    next,
    details,
    androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
    matchDateTimeComponents: DateTimeComponents.time,
  );
}

tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
  final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
  tz.TZDateTime scheduled = tz.TZDateTime(
    tz.local,
    now.year,
    now.month,
    now.day,
    hour,
    minute,
  );
  if (scheduled.isBefore(now)) {
    scheduled = scheduled.add(const Duration(days: 1));
  }
  return scheduled;
}
