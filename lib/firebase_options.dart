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
    apiKey: 'AIzaSyANDkwZsiU9sAOdfYl1unssljllaKK7g6U',
    appId: '1:217825787335:web:4b419ffe8a762db2872de2',
    messagingSenderId: '217825787335',
    projectId: 'sky-ecommerce-app-c5e87',
    authDomain: 'sky-ecommerce-app-c5e87.firebaseapp.com',
    storageBucket: 'sky-ecommerce-app-c5e87.appspot.com',
    measurementId: 'G-1JQBN4F210',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAS0PrqOXP34wkSIF0g1JSUocc9hhm4ViY',
    appId: '1:217825787335:android:22759c1bb9d65f95872de2',
    messagingSenderId: '217825787335',
    projectId: 'sky-ecommerce-app-c5e87',
    storageBucket: 'sky-ecommerce-app-c5e87.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDKcoKIru9S0tEWPjaBcfAE2Kg4n0fab5Y',
    appId: '1:217825787335:ios:ca8fffcc3dcdfa1e872de2',
    messagingSenderId: '217825787335',
    projectId: 'sky-ecommerce-app-c5e87',
    storageBucket: 'sky-ecommerce-app-c5e87.appspot.com',
    iosBundleId: 'com.example.ecommerceApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDKcoKIru9S0tEWPjaBcfAE2Kg4n0fab5Y',
    appId: '1:217825787335:ios:d2380b31e09b84ad872de2',
    messagingSenderId: '217825787335',
    projectId: 'sky-ecommerce-app-c5e87',
    storageBucket: 'sky-ecommerce-app-c5e87.appspot.com',
    iosBundleId: 'com.example.ecommerceApp.RunnerTests',
  );
}
