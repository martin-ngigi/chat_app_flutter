import 'package:chat_app_flutter/pages/home_page.dart';
import 'package:chat_app_flutter/pages/services/auth_services.dart';
import 'package:flutter/material.dart';

import '../widgets/widgets.dart';
import 'auth/login_page.dart';

//stful
class ProfilePage extends StatefulWidget {
  String userName;
  String email;


  ProfilePage({Key? key, required this.email, required this.userName}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  AuthServices authServices = AuthServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        title:const Text(
          "Profile",
          style: TextStyle(
            color: Colors.white,
            fontSize: 27,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 50),
          children: [
            Icon(
              Icons.account_circle,
              size: 150,
              color: Colors.grey[700],
            ),
            const SizedBox(height: 15,),
            Text(
              widget.userName,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30,),
            const Divider(
              height: 2,
            ),
            ListTile(
              onTap: (){
                nextScreen(context, const HomePage());
              },

              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              leading: const Icon( Icons.group),
              title: const Text(
                "Groups",
                style: TextStyle(color: Colors.black),
              ),
            ),
            ListTile(
              onTap: (){

              },
              selected: true,
              selectedColor: Theme.of(context).primaryColor,
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              leading: const Icon( Icons.person),
              title: const Text(
                "Profile",
                style: TextStyle(color: Colors.black),
              ),
            ),
            ListTile(
              onTap: () async{
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context){
                    return AlertDialog(
                      title: Text("Logout"),
                      content: Text("Are you sure you want to logout."),
                      actions: [
                        IconButton(
                            onPressed: (){
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.cancel,
                              color: Colors.red,
                            )),
                        IconButton(
                            onPressed: () async {
                              await authServices.signOut();
                              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=> LoginPage()), (route) => false);
                            },
                            icon: const Icon(
                              Icons.done,
                              color: Colors.green,
                            )),

                      ],
                    );
                  },
                );
                // authServices.signOut().whenComplete((){
                //   nextScreenReplace(context, const LoginPage());
                // });
              },
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              leading: const Icon( Icons.exit_to_app),
              title: const Text(
                "Logout",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 170),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.account_circle,
              size: 200,
              color: Colors.grey,
            ),
            SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Full name", style: TextStyle(fontSize: 17),),
                Text(widget.userName, style: TextStyle(fontSize: 17),),

              ],
            ),
            Divider(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Email", style: TextStyle(fontSize: 17),),
                Text(widget.email, style: TextStyle(fontSize: 17),),

              ],
            ),


          ],
        ),
      ),

    );
  }
}
