import 'package:flutter/material.dart';
import 'package:mood_memo/controllers/settings_controller.dart';

class AdvancedSettings extends StatefulWidget {
  const AdvancedSettings({super.key});

  @override
  State<AdvancedSettings> createState() => _AdvancedSettingsState();
}

class _AdvancedSettingsState extends State<AdvancedSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Column(
        children: [
          // export ratings button -> exports data to csv file
          ListTile(
            title: const Text('Export Ratings'),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () async {
              await SettingsController.exportRatings();
            },
          ),
          // privacy policy button -> opens browser
          ListTile(
            title: const Text('Privacy Policy'),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              SettingsController.privacyPolicy();
            },
          ),
          // app version number
          ListTile(
            title: const Text('App Version'),
            trailing: FutureBuilder(
              future: SettingsController.getAppVersion(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data.toString());
                } else {
                  return const Text('Loading...');
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
