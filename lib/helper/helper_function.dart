import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions{
  //keys
  static String userLoggedInKey = "LOGGEDINKEY";
  static String userNameInKey = "USERNAMEKEY";
  static String userEmailInKey = "USEREMAILKEY";

  //saving data to shared preferences
  static Future<bool> savedUserLoggedInState(bool isUserLoggedIn) async{
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setBool(userLoggedInKey, isUserLoggedIn);
  }

  static Future<bool> savedUserNameSF(String userName) async{
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userNameInKey, userName);
  }

  static Future<bool> savedUserEmailSF(String userEmail) async{
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userEmailInKey, userEmail);
  }

  //getting data from shared preferences
  static Future<bool?> getLoggedInStatus() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(userLoggedInKey);
  }
}