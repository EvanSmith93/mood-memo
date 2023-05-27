import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:mood_log/screens/splash.dart';

final navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();

  static final ValueNotifier<ThemeMode> themeMode =
      ValueNotifier(ThemeMode.system);
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: MyApp.themeMode,
        builder: (context, value, child) {
          return MaterialApp(
            title: 'Mood Log',
            navigatorKey: navigatorKey,
            themeMode: value,
            theme: ThemeData(
              brightness: Brightness.light,
              colorScheme: const ColorScheme.light(
                primary: Colors.blue,
                secondary: Colors.blue,
              ),
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              colorScheme: const ColorScheme.dark(
                primary: Colors.blue,
                secondary: Colors.blue,
              ),
            ),
            home: const Splash(),
          );
        });
  }
}

// App Todos:

  // MAYBE NOT NEEDED : import and export data
  // MAYBE NOT NEEDED : donate button
  // MAYBE NOT NEEDED : change color scheme option
  // MAYBE NOT NEEDED : fix a bug related to the theme on startup
  // MAYBE NOT NEEDED : fix the bug related to the modal bottom sheet scrolling weird (warning: this might be a bug with flutter. Flutter issue # 24489)

  // TO DO : change the color scheme for the ratings
  // TO DO : clean up code (especially the new rating code)
  // TO Do : clean up the database code (make the functions static?)
  // TO DO : test on android
  // TO DO : fix all of the visual bugs when running on a physical device

  // DONE : let the user edit posts
  // DONE : fix keyboard bug
  // DONE : make the sign in page look better
  // DONE : add a rating detail page
  // DONE : add a way to delete a rating
  // DONE : add a note field to the rating
  // DONE : make the calendar auto refresh when you add a new rating
  // DONE : add the user's name to the settings page
  // DONE : change the db functions to only return one rating, not a list of ratings
  // DONE : figure out if I want to use the date as the id for ratings in the database
  // DONE : have the color buttons be selectable, and then have a submit button (so you can include a note)
  // DONE : make the greyed out days clickable
  // DONE : figure out how to manage the cache
  // DONE : fix minor issues with the google sign in
  // DONE : move the tab bar to the bottom of the screen
  // DONE : add dark mode support
  // DONE : make the data format more user friendly
  // DONE : add emojis to the ratings
  // DONE : alert for deleting a rating
  // DONE : alert for deleting an unfinished rating
  // DONE : alert for adding a rating on top of another rating
  // DONE : figure out if I need to pass the context around
  // DONE : make the detail screen look better
  // DONE : fix the bug with the new rating modal overlapping the dynamic island / notch
  // DONE : change theme option
  // DONE : contact support button