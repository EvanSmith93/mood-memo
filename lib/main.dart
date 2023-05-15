import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:mood_log/screens/home_page.dart';
import 'package:mood_log/screens/tab_view.dart';
import 'package:mood_log/services/auth.dart';
import 'package:mood_log/widgets/color_box.dart';
import 'package:mood_log/widgets/new_rating.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'screens/sign_in.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  //String uid = AuthService().getUserUid();
  //String name = AuthService().getUserName();
  //LocalStorageService().createUser(uid, name);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // General App Todos:
  // MAYBE NOT NEEDED : hide the date selector until the user clicks on the date
  // MAYBE NOT NEEDED : move the tab bar to the bottom of the screen
  // change the color scheme for the ratings
  // fix minor issues with the google sign in
  // let the user edit posts
  
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
  // SORT OF DONE : figure out how to manage the cache

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        title: 'Mood Log',
        // if the user is signed in, show the home page
        home: TabView(),
      );
    // check if the user is signed in
    /*if (FirebaseAuth.instance.currentUser != null) {
      //print(FirebaseAuth.instance.currentUser);
      return const MaterialApp(
        title: 'Mood Log',
        // if the user is signed in, show the home page
        home: TabView(),
      );
    } else {
      return const MaterialApp(
        title: 'Mood Log',
        // if the user isn't signed in, show the sign in page
        home: SignIn(),
      );
    }*/
  }
}
