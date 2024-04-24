// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
    apiKey: 'AIzaSyCya5XKBIZc9qbw07GGy1cKxOd7yQetC_4',
    appId: '1:5048789483:web:6dec56969e73abd8d4d1ae',
    messagingSenderId: '5048789483',
    projectId: 'system1-d685d',
    authDomain: 'system1-d685d.firebaseapp.com',
    databaseURL: 'https://system1-d685d-default-rtdb.firebaseio.com',
    storageBucket: 'system1-d685d.appspot.com',
    measurementId: 'G-0SZ6S6B1VQ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCzyF7weQteGefPCCYiKk0gEtk4ECox_ec',
    appId: '1:5048789483:android:fe7602d66fc373fed4d1ae',
    messagingSenderId: '5048789483',
    projectId: 'system1-d685d',
    databaseURL: 'https://system1-d685d-default-rtdb.firebaseio.com',
    storageBucket: 'system1-d685d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCZl3y0xyZ9PO7ImEzwhWQqx8aHE5-VaPo',
    appId: '1:5048789483:ios:910347d6fb379cc9d4d1ae',
    messagingSenderId: '5048789483',
    projectId: 'system1-d685d',
    databaseURL: 'https://system1-d685d-default-rtdb.firebaseio.com',
    storageBucket: 'system1-d685d.appspot.com',
    iosBundleId: 'com.example.smartAgriculture',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCZl3y0xyZ9PO7ImEzwhWQqx8aHE5-VaPo',
    appId: '1:5048789483:ios:910347d6fb379cc9d4d1ae',
    messagingSenderId: '5048789483',
    projectId: 'system1-d685d',
    databaseURL: 'https://system1-d685d-default-rtdb.firebaseio.com',
    storageBucket: 'system1-d685d.appspot.com',
    iosBundleId: 'com.example.smartAgriculture',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCya5XKBIZc9qbw07GGy1cKxOd7yQetC_4',
    appId: '1:5048789483:web:9ffd373b9fa6fa14d4d1ae',
    messagingSenderId: '5048789483',
    projectId: 'system1-d685d',
    authDomain: 'system1-d685d.firebaseapp.com',
    databaseURL: 'https://system1-d685d-default-rtdb.firebaseio.com',
    storageBucket: 'system1-d685d.appspot.com',
    measurementId: 'G-ZJWW0CM2SW',
  );
}