import 'package:flutter/material.dart' hide ModalBottomSheetRoute;

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    //SettingsController controller = SettingsController();

    // list view
    return ListView(
      children: const [
        ListTile(
          title: Text('User Name'),
          subtitle: Text('User Email'),
        ),
      ],
    );
  }
}
