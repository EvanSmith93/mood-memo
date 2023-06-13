import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mood_memo/main.dart';
import 'package:mood_memo/services/db.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsController extends ChangeNotifier {
  DatabaseService db = DatabaseService();

  static ThemeMode theme = ThemeMode.system;

  static Future<void> initializeTheme() async {
    theme = await DatabaseService.getThemeMode();
    await setTheme(theme);
  }

  String get themeName {
    switch (theme) {
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

  static Future<void> setTheme(ThemeMode mode) async {
    MyApp.themeMode.value = mode;
    theme = mode;
    await DatabaseService.setThemeMode(mode);
  }

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

  void rateApp() async {
    const String appId = 'com.evansmith.mood_memo';

    final uri = Uri(
      scheme: 'https',
      host: 'play.google.com',
      path: 'store/apps/details',
      queryParameters: <String, String>{
        'id': appId,
      },
    );

    try {
      await launchUrl(uri);
    } catch (e) {
      throw 'Could not launch app store.';
    }
  }
}
