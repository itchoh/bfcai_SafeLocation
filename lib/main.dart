import 'package:bfcai_safe_zone/core/utils/app_shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Features/Map_Location/showMap.dart';
import 'Features/auth/login_screen.dart';
import 'Features/Notification/Local_Notification.dart';
import 'core/constant/Routes.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // SharedPreferences
  await AppPreference.initSharedPreference();

  // Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Local Notifications
  await LocalNotificationService.init();


  var userId = await AppPreference.getData("id");

  String initialRoute;
  if (userId == null) {
    //await AppPreference.saveData("id", false);
    initialRoute = LoginScreen.routeName;
  } else {
    //final userId = await AppPreference.getData("id");
    initialRoute=ShowMap.routeName ;
  }

  runApp(MyApp(routeName: initialRoute));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.routeName});
  final String routeName;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: routes,
      initialRoute: routeName,
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
