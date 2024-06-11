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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCQQWLIY56mWCiXV5c1X0tmwRCRXaHqhp4',
    appId: '1:582976896717:web:44e38ec5a18fdf238f7384',
    messagingSenderId: '582976896717',
    projectId: 'workflow-management-app-9ecb1',
    authDomain: 'workflow-management-app-9ecb1.firebaseapp.com',
    storageBucket: 'workflow-management-app-9ecb1.appspot.com',
    measurementId: 'G-KVMYXH6CMP',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBNu3D1c_BJihZZo7-ra-rdPL32WEIR2hk',
    appId: '1:582976896717:android:332f04312a4e98138f7384',
    messagingSenderId: '582976896717',
    projectId: 'workflow-management-app-9ecb1',
    storageBucket: 'workflow-management-app-9ecb1.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDKo9lzhtbcDhfcBtJqrLG_YBGEizx-IzI',
    appId: '1:582976896717:ios:140bb3a28c0d38c88f7384',
    messagingSenderId: '582976896717',
    projectId: 'workflow-management-app-9ecb1',
    storageBucket: 'workflow-management-app-9ecb1.appspot.com',
    androidClientId: '582976896717-p37jgks2lj3r9jdm0qdn0tne8h8d028b.apps.googleusercontent.com',
    iosClientId: '582976896717-p3ikp5paspdc1p9omk1o0g48bt1t8o9t.apps.googleusercontent.com',
    iosBundleId: 'com.example.workflowManagementApp',
  );

}