import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Features/Map_Location/showMap.dart';
import 'Local_Notification.dart';
import 'core/constant/Routes.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalNotificationService.init();
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
      routes: routes,
      initialRoute: ShowMap.routeName,
    );
  }
}

// ---------------- PERMISSION REQUEST -------------------

// Future<void> requestNotificationPermission() async {
//   // Android 13+ & iOS
//   var status = await Permission.notification.status;
//
//   if (!status.isGranted) {
//     status = await Permission.notification.request();
//   }
//
//   if (status.isGranted) {
//     print("Notifications permission granted!");
//   } else {
//     print("Notifications permission denied.");
//   }
// }
