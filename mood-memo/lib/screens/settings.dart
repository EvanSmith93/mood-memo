import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:mood_memo/controllers/settings_controller.dart';
import 'package:mood_memo/models/color_palette.dart';
import 'package:mood_memo/models/theme_mode_extension.dart';
import 'package:mood_memo/screens/advanced_settings.dart';
import 'package:mood_memo/services/settings.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  SettingsController settingsController = SettingsController();

  @override
  Widget build(BuildContext context) {
    bool reminderEnabled = SettingsService.getReminderEnabled();
    ThemeMode theme = SettingsService.getThemeMode();
    ColorPalette palette = SettingsService.getColorPalette();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, settingsController.didChangePalette);
          },
        ),
      ),
      body: ListView(
        children: [
          // daily reminder settings
          ExpansionTile(
            title: const Text('Daily Reminder'),
            subtitle: Text(reminderEnabled == true
                ? settingsController.formatTime(context)
                : 'Off'),
            children: [
              // enable reminder switch
              ListTile(
                title: const Text('Enable Reminder'),
                trailing: Switch(
                  value: reminderEnabled,
                  onChanged: (value) {
                    setState(() {
                      settingsController.setReminderEnabled(value);
                    });
                  },
                ),
              ),
              // reminder time selection
              ListTile(
                title: const Text('Reminder Time'),
                trailing: Text(settingsController.formatTime(context)),
                enabled: reminderEnabled,
                onTap: () {
                  setState(() {
                    settingsController.selectReminderTime(context, setState);
                  });
                },
              ),
            ],
          ),
          // color palette selection
          ExpansionTile(
            title: const Text('Color Palette'),
            subtitle: Text(palette.name),
            children: [
              // classic palette
              RadioListTile(
                title: const Text('Classic'),
                value: ColorPalette.classic,
                groupValue: palette,
                onChanged: (value) {
                  setState(() {
                    settingsController.setPalette(value!);
                  });
                },
              ),
              // light palette
              RadioListTile(
                title: const Text('Light'),
                value: ColorPalette.light,
                groupValue: palette,
                onChanged: (value) {
                  setState(() {
                    settingsController.setPalette(value!);
                  });
                },
              ),
              // dark palette
              RadioListTile(
                title: const Text('Dark'),
                value: ColorPalette.dark,
                groupValue: palette,
                onChanged: (value) {
                  setState(() {
                    settingsController.setPalette(value!);
                  });
                },
              ),
              // green palette
              RadioListTile(
                title: const Text('Green'),
                value: ColorPalette.green,
                groupValue: palette,
                onChanged: (value) {
                  setState(() {
                    settingsController.setPalette(value!);
                  });
                },
              ),
              // blue palette
              RadioListTile(
                title: const Text('Blue'),
                value: ColorPalette.blue,
                groupValue: palette,
                onChanged: (value) {
                  setState(() {
                    settingsController.setPalette(value!);
                  });
                },
              ),
              // purple palette
              RadioListTile(
                title: const Text('Purple'),
                value: ColorPalette.purple,
                groupValue: palette,
                onChanged: (value) {
                  setState(() {
                    settingsController.setPalette(value!);
                  });
                },
              ),
            ],
          ),
          // theme selection
          ExpansionTile(
            title: const Text('Theme'),
            subtitle: Text(theme.prettyName),
            children: [
              // system default theme
              RadioListTile(
                title: const Text('System Default'),
                value: ThemeMode.system,
                groupValue: theme,
                onChanged: (value) {
                  setState(() {
                    settingsController.setTheme(value!);
                  });
                },
              ),
              // light theme
              RadioListTile(
                title: const Text('Light'),
                value: ThemeMode.light,
                groupValue: theme,
                onChanged: (value) {
                  setState(() {
                    settingsController.setTheme(value!);
                  });
                },
              ),
              // dark theme
              RadioListTile(
                title: const Text('Dark'),
                value: ThemeMode.dark,
                groupValue: theme,
                onChanged: (value) {
                  setState(() {
                    settingsController.setTheme(value!);
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
              settingsController.sendFeedback();
            },
          ),
          // rate app button -> opens app store
          ListTile(
            title: const Text('Rate App'),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              settingsController.rateApp();
            },
          ),
          // advanced settings button -> opens advanced settings page
          ListTile(
            title: const Text('Advanced Settings'),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AdvancedSettings(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
