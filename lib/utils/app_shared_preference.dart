import 'package:shared_preferences/shared_preferences.dart';
abstract class AppPreference{
  static late SharedPreferences prefs;
  static Future<void> initSharedPreference()async{
    prefs = await SharedPreferences.getInstance();
  }
  static Future<void> saveData(String key,dynamic value)async{
    if(value is String){
      await prefs.setString(key,value);
    }else if(value is int){
      await prefs.setInt(key,value);
    }else if(value is bool){
      await prefs.setBool(key,value);
    }else if(value is double){
      await prefs.setDouble(key,value);
    }else {
      print("Unsupported type");
    }
  }
  static Future<Object?>getData(String key)async{
      return prefs.get(key);
    }
  static Future<void>removeData(String key)async{
      await prefs.remove(key);
    }

}