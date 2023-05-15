import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:mood_log/controllers/settings_controller.dart';
import 'package:mood_log/services/auth.dart';
import 'package:mood_log/services/db.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    SettingsController controller = SettingsController();

    // list view
    return ListView(
      children: [
        // add the user's name as a heading
        ListTile(
          title: FutureBuilder(
            future: controller.getUserName(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data);
              } else {
                return const Text("Loading...");
              }
            },
          ),
          subtitle: const Text('User Email'),
        ),
        ListTile(
          title: const Text('Sign Out'),
          trailing: const Icon(Icons.logout),
          onTap: () {
            print("Signing out");
            AuthService().signOut(context);
          },
        ),
      ],
    );
  }
}
