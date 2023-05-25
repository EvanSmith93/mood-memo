import 'package:flutter/material.dart';
import 'package:mood_log/controllers/settings_controller.dart';
import 'package:mood_log/screens/tab_view.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool shouldProceed = false;

  _fetchPrefs() async {
    await SettingsController.initializeTheme();

    setState(() {
      shouldProceed = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return shouldProceed ? const TabView() : const SizedBox.shrink();
  }
}
