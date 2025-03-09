import 'dart:io';
import 'package:csv/csv.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mood_memo/main.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:mood_memo/models/color_palette.dart';
import 'package:mood_memo/services/db.dart';
import 'package:mood_memo/services/reminder.dart';
import 'package:mood_memo/services/settings.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsController extends ChangeNotifier {
  static const String notificationTitle = "Daily Reminder";
  static const String notificationBody =
      "It's time to record your mood for today.";

  bool didChangePalette = false;

  /// Returns whether the reminder is enabled.
  Future<void> setReminderEnabled(bool value) async {
    SettingsService.setReminderEnabled(value);
    if (value == false) {
      ReminderService.cancelNotification();
    } else {
      // TODO: if the notification permission isn't granted, tell the user to enable it. requestPermissions returns a bool that's true if the permission is granted.
      if (Platform.isIOS) {
        await FlutterLocalNotificationsPlugin()
            .resolvePlatformSpecificImplementation<
                IOSFlutterLocalNotificationsPlugin>()
            ?.requestPermissions(
              alert: true,
              badge: true,
              sound: true,
            );
      } else if (Platform.isAndroid) {
        await FlutterLocalNotificationsPlugin()
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.requestNotificationsPermission();
      }

      ReminderService.scheduleDailyNotification(
          title: notificationTitle,
          body: notificationBody,
          time: SettingsService.getReminderTime());
    }
  }

  /// Returns the formatted time of the reminder.
  /// TODO: refactor this to use the TimeOfDay extension
  String formatTime(BuildContext context) {
    return SettingsService.getReminderTime().format(context);
  }

  /// Lets the user select a time for the reminder.
  Future<void> selectReminderTime(
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
          title: notificationTitle, body: notificationBody, time: picked);
    }
  }

  /// Sets the theme of the app.
  void setTheme(ThemeMode mode) {
    MyApp.themeMode.value = mode;
    SettingsService.setThemeMode(mode);
  }

  /// Sets the color palette of the app.
  void setPalette(ColorPalette color) {
    didChangePalette = true;
    SettingsService.setColorPalette(color);
  }

  /// Opens the email app with a pre-filled email to send feedback.
  void sendFeedback() async {
    String email = Uri.encodeComponent("moodmemofeedback@gmail.com");
    String subject = Uri.encodeComponent("Mood Memo Feedback");
    String body = Uri.encodeComponent("""Device Info (do not delete):
    Device: ${await _getDeviceModel()}
    OS: ${await _getSystemVersion()}
    App Version: ${await getAppVersion()}
    
    Share your feedback here:
    


    """);

    Uri mail = Uri.parse("mailto:$email?subject=$subject&body=$body");

    if (await canLaunchUrl(mail)) {
      await launchUrl(mail);
    } else {
      throw 'Could not launch email app.';
    }
  }

  /// Opens the app store page for the app.
  void rateApp() async {
    final appId = Platform.isIOS ? '' : 'com.evansmith.mood_memo';

    try {
      if (Platform.isIOS) {
        final url = Uri.parse(
            'https://apps.apple.com/app/id$appId?action=write-review');
        if (await canLaunchUrl(url)) {
          await launchUrl(url, mode: LaunchMode.externalApplication);
        }
      } else if (Platform.isAndroid) {
        final url = Uri.parse('market://details?id=$appId');
        if (await canLaunchUrl(url)) {
          await launchUrl(url, mode: LaunchMode.externalApplication);
        } else {
          final webUrl =
              Uri.parse('https://play.google.com/store/apps/details?id=$appId');
          await launchUrl(webUrl, mode: LaunchMode.externalApplication);
        }
      }
    } catch (e) {
      throw 'Could not launch url.';
    }
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

  /// Exports the data to a csv file and saves it to the device files.
  Future<void> exportRatings() async {
    try {
      Map<Permission, PermissionStatus> _ = await [
        Permission.storage,
      ].request();

      final table = DatabaseService.getRatingTable();
      String csv = const ListToCsvConverter().convert(table);

      String dir;
      if (Platform.isAndroid) {
        dir = await ExternalPath.getExternalStoragePublicDirectory(
            ExternalPath.DIRECTORY_DOWNLOAD);
      } else if (Platform.isIOS) {
        Directory documents = await getApplicationDocumentsDirectory();
        dir = documents.path;
      } else {
        throw 'Platform not supported.';
      }

      await Directory(dir).create(recursive: true);
      File f = File('$dir/exported_ratings.csv');
      f.writeAsString(csv);

      showExportAlert(true);
    } catch (e) {
      showExportAlert(false, e.toString());
    }
  }

  /// Shows an alert dialog to the user with the result of the export.
  void showExportAlert(bool success, [String? error]) {
    if (success) {
      final String message;
      if (Platform.isAndroid) {
        message =
            "The ratings have been exported to the downloads folder in your device's files.";
      } else {
        message = "The ratings have been exported to the Files app.";
      }
      showDialog(
        context: navigatorKey.currentContext!,
        builder: (context) => AlertDialog(
          title: const Text('Export Successful'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
    } else {
      final message =
          'An error occurred while exporting the ratings.${error != null ? '\nError: $error' : ''}';
      showDialog(
        context: navigatorKey.currentContext!,
        builder: (context) => AlertDialog(
          title: const Text('Export Failed'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
    }
  }

  /// Returns the device model.
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

  /// Returns the system's version.
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

  /// Returns the app's version.
  Future<String> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String appVersion = packageInfo.version;
    return appVersion;
  }
}
