import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:mood_log/screens/tab_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // App Todos:
  
  // MAYBE NOT NEEDED : import and export data
  // MAYBE NOT NEEDED : donate button
  
  // TO DO : make the detail screen look better
  // TO DO : change the color scheme for the ratings
  // TO DO : contact support button
  // TO DO : alert for deleting a rating
  // TO DO : alert for deleting an unfinished rating
  // TO DO : alert for adding a rating on top of another rating

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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Mood Log',
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
        home: const TabView(),
      );
  }
}
