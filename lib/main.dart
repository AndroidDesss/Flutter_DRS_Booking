import 'package:drs_booking/authentication/view/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:io' as platform;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeFirebase();

  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: LoginScreen(),
  ));
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
          ],
        ),
      ),
    );
  }
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
