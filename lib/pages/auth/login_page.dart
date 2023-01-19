import 'package:chat_app_flutter/pages/auth/register_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../widgets/widgets.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Theme.of(context).primaryColor,
      // ),
      body: SingleChildScrollView(
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

  login(){
    if(formKey.currentState!.validate()){

    }
  }
}
