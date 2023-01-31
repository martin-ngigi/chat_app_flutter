import 'package:chat_app_flutter/helper/helper_function.dart';
import 'package:chat_app_flutter/pages/services/database_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices{

  //initialize
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  /**
   * LOGIN SERVICE
   */
  Future loginWithUsernameAndPassword( String email, String password) async{
    try{
      //create user
      User user = (await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password))
          .user!;

      //check
      if(user != null){
        return true;
      }

    } on FirebaseAuthException catch (e){
      print("Firebase error has occurred. \nHint:${e.message}");
      return e.message;
    }
  }


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
        await DatabaseService(uid: user.uid).savingUserData(fullName, email);
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
  Future signOut() async{
    try{
      await HelperFunctions.savedUserLoggedInState(false);
      await HelperFunctions.savedUserEmailSF("");
      await HelperFunctions.savedUserNameSF("");
      await firebaseAuth.signOut();
    }
    catch(e){
      print("Sign Out Error: ${e}");
      return null;
    }
  }
}