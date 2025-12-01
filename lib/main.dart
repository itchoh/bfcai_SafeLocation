import 'package:bfcai_safe_zone/Add_Polygon.dart';
import 'package:bfcai_safe_zone/showMap.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'auth/login_screen.dart';
import 'auth/registerScreen.dart';
import 'data/firebase/firebase_auth.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

// Ideal time to initialize
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );//...
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          LoginScreen.routeName: (context)=> LoginScreen(),
          RegisterScreen.routeName: (context)=> RegisterScreen(),
          ShowMap.routeName:(context)=>ShowMap(),
          //AddPolygon.routeName:(context)=>AddPolygon(position: null, mapController: null,),
          //AddCircle.routeName:(context)=>ShowMap(),
        },
      initialRoute: LoginScreen.routeName,

      );
  }
}
