import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoogleSignInProvider extends ChangeNotifier {


  static final String _tokenKey = 'auth_token';

 
    Future logOut() async {
      GoogleSignIn().signOut();
      FirebaseAuth.instance.signOut();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove(_tokenKey);
    }

    Future logOutEmail() async {
      FirebaseAuth.instance.signOut();
      GoogleSignIn().signOut();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove(_tokenKey);
    }
  }

