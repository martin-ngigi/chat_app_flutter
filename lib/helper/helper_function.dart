import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions{
  //keys
  static String userLoggedInKey = "LOGGEDINKEY";
  static String userNameInKey = "USERNAMEKEY";
  static String userEmailInKey = "USEREMAILKEY";

  //saving data to shared preferences

  //getting data from shared preferences
  static Future<bool?> getLoggedInStatus() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(userLoggedInKey);
  }
}