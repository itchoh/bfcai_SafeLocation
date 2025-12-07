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

  await AppPreference.initSharedPreference();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await LocalNotificationService.init();


  var userId = await AppPreference.getData("id");

  String initialRoute;
  if (userId == null) {
    initialRoute = LoginScreen.routeName;
  } else {
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
