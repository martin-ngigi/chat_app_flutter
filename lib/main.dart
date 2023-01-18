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

  runApp(MaterialApp(
    home: MyApplication(),
  ));
}

class MyApplication extends StatelessWidget {
  const MyApplication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          title: Text("Chat app"),
          centerTitle: true,
          backgroundColor: Colors.green[600],
        ),
        body: Container(
          padding: EdgeInsets.all(3),
        ),
      ),
    );
  }
}



