import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyBoAYP69PnFFq5xOmN458zThzPAhepVfho',
    appId: '1:327512390031:web:064dd0c5873cd2445673fa',
    messagingSenderId: '327512390031',
    projectId: 'intimeapp-99a1e',
    authDomain: 'intimeapp-99a1e.firebaseapp.com',
    databaseURL: 'https://intimeapp-99a1e-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'intimeapp-99a1e.appspot.com',
    measurementId: 'G-BH7YPLFGYP',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAKb6IN14tQ8LXL2z4DSzfPriOMIM9CAVE',
    appId: '1:119144793422:android:a25b0a9908999d9a1f8a1f',
    messagingSenderId: '119144793422',
    projectId: 'codelab1-cc14d',
    storageBucket: 'codelab1-cc14d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC7egYVX8sLTdkXemHsU6ct26xE-luhxJU',
    appId: '1:327512390031:ios:75626740ecff07345673fa',
    messagingSenderId: '327512390031',
    projectId: 'intimeapp-99a1e',
    databaseURL: 'https://intimeapp-99a1e-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'intimeapp-99a1e.appspot.com',
    iosClientId: '327512390031-u8te8ee4cmbj92lh18bg9tipj8kkhbgf.apps.googleusercontent.com',
    iosBundleId: 'com.example.callAja',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC7egYVX8sLTdkXemHsU6ct26xE-luhxJU',
    appId: '1:327512390031:ios:75626740ecff07345673fa',
    messagingSenderId: '327512390031',
    projectId: 'intimeapp-99a1e',
    databaseURL: 'https://intimeapp-99a1e-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'intimeapp-99a1e.appspot.com',
    iosClientId: '327512390031-u8te8ee4cmbj92lh18bg9tipj8kkhbgf.apps.googleusercontent.com',
    iosBundleId: 'com.example.callAja',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBoAYP69PnFFq5xOmN458zThzPAhepVfho',
    appId: '1:327512390031:web:95ea850c20ffa7675673fa',
    messagingSenderId: '327512390031',
    projectId: 'intimeapp-99a1e',
    authDomain: 'intimeapp-99a1e.firebaseapp.com',
    databaseURL: 'https://intimeapp-99a1e-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'intimeapp-99a1e.appspot.com',
    measurementId: 'G-BY60KW6WFX',
  );
}