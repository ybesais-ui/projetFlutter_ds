// File: lib/firebase_options.dart
import 'package:firebase_core/firebase_core.dart';
/*
Remplacer les valeurs par celles de ton google-services.json :
current_key → apiKey
mobilesdk_app_id → appId
project_id → projectId
storage_bucket → storageBucket
project_number → messagingSenderId*/

class DefaultFirebaseOptions {
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAgEBEWR2dWfPYp8LKyNBVfKBQ_O4Bwan',
    appId: '1:291110879650:android:847bebcc715620e80eb2fb',
    messagingSenderId: '291110879650',
    projectId: 'projetflutterds',
    storageBucket: 'projetflutterds.firebasestorage.app',
  );

  static FirebaseOptions get currentPlatform {
    return android;
  }
}