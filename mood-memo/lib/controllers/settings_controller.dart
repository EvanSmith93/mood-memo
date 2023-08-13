import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mood_memo/main.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:mood_memo/services/reminder.dart';
import 'package:mood_memo/services/settings.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:launch_review/launch_review.dart';

class SettingsController extends ChangeNotifier {
  static String notificationTitle = "Daily Reminder";
  static String notificationBody = "It's time to record your mood for today.";

  /// Returns whether the reminder is enabled.
  static void setReminderEnabled(bool value) {
    SettingsService.setReminderEnabled(value);

    if (value == false) {
      ReminderService.cancelNotification();
    } else {
      ReminderService.scheduleDailyNotification(
          title: notificationTitle,
          body: notificationBody,
          time: SettingsService.getReminderTime());
    }
  }

  /// Returns the formatted time of the reminder.
  static String formatTime(BuildContext context) {
    return SettingsService.getReminderTime().format(context);
  }

  /// Lets the user select a time for the reminder.
  static Future<void> selectReminderTime(
      BuildContext context, Function refresher) async {
    TimeOfDay initialTime = SettingsService.getReminderTime();

    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (picked != null && picked != initialTime) {
      SettingsService.setReminderTime(picked);
      refresher(() {});

      ReminderService.scheduleDailyNotification(
          title: notificationTitle,
          body: notificationBody,
          time: picked);
    }
  }

  /// Returns the name of the current theme.
  String get themeName {
    switch (SettingsService.getThemeMode()) {
      case ThemeMode.system:
        return 'System Default';
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
      default:
        return 'System Default';
    }
  }

  /// Sets the theme of the app.
  static void setTheme(ThemeMode mode) {
    MyApp.themeMode.value = mode;
    SettingsService.setThemeMode(mode);
  }

  /// Opens the email app with a pre-filled email to send feedback.
  void sendFeedback() async {
    String? encodeQueryParameters(Map<String, String> params) {
      return params.entries
          .map((MapEntry<String, String> e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
    }

    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'moodmemofeedback@gmail.com',
      query: encodeQueryParameters(<String, String>{
        'subject': 'Mood Memo Feedback',
        'body':
            'Share your feedback here:\n\n\n\n------------------------\nDevice Info:\nDevice: ${await _getDeviceModel()}\nOS: ${await _getSystemVersion()}\nApp Version: ${await _getAppVersion()}\n',
      }),
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      throw 'Could not launch email app.';
    }
  }

  /// Opens the app store page for the app.
  void rateApp() async {
    LaunchReview.launch();
  }

  /// Opens the privacy policy page in the browser.
  void privacyPolicy() async {
    final uri =
        Uri.parse('https://evansmith93.github.io/mood-memo-site/#/privacy');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch url.';
    }
  }

  Future<String> _getDeviceModel() async {
    try {
      if (Platform.isIOS) {
        final deviceInfo = await DeviceInfoPlugin().iosInfo;
        return deviceInfo.utsname.machine;
      } else if (Platform.isAndroid) {
        final deviceInfo = await DeviceInfoPlugin().androidInfo;
        return deviceInfo.model;
      }
    } on PlatformException {
      return 'error getting device model';
    }
    return 'error getting device model';
  }

  Future<String> _getSystemVersion() async {
    try {
      if (Platform.isIOS) {
        final deviceInfo = await DeviceInfoPlugin().iosInfo;
        return deviceInfo.systemVersion;
      } else if (Platform.isAndroid) {
        final deviceInfo = await DeviceInfoPlugin().androidInfo;
        return deviceInfo.version.release;
      }
    } on PlatformException {
      return 'error getting system version';
    }
    return 'error getting system version';
  }

  Future<String> _getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String appVersion = packageInfo.version;
    return appVersion;
  }
}
