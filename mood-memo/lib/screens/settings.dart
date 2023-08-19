import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:mood_memo/controllers/settings_controller.dart';
import 'package:mood_memo/services/settings.dart';
import 'package:external_path/external_path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class Settings extends StatefulWidget {
  Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();

  final controller = SettingsController();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    bool reminderEnabled = SettingsService.getReminderEnabled();
    ThemeMode theme = SettingsService.getThemeMode();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          // daily reminder settings
          ExpansionTile(
            title: const Text('Daily Reminder'),
            subtitle: Text(reminderEnabled == true
                ? SettingsController.formatTime(context)
                : 'Off'),
            children: [
              // enable reminder switch
              ListTile(
                title: const Text('Enable Reminder'),
                trailing: Switch(
                  value: reminderEnabled,
                  onChanged: (value) {
                    setState(() {
                      SettingsController.setReminderEnabled(value);
                    });
                  },
                ),
              ),
              // reminder time selection
              ListTile(
                title: const Text('Reminder Time'),
                trailing: Text(SettingsController.formatTime(context)),
                enabled: reminderEnabled,
                onTap: () {
                  setState(() {
                    SettingsController.selectReminderTime(context, setState);
                  });
                },
              ),
            ],
          ),
          // theme selection
          ExpansionTile(
            title: const Text('Theme'),
            subtitle: Text(widget.controller.themeName),
            children: [
              RadioListTile(
                title: const Text('System Default'),
                value: ThemeMode.system,
                groupValue: theme,
                onChanged: (value) {
                  setState(() {
                    SettingsController.setTheme(value!);
                  });
                },
              ),
              RadioListTile(
                title: const Text('Light'),
                value: ThemeMode.light,
                groupValue: theme,
                onChanged: (value) {
                  setState(() {
                    SettingsController.setTheme(value!);
                  });
                },
              ),
              RadioListTile(
                title: const Text('Dark'),
                value: ThemeMode.dark,
                groupValue: theme,
                onChanged: (value) {
                  setState(() {
                    SettingsController.setTheme(value!);
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          // send feedback button -> opens email app
          ListTile(
            title: const Text('Send Feedback'),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              widget.controller.sendFeedback();
            },
          ),
          // rate app button -> opens app store
          ListTile(
            title: const Text('Rate App'),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              widget.controller.rateApp();
            },
          ),
          // privacy policy button -> opens browser
          ListTile(
            title: const Text('Privacy Policy'),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              widget.controller.privacyPolicy();
            },
          ),
          // app version number
          ListTile(
            title: const Text('App Version'),
            trailing: FutureBuilder(
              future: widget.controller.getAppVersion(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data.toString());
                } else {
                  return const Text('Loading...');
                }
              },
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              SettingsController.exportData();
            },
            child: const Text('Export Data'),
          ),
        ],
      ),
    );
  }
}
