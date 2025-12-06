import 'package:flutter/cupertino.dart';
import '../../Features/Map_Location/showMap.dart';
import '../../Features/auth/login_screen.dart';
import '../../Features/auth/registerScreen.dart';



Map<String,WidgetBuilder>routes={
LoginScreen.routeName: (context) => LoginScreen(),
RegisterScreen.routeName: (context) => RegisterScreen(),
ShowMap.routeName: (context) => ShowMap(),
};