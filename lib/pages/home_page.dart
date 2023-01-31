import 'package:chat_app_flutter/pages/services/auth_services.dart';
import 'package:chat_app_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';

import 'auth/login_page.dart';

//stful
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthServices authServices = AuthServices();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Center(
          child: ElevatedButton(
            onPressed: (){
              authServices.signOut();
              nextScreenReplace(context, const LoginPage());
            },
            child: Text("LogOut"),
          ),
        ),
      ),
    );
  }
}
