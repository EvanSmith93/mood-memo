import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:mood_log/controllers/settings_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class Settings extends StatefulWidget {
  Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();

  String? encodeQueryParameters(Map<String, String> params) {
  return params.entries
      .map((MapEntry<String, String> e) =>
          '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
      .join('&');
}

  void _sendEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'moodmemofeedback@gmail.com',
      query: encodeQueryParameters(<String, String>{
        'subject': 'Mood Memo Feedback',
      }),
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      throw 'Could not launch email app.';
    }
  }

  final controller = SettingsController();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return ListView(
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
            widget._sendEmail();
          },
        ),
      ],
    );
  }
}
