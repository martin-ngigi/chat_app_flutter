import 'package:chat_app_flutter/helper/helper_function.dart';
import 'package:chat_app_flutter/pages/auth/login_page.dart';
import 'package:chat_app_flutter/pages/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:chat_app_flutter/shared/constants.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();


  //condition to check the where the plaltform the app is running in i.e. android, web, iOS
  if(kIsWeb){
    //run initialization for web
    await Firebase.initializeApp(options: FirebaseOptions(
        apiKey: Constants.apiKey,
        appId: Constants.appId,
        messagingSenderId: Constants.messagingSenderId,
        projectId: Constants.projectId
    ));
  }
  else{
    //run initialization for iOS and android
    await Firebase.initializeApp();
  }

  runApp( const MyApplication(),);
}

class MyApplication extends StatefulWidget {
  const MyApplication({Key? key}) : super(key: key);

  @override
  State<MyApplication> createState() => _MyApplicationState();
}

class _MyApplicationState extends State<MyApplication> {
  bool _isSignedIn = false;

  @override
  void initState() {
    super.initState();
    getUserLoggedInStatus();
  }

  void getUserLoggedInStatus() async{
    await HelperFunctions.getLoggedInStatus().then((value) => (value){
      if(value != null){
        _isSignedIn = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Constants().primaryColor,
        scaffoldBackgroundColor: Colors.white
      ),
      debugShowCheckedModeBanner: false,
      home: _isSignedIn? HomePage() : LoginPage(), // if signed in show HomePage else LoginPage
    );
  }


}



