import 'package:chat_app_flutter/helper/helper_function.dart';
import 'package:chat_app_flutter/pages/auth/register_page.dart';
import 'package:chat_app_flutter/pages/services/auth_services.dart';
import 'package:chat_app_flutter/pages/services/database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/widgets.dart';
import '../home_page.dart';

//stful
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //initialize
  final formKey =  GlobalKey<FormState>();
  String email = "";
  String password = "";
  AuthServices authService = AuthServices();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Theme.of(context).primaryColor,
      // ),
      body:_isLoading? Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor,),): SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 80),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                    "Groupie App",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10,),  //for vertical spacing
                Text(
                    "Login now to see what they are talking...",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                ),
                Image.asset("assets/login.png"),
                TextFormField(
                  //decoration: textInputDecoration, //also works
                    decoration: textInputDecoration.copyWith(
                    labelText: "Email",
                    prefixIcon: Icon(
                      Icons.email,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  onChanged: (val){
                    setState(() {
                      email = val;
                      print("Email: Hello i am here ${email}");
                    });
                  },

                  // check tha validation
                  validator: (val) {
                    return RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(val!)
                        ? null
                        : "Please enter a valid email";
                  },
                ),
                SizedBox(height: 10,),  //for vertical spacing
                TextFormField(
                  //decoration: textInputDecoration, //also works
                  decoration: textInputDecoration.copyWith(
                    labelText: "Password",
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                    onChanged: (val){
                      setState(() {
                        password = val;
                        print("Password: Hello i am here ${password}");
                      });
                    },

                  //validate email
                  validator: (val){
                    if(val!.length < 6){
                      return "Password must be at least 6 characters.";
                    }
                    else{
                      return null;
                    }
                  },

                ),
                SizedBox(height: 20,),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)
                      ),
                    ),
                    onPressed: (){
                        login();
                    },
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                        color: Colors.white, fontSize: 16,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),  //for vertical spacing
                Text.rich(
                  TextSpan(
                    text: "Dont have an account?",
                    style: TextStyle(color: Colors.black, fontSize: 14),
                      children: [
                        TextSpan(
                          text: " Register here",
                          style: TextStyle(
                            color: Colors.green,
                            decoration: TextDecoration.underline
                          ),
                          recognizer: TapGestureRecognizer()..onTap = (){
                            nextScreen(context, RegisterPage());
                          }
                        )
                      ],
                )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  login() async {
    if(formKey.currentState!.validate()){
      setState(() {
        _isLoading = true;
      });
      await authService
          .loginWithUsernameAndPassword( email, password)
          .then((value) async {
        if(value == true){
          
          QuerySnapshot snapshot =  await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid).gettingUserData(email);
          //saving values to shared preferences
          await HelperFunctions.savedUserLoggedInState(true);
          await HelperFunctions.savedUserEmailSF(email);
          await HelperFunctions.savedUserNameSF(snapshot.docs[0]['fullName']);

          showSnackBar(context, Colors.green,  "Login Successfully.",);

           nextScreenReplace(context, const HomePage());
        }
        else{
          showSnackBar(context, Colors.red,  value.toString(),);
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
  }
}
