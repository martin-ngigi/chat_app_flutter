import 'package:chat_app_flutter/pages/services/database_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices{

  //initialize
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  /**
   * LOGIN SERVICE
   */

  /**
   * REGISTER SERVICE
   */
  Future registerUserWithEmailAndPassword(String fullName, String email, String password) async{
    try{
      //create user
      User user = (await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password))
          .user!;

      //check
      if(user != null){
        //call our database service to update the user
        await DatabaseService(uid: user.uid).updateUserData(fullName, email);
        return true;
      }

    } on FirebaseAuthException catch (e){
      print("Firebase error has occurred. \nHint:${e.message}");
      return e.message;
    }
  }


  /**
   * SIGNOUT SERVICE
   */
}