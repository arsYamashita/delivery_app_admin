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
    apiKey: 'AIzaSyCDPKVblnyIqAm1NJjKrMfPKuUbWkTmURM',
    appId: '1:158728980101:web:647b959b1461733fc4cbec',
    messagingSenderId: '158728980101',
    projectId: 'deliveryapptest-18806',
    authDomain: 'deliveryapptest-18806.firebaseapp.com',
    storageBucket: 'deliveryapptest-18806.firebasestorage.app',
    measurementId: 'G-HDQS0P11RV',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB47KeXgjkFKQhNAhC7Od74g7bCyfpUKEY',
    appId: '1:158728980101:android:4dbabff177ace2c1c4cbec',
    messagingSenderId: '158728980101',
    projectId: 'deliveryapptest-18806',
    storageBucket: 'deliveryapptest-18806.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDqmd6pan92IOVhAzwAdMMrFZfh-Pq_nV4',
    appId: '1:158728980101:ios:792478619be794c2c4cbec',
    messagingSenderId: '158728980101',
    projectId: 'deliveryapptest-18806',
    storageBucket: 'deliveryapptest-18806.firebasestorage.app',
    iosBundleId: 'com.arscube.deliveryAppAdmin',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDqmd6pan92IOVhAzwAdMMrFZfh-Pq_nV4',
    appId: '1:158728980101:ios:792478619be794c2c4cbec',
    messagingSenderId: '158728980101',
    projectId: 'deliveryapptest-18806',
    storageBucket: 'deliveryapptest-18806.firebasestorage.app',
    iosBundleId: 'com.arscube.deliveryAppAdmin',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCDPKVblnyIqAm1NJjKrMfPKuUbWkTmURM',
    appId: '1:158728980101:web:468b868498249363c4cbec',
    messagingSenderId: '158728980101',
    projectId: 'deliveryapptest-18806',
    authDomain: 'deliveryapptest-18806.firebaseapp.com',
    storageBucket: 'deliveryapptest-18806.firebasestorage.app',
    measurementId: 'G-5BML7B3RF8',
  );
}