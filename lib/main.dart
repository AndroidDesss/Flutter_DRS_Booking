import 'package:drs_booking/dashboard/dash_board_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:io' as platform;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeFirebase();

  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: DashBoardScreen(),
  ));
}

Future<void> initializeFirebase() async {
  if (platform.Platform.isAndroid) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyBPbYw5s8P_kxPIubxtXn0NA6y9urmntOY',
        appId: '1:1038272819558:android:de62e1fbd7b70a261958a7',
        messagingSenderId: '1038272819558',
        projectId: 'drs-booking',
      ),
    );
  } else if (platform.Platform.isIOS) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyBPbYw5s8P_kxPIubxtXn0NA6y9urmntOY',
        appId: '1:1038272819558:android:de62e1fbd7b70a261958a7',
        messagingSenderId: '1038272819558',
        projectId: 'drs-booking',
        iosBundleId: 'com.desss.drsBooking',
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
}
