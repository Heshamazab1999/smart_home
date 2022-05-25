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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBQ_LwSAgnZKgJUcR7X59DkwecyQgvRjhU',
    appId: '1:103557218323:web:383ec0156dca7f7806ffe6',
    messagingSenderId: '103557218323',
    projectId: 'iot-cloud-cw2',
    authDomain: 'iot-cloud-cw2.firebaseapp.com',
    databaseURL: 'https://iot-cloud-cw2-default-rtdb.firebaseio.com',
    storageBucket: 'iot-cloud-cw2.appspot.com',
    measurementId: 'G-TFNJ16NJP7',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCkpHxU2U3d6-2fOxefoWAgqNCErQ0YKm8',
    appId: '1:103557218323:android:ddded99bd678ec9506ffe6',
    messagingSenderId: '103557218323',
    projectId: 'iot-cloud-cw2',
    databaseURL: 'https://iot-cloud-cw2-default-rtdb.firebaseio.com',
    storageBucket: 'iot-cloud-cw2.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBMVWWTKMPK6DT5OevZu_Tk6bAiO37CxSY',
    appId: '1:103557218323:ios:b51c5dab3b102bfe06ffe6',
    messagingSenderId: '103557218323',
    projectId: 'iot-cloud-cw2',
    databaseURL: 'https://iot-cloud-cw2-default-rtdb.firebaseio.com',
    storageBucket: 'iot-cloud-cw2.appspot.com',
    iosClientId: '103557218323-9b984ndauilgdq56dcbgeqqn6n1j167q.apps.googleusercontent.com',
    iosBundleId: 'com.mpdev.smartHome',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBMVWWTKMPK6DT5OevZu_Tk6bAiO37CxSY',
    appId: '1:103557218323:ios:b51c5dab3b102bfe06ffe6',
    messagingSenderId: '103557218323',
    projectId: 'iot-cloud-cw2',
    databaseURL: 'https://iot-cloud-cw2-default-rtdb.firebaseio.com',
    storageBucket: 'iot-cloud-cw2.appspot.com',
    iosClientId: '103557218323-9b984ndauilgdq56dcbgeqqn6n1j167q.apps.googleusercontent.com',
    iosBundleId: 'com.mpdev.smartHome',
  );
}
