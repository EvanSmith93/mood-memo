// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyB-5nStMRPGCGckFvysc6k0T6n-qlAeiwk',
    appId: '1:389972884633:web:b688891ea1826111accc08',
    messagingSenderId: '389972884633',
    projectId: 'mood-log-d077d',
    authDomain: 'mood-log-d077d.firebaseapp.com',
    storageBucket: 'mood-log-d077d.appspot.com',
    measurementId: 'G-28923VH54C',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDoUpuBpmQOL9qaxgde0cNGXbPeiBN_T2Y',
    appId: '1:389972884633:android:f1353132a4a0192baccc08',
    messagingSenderId: '389972884633',
    projectId: 'mood-log-d077d',
    storageBucket: 'mood-log-d077d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD86_zCoSGQx_BUupEIVgfLRhKxI3F08Xo',
    appId: '1:389972884633:ios:ea4d9efabda64c32accc08',
    messagingSenderId: '389972884633',
    projectId: 'mood-log-d077d',
    storageBucket: 'mood-log-d077d.appspot.com',
    iosClientId: '389972884633-vip4v4elof9got3a02un4v5pnubeap2o.apps.googleusercontent.com',
    iosBundleId: 'com.example.moodLog',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD86_zCoSGQx_BUupEIVgfLRhKxI3F08Xo',
    appId: '1:389972884633:ios:ea4d9efabda64c32accc08',
    messagingSenderId: '389972884633',
    projectId: 'mood-log-d077d',
    storageBucket: 'mood-log-d077d.appspot.com',
    iosClientId: '389972884633-vip4v4elof9got3a02un4v5pnubeap2o.apps.googleusercontent.com',
    iosBundleId: 'com.example.moodLog',
  );
}
