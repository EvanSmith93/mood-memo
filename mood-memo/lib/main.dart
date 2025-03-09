import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:mood_memo/screens/home.dart';
import 'package:mood_memo/services/reminder.dart';
import 'package:mood_memo/services/settings.dart';
import 'package:mood_memo/services/setup_hive.dart';
//import 'package:mood_memo/screens/splash.dart';;

final navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupHive();
  ReminderService.initialize();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  static final ValueNotifier<ThemeMode> themeMode =
      ValueNotifier(SettingsService.getThemeMode());
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: MyApp.themeMode,
        builder: (context, value, child) {
          return MaterialApp(
            title: 'Mood Memo',
            debugShowCheckedModeBanner: false,
            navigatorKey: navigatorKey,
            themeMode: value,
            theme: ThemeData.light().copyWith(
              colorScheme: const ColorScheme.light(
                primary: Colors.blue,
                secondary: Colors.blue,
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[300],
                  foregroundColor: Colors.black,
                ),
              ),
              appBarTheme: AppBarTheme(
                backgroundColor: ThemeData.light().scaffoldBackgroundColor,
                elevation: 0,
                iconTheme: const IconThemeData(color: Colors.black),
                titleTextStyle:
                    Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Colors.black,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w600,
                        ),
              ),
              textTheme: Theme.of(context).textTheme.apply(
                    fontFamily: "Poppins",
                  ),
            ),
            darkTheme: ThemeData.dark().copyWith(
              colorScheme: const ColorScheme.dark(
                primary: Colors.blue,
                secondary: Colors.blue,
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[850],
                  foregroundColor: Colors.white,
                ),
              ),
              appBarTheme: AppBarTheme(
                backgroundColor: ThemeData.dark().scaffoldBackgroundColor,
                elevation: 0,
                iconTheme: const IconThemeData(color: Colors.white),
                titleTextStyle:
                    Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Colors.white,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w600,
                        ),
              ),
              textTheme: Theme.of(context).textTheme.apply(
                    fontFamily: "Poppins",
                    bodyColor: Colors.white,
                  ),
            ),
            home: const Home(),
          );
        });
  }
}
