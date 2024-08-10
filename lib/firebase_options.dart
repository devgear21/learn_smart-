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
    apiKey: 'AIzaSyC4oDoll_G5j0gJZfjprnTOy3O9-N31rE8',
    appId: '1:233048685225:web:6910e6c06d19b2b7cf47b8',
    messagingSenderId: '233048685225',
    projectId: 'learnsmart-ce842',
    authDomain: 'learnsmart-ce842.firebaseapp.com',
    storageBucket: 'learnsmart-ce842.appspot.com',
    measurementId: 'G-LZZN1J54PY',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAQZq7YJcyGtqzq0OliJXREs4NSVjAC9vw',
    appId: '1:233048685225:android:0e614ca4c4505238cf47b8',
    messagingSenderId: '233048685225',
    projectId: 'learnsmart-ce842',
    storageBucket: 'learnsmart-ce842.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDu-O5k_cLPpcWeJPjhIweDvITYF3r7XZQ',
    appId: '1:233048685225:ios:fb93996693bd9f61cf47b8',
    messagingSenderId: '233048685225',
    projectId: 'learnsmart-ce842',
    storageBucket: 'learnsmart-ce842.appspot.com',
    iosBundleId: 'com.example.learnsmart',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDu-O5k_cLPpcWeJPjhIweDvITYF3r7XZQ',
    appId: '1:233048685225:ios:fb93996693bd9f61cf47b8',
    messagingSenderId: '233048685225',
    projectId: 'learnsmart-ce842',
    storageBucket: 'learnsmart-ce842.appspot.com',
    iosBundleId: 'com.example.learnsmart',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyC4oDoll_G5j0gJZfjprnTOy3O9-N31rE8',
    appId: '1:233048685225:web:d0f072c18ec9d2cdcf47b8',
    messagingSenderId: '233048685225',
    projectId: 'learnsmart-ce842',
    authDomain: 'learnsmart-ce842.firebaseapp.com',
    storageBucket: 'learnsmart-ce842.appspot.com',
    measurementId: 'G-GL14T098QK',
  );
}
