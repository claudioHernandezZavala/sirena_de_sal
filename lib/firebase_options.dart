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
    apiKey: 'AIzaSyDrsri3HNgystFRpBFGHpU3XLPZXHAi7q8',
    appId: '1:301545994681:web:c868478a1174fdd3689e68',
    messagingSenderId: '301545994681',
    projectId: 'sirena-de-sal-99d8c',
    authDomain: 'sirena-de-sal-99d8c.firebaseapp.com',
    storageBucket: 'sirena-de-sal-99d8c.appspot.com',
    measurementId: 'G-8MTX4ZSTP9',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAcUmW2ysEkefEbTB-Q2Grx0t4hGq_qvJE',
    appId: '1:301545994681:android:9ffcb7414d428916689e68',
    messagingSenderId: '301545994681',
    projectId: 'sirena-de-sal-99d8c',
    storageBucket: 'sirena-de-sal-99d8c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBmx57EXAUd-xxtpWQ73aEXnmwZR8B3U0g',
    appId: '1:301545994681:ios:6390c8ddb2bd2151689e68',
    messagingSenderId: '301545994681',
    projectId: 'sirena-de-sal-99d8c',
    storageBucket: 'sirena-de-sal-99d8c.appspot.com',
    androidClientId: '301545994681-boq100alrughmvrgpub2fddk43kus5u3.apps.googleusercontent.com',
    iosClientId: '301545994681-bvqu7vditsacaocp8jpkb28p7o2ee2nj.apps.googleusercontent.com',
    iosBundleId: 'com.example.sirenaDeSal',
  );
}
