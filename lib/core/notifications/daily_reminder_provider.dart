import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../prefs/app_preferences_keys.dart';
import '../prefs/shared_preferences_provider.dart';
import 'local_notifications_bootstrap.dart';

final NotifierProvider<DailyReminderNotifier, bool> dailyReminderEnabledProvider =
    NotifierProvider<DailyReminderNotifier, bool>(DailyReminderNotifier.new);

/// Persists and schedules the daily shopping-notes reminder.
class DailyReminderNotifier extends Notifier<bool> {
  static const int _defaultHour = 20;
  static const int _defaultMinute = 0;

  @override
  bool build() {
    final SharedPreferences prefs = ref.read(sharedPreferencesProvider);
    return prefs.getBool(AppPreferencesKeys.dailyReminderEnabled) ?? false;
  }

  Future<void> setEnabled(bool enabled) async {
    final SharedPreferences prefs = ref.read(sharedPreferencesProvider);
    if (kIsWeb) {
      await prefs.setBool(AppPreferencesKeys.dailyReminderEnabled, enabled);
      state = enabled;
      return;
    }
    if (enabled) {
      final AndroidFlutterLocalNotificationsPlugin? android =
          flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin
              >();
      await android?.requestNotificationsPermission();
      await requestLocalNotificationPermissions();
      final int hour =
          prefs.getInt(AppPreferencesKeys.dailyReminderHour) ?? _defaultHour;
      final int minute =
          prefs.getInt(AppPreferencesKeys.dailyReminderMinute) ??
          _defaultMinute;
      await prefs.setBool(AppPreferencesKeys.dailyReminderEnabled, true);
      await prefs.setInt(AppPreferencesKeys.dailyReminderHour, hour);
      await prefs.setInt(AppPreferencesKeys.dailyReminderMinute, minute);
      await scheduleDailyReminder(
        hour: hour,
        minute: minute,
        title: 'Shop Paradise',
        body: 'Add today purchases to shopping notes.',
      );
      state = true;
    } else {
      await prefs.setBool(AppPreferencesKeys.dailyReminderEnabled, false);
      await cancelDailyReminderNotification();
      state = false;
    }
  }
}
