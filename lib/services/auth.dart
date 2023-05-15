/*import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mood_log/screens/home_page.dart';
import 'package:mood_log/screens/sign_in.dart';
import 'package:mood_log/screens/tab_view.dart';
import 'package:mood_log/services/db.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  String getUserName() {
    return _auth.currentUser?.displayName ?? "Not Signed In";
  }

  String getUserUid() {
    return _auth.currentUser?.uid ?? "Not Signed In";
  }

  // sign in with google
  Future<void> signInWithGoogle(BuildContext context) async {
    final GoogleSignInAccount? googleSignInAccount =
        await _googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      // Getting users credential
      UserCredential result = await _auth.signInWithCredential(authCredential);
      User? user = result.user;

      if (result != null) {
        DatabaseService().createUser(user!.uid, user.displayName!);

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => TabView()));
      }
    }
  }

  Future<void> signOut(BuildContext context) async {
    await _auth.signOut();
    await _googleSignIn.signOut();
    //LocalStorageService().clear();

    // redirect to sign in page
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => SignIn()));
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}
*/