import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class connect {
  static Future<bool> isConnect() async {
    final result = await Connectivity().checkConnectivity();
    return result != ConnectivityResult.none;
  }
}

class AuthManager {
  static final String _tokenKey = 'auth_token';
  static Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey) != null;
  }

  static Future<void> logIn(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_tokenKey, token);
  }

  static Future<void> logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(_tokenKey);
  }
}

class Auth with ChangeNotifier {
  String _idToken = 'your_initialized_value';
  String userId = 'your_initialized_value';
  String _tempidToken = 'your_initialized_value';
  String tempuserId = 'your_initialized_value';
  DateTime _expiryDate = DateTime.now();
  DateTime _tempexpiryDate = DateTime.now();

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_expiryDate.isAfter(DateTime.now())) {
      return _idToken;
    } else {
      return '';
    }
  }
}

class postRDB with ChangeNotifier {
  Future<void> posted(String? idToken, String? name, String? email, String? id,
      String? photoUrl) async {
    String uriMaster = "https://whatswants-387da-default-rtdb.firebaseio.com/";

    Uri url = Uri.parse("$uriMaster/googleSignIn.json");
    DateTime dateNow = DateTime.now();

    try {
      var response = await http.post(
        url,
        body: json.encode({
          'token': idToken,
          'id': id,
          'full_name': name,
          'email': email,
          'photoURL': photoUrl,
          "createdAt": dateNow.toString(),
          "updatedAt": dateNow.toString(),
        }),
      );
      var responseData = json.decode(response.body);
    } catch (err) {
      throw (err);
    }
  }
}

class AuthServices {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<SignInSignUpResult> createUser(
      {required String email, required String pass}) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: pass);
      return SignInSignUpResult(user: result.user, message: '');
    } catch (e) {
      return SignInSignUpResult(message: e.toString());
    }
  }

  static Future<SignInSignUpResult> signInWithEmail(
      {required String email, required String pass}) async {
    try {
      UserCredential result =
          await _auth.signInWithEmailAndPassword(email: email, password: pass);
      return SignInSignUpResult(user: result.user, message: '');
    } catch (e) {
      return SignInSignUpResult(message: e.toString());
    }
  }

  void signOut() {
    _auth.signOut();
  }

  static GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: ['email', 'https://www.googleapis.com/auth/contacts.readonly'],
  );

  static Future<SignInSignUpResult> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);
      final UserCredential result =
          await _auth.signInWithCredential(credential);
      return SignInSignUpResult(user: result.user, message: '');
    } catch (e) {
      return SignInSignUpResult(message: e.toString());
    }
  }

  static Future<void> signOutGoogle() async {
    await googleSignIn.signOut();
  }
}

class SignInSignUpResult {
  final User? user;
  final String message;
  SignInSignUpResult({this.user, required this.message});
}

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final db = FirebaseFirestore.instance;

  Future<String> signUpUser({
    required String? name,
    required String? email,
    required String? password,
  }) async {
    String result = 'Some error occurred';
    try {
      if (email!.isNotEmpty || name!.isNotEmpty || password!.isNotEmpty) {
        UserCredential user = await _auth.createUserWithEmailAndPassword(
            email: email, password: password!);
        print(user.user!.uid);

        UserModel userModel = UserModel(
          email: email,
          name: name!,
          uid: user.user!.uid,
        );

        await _firestore.collection('usersRegister').doc(user.user!.uid).set(
              userModel.toJson(),
            );

        db
            .collection('allUsers')
            .doc(user.user!.uid)
            .collection('datas')
            .doc()
            .set({
          'name': name,
          'email': email,
        });

        String urlMaster =
            "https://whatswants-387da-default-rtdb.firebaseio.com/";

        Uri url = Uri.parse("$urlMaster/task_Tuesday.json");
        DateTime dateNow = DateTime.now();
        try {
          var response = await http.post(
            url,
            body: json.encode({
              "userId": user.user!.uid,
              "email": email,
              "name": name,
              "createdAt": dateNow.toString(),
              "updatedAt": dateNow.toString(),
            }),
          );
        } catch (err) {
          throw (err);
        }

        db
            .collection('statsSch')
            .doc(user.user!.uid)
            .collection("datas")
            .doc("Sunday")
            .set({'data': 0, 'day': 'Sunday'});
        db
            .collection('statsSch')
            .doc(user.user!.uid)
            .collection("datas")
            .doc("Monday")
            .set({'data': 0, 'day': 'Monday'});
        db
            .collection('statsSch')
            .doc(user.user!.uid)
            .collection("datas")
            .doc("Tuesday")
            .set({'data': 0, 'day': 'Tuesday'});
        db
            .collection('statsSch')
            .doc(user.user!.uid)
            .collection("datas")
            .doc("Wednesday")
            .set({'data': 0, 'day': 'Wednesday'});
        db
            .collection('statsSch')
            .doc(user.user!.uid)
            .collection("datas")
            .doc("Thursday")
            .set({'data': 0, 'day': 'Thursday'});
        db
            .collection('statsSch')
            .doc(user.user!.uid)
            .collection("datas")
            .doc("Friday")
            .set({'data': 0, 'day': 'Friday'});
        db
            .collection('statsSch')
            .doc(user.user!.uid)
            .collection("datas")
            .doc("Saturday")
            .set({'data': 0, 'day': 'Saturday'});

        result = 'success';
      }
    } catch (err) {
      result = err.toString();
    }
    return result;
  }

  Future<String> logInUser({
    required String email,
    required String password,
  }) async {
    String result = 'Some error occurred';
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        result = 'success';
      }
    } catch (err) {
      result = err.toString();
    }
    return result;
  }
}

class UserModel {
  final String email;
  final String name;
  final String uid;

  UserModel({
    required this.email,
    required this.name,
    required this.uid,
  });

  Map<String, dynamic> toJson() => {
        "email": email,
        "uid": uid,
        "name": name,
      };

  static UserModel? fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserModel(
      uid: snapshot['uid'],
      name: snapshot['name'],
      email: snapshot['email'],
    );
  }
}
