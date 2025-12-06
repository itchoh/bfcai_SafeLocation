
import 'package:flutter/cupertino.dart';
import '../auth/login_screen.dart';
import '../auth/registerScreen.dart';
import '../showMap.dart';


Map<String,WidgetBuilder>routes={
LoginScreen.routeName: (context) => LoginScreen(),
RegisterScreen.routeName: (context) => RegisterScreen(),
ShowMap.routeName: (context) => ShowMap(),
};