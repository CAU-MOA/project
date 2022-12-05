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
    apiKey: 'AIzaSyCeS9xuJKiYUa7gxSHQYGM0UgyID1fjzyY',
    appId: '1:684085447631:web:3a36956bb2ae6a95d320ba',
    messagingSenderId: '684085447631',
    projectId: 'login-practice-sungwon',
    authDomain: 'login-practice-sungwon.firebaseapp.com',
    storageBucket: 'login-practice-sungwon.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD0_XV5U7yvAa-npvItQPV-P85xVW8_Gyc',
    appId: '1:684085447631:android:af97adf2fcc03283d320ba',
    messagingSenderId: '684085447631',
    projectId: 'login-practice-sungwon',
    storageBucket: 'login-practice-sungwon.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAJ8Ojn9TB-HdPwMWpJhH9-pG9I9HT7qww',
    appId: '1:684085447631:ios:80990f7cffe75899d320ba',
    messagingSenderId: '684085447631',
    projectId: 'login-practice-sungwon',
    storageBucket: 'login-practice-sungwon.appspot.com',
    iosClientId: '684085447631-spfksjhp15dlcbq76fd9ksv905msjbji.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterFirebase',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAJ8Ojn9TB-HdPwMWpJhH9-pG9I9HT7qww',
    appId: '1:684085447631:ios:80990f7cffe75899d320ba',
    messagingSenderId: '684085447631',
    projectId: 'login-practice-sungwon',
    storageBucket: 'login-practice-sungwon.appspot.com',
    iosClientId: '684085447631-spfksjhp15dlcbq76fd9ksv905msjbji.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterFirebase',
  );
}
