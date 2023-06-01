import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:mood_memo/controllers/settings_controller.dart';

class Settings extends StatefulWidget {
  Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();

  final controller = SettingsController();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        ),
      body: ListView(
        children: [
          ExpansionTile(
            title: const Text('Theme'),
            subtitle: Text(widget.controller.themeName),
            children: [
              RadioListTile(
                title: const Text('System Default'),
                value: ThemeMode.system,
                groupValue: SettingsController.theme,
                onChanged: (value) {
                  setState(() {
                    SettingsController.setTheme(value!);
                  });
                },
              ),
              RadioListTile(
                title: const Text('Light'),
                value: ThemeMode.light,
                groupValue: SettingsController.theme,
                onChanged: (value) {
                  setState(() {
                    SettingsController.setTheme(value!);
                  });
                },
              ),
              RadioListTile(
                title: const Text('Dark'),
                value: ThemeMode.dark,
                groupValue: SettingsController.theme,
                onChanged: (value) {
                  setState(() {
                    SettingsController.setTheme(value!);
                  });
                },
              ),
            ],
          ),
          // send feedback button -> opens email app
          ListTile(
            title: const Text('Send Feedback'),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              widget.controller.sendFeedback();
            },
          ),
          // rate app button -> opens app store
          /*ListTile(
            title: const Text('Rate App'),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              widget.controller.rateApp();
            },
          ),*/
        ],
      ),
    );
  }
}
