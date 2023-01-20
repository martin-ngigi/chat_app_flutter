import 'package:chat_app_flutter/pages/auth/login_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../widgets/widgets.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  String fullName = "";
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
                  "Create your account now to chat and explore.",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                ),
                Image.asset("assets/register.png"),
                TextFormField(
                  //decoration: textInputDecoration, //also works
                  decoration: textInputDecoration.copyWith(
                    labelText: "Full Name",
                    prefixIcon: Icon(
                      Icons.person,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  onChanged: (val){
                    setState(() {
                      fullName = val;
                      print("Name: Hello i am here ${fullName}");
                    });
                  },

                  // check tha validation
                  validator: (val) {
                    if(val!.isNotEmpty){
                      return null;
                    }
                    else{
                      "Name cannot be empty";
                    }
                  },
                ),
                SizedBox(height: 10,),
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
                      register();
                    },
                    child: Text(
                      "Register",
                      style: TextStyle(
                        color: Colors.white, fontSize: 16,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),  //for vertical spacing
                Text.rich(
                    TextSpan(
                      text: "Already have an account?",
                      style: TextStyle(color: Colors.black, fontSize: 14),
                      children: [
                        TextSpan(
                            text: " Login",
                            style: TextStyle(
                                color: Colors.green,
                                decoration: TextDecoration.underline
                            ),
                            recognizer: TapGestureRecognizer()..onTap = (){
                              nextScreen(context, LoginPage());
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

  register(){

  }
}
