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
        return windows;
      case TargetPlatform.linux:
        return unsupported; // Add a dummy FirebaseOptions for unsupported platforms
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBwEsyNC2FSDV5UVpvfk-wl5dIFA2CXJ3I',
    appId: '1:27112409934:web:be7463bb94e9a37a3bec1f',
    messagingSenderId: '27112409934',
    projectId: 'holbegram-86cda',
    authDomain: 'holbegram-86cda.firebaseapp.com',
    storageBucket: 'holbegram-86cda.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDlqbo_WsK8S6j6QcfhIjnwWKQIn3Bt_60',
    appId: '1:27112409934:android:3003e066d125c3ed3bec1f',
    messagingSenderId: '27112409934',
    projectId: 'holbegram-86cda',
    storageBucket: 'holbegram-86cda.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAQBFbSI93LqwJ2O-3M-U_qOLoUjekHX0M',
    appId: '1:27112409934:ios:0764e866e0def3fe3bec1f',
    messagingSenderId: '27112409934',
    projectId: 'holbegram-86cda',
    storageBucket: 'holbegram-86cda.appspot.com',
    iosBundleId: 'com.example.holbegram',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAQBFbSI93LqwJ2O-3M-U_qOLoUjekHX0M',
    appId: '1:27112409934:ios:0764e866e0def3fe3bec1f',
    messagingSenderId: '27112409934',
    projectId: 'holbegram-86cda',
    storageBucket: 'holbegram-86cda.appspot.com',
    iosBundleId: 'com.example.holbegram',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBwEsyNC2FSDV5UVpvfk-wl5dIFA2CXJ3I',
    appId: '1:27112409934:web:9ae42204adb4a1873bec1f',
    messagingSenderId: '27112409934',
    projectId: 'holbegram-86cda',
    authDomain: 'holbegram-86cda.firebaseapp.com',
    storageBucket: 'holbegram-86cda.appspot.com',
  );

  static const FirebaseOptions unsupported = FirebaseOptions(
    apiKey: '',
    appId: '',
    messagingSenderId: '',
    projectId: '',
    authDomain: '',
    storageBucket: '',
  );
}
