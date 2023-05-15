import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:mood_log/services/auth.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    // sign in page with
    return Material(
  child: Container(
    alignment: Alignment.center,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Mood Log',
          style: TextStyle(fontSize: 60),
        ),
        const SizedBox(
          height: 50,
        ),
        SizedBox(
          width: 200, // Set a fixed width for the button
          child: Center(
            child: SignInButton(
              Buttons.Google,
              onPressed: () {
                AuthService().signInWithGoogle(context);
              },
            ),
          ),
        ),
      ],
    ),
  ),
);
  }
}
