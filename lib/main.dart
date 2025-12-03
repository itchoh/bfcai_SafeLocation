import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:permission_handler/permission_handler.dart';

import 'Local_Notification.dart';
import 'auth/login_screen.dart';
import 'auth/registerScreen.dart';
import 'firebase_options.dart';
import 'package:bfcai_safe_zone/showMap.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Request notification permission (Android 13+ + iOS)
  await requestNotificationPermission();

  // Initialize local notifications
  await LocalNotificationService.init();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        LoginScreen.routeName: (context) => LoginScreen(),
        RegisterScreen.routeName: (context) => RegisterScreen(),
        ShowMap.routeName: (context) => ShowMap(),
      },
      initialRoute: ShowMap.routeName,
    );
  }
}

// ---------------- PERMISSION REQUEST -------------------

Future<void> requestNotificationPermission() async {
  // Android 13+ & iOS
  var status = await Permission.notification.status;

  if (!status.isGranted) {
    status = await Permission.notification.request();
  }

  if (status.isGranted) {
    print("Notifications permission granted!");
  } else {
    print("Notifications permission denied.");
  }
}
