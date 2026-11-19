import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart'
    show Firebase, FirebaseOptions;
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:whatswant/assets/Colors/colors.dart';
import 'package:whatswant/contents/Navigation/bottomNavBar_page.dart';
import 'package:whatswant/contents/auth/register_page.dart';
import 'package:whatswant/contents/provider/auth.dart';
import 'package:whatswant/main.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class LoginPage extends StatefulWidget {
  LoginPage();

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  final logemailController = TextEditingController();

  final logpasswordController = TextEditingController();

  final db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  bool isSignIn = false;

  bool google = false;

  Stream<QuerySnapshot<Map<String, dynamic>>> dbRegist =
      FirebaseFirestore.instance.collection("registerUser").snapshots();

  User? user = FirebaseAuth.instance.currentUser;

  var jam = 'JAM';
  var count = 0;

  void countStream() {
    setState(() {
      count++;
    });
  }

  bool check = false;
  void startJam() {
    Timer.periodic(new Duration(seconds: 1), (_) {
      var tgl = new DateTime.now();
      var formatedjam = new DateFormat.Hms().format(tgl);
    });
  }

  final controller = PageController();

  int docCountSun = 0;
  int docCountMon = 0;
  int docCountTues = 0;
  int docCountWednes = 0;
  int docCountThurs = 0;
  int docCountFri = 0;
  int docCountSatur = 0;
  @override
  void initState() {
    startJam();
    countStream();
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            width: MediaQuery.sizeOf(context).width * 0.9,
            height: MediaQuery.sizeOf(context).height * 0.2,
            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(1000)),
                color: Color.fromARGB(255, 212, 212, 212)),
          ),
          Container(
            width: MediaQuery.sizeOf(context).width * 0.85,
            height: MediaQuery.sizeOf(context).height * 0.2,
            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(1000)),
                color: Color.fromARGB(255, 0, 35, 65)),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: PageView(
                controller: controller,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /*TITLE*/
                      Padding(
                        padding: const EdgeInsets.only(left: 40.0),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Welcome Back',
                                style: GoogleFonts.roboto(
                                    textStyle: TextStyle(
                                        color: white,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold)),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                      /*TITLE*/

                      // FORM LOGIN

                      Column(
                        children: [
                          Container(
                            margin:
                                EdgeInsets.only(left: 40, right: 40, top: 60),
                            child: Column(children: [
                              Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    /*EMAIL*/
                                    SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: Column(
                                        children: [
                                          SingleChildScrollView(
                                            child: Center(
                                              child: Container(
                                                padding: EdgeInsets.only(
                                                    top: 5.0,
                                                    left: 10.0,
                                                    bottom: 5.0,
                                                    right: 10.0),
                                                child: TextFormField(
                                                    style: GoogleFonts.roboto(
                                                        textStyle: TextStyle(
                                                            color: black)),
                                                    controller:
                                                        logemailController,
                                                    decoration: InputDecoration(
                                                        fillColor: Color.fromARGB(
                                                            255, 255, 255, 255),
                                                        hoverColor: black,
                                                        hintText:
                                                            "Enter Your Email",
                                                        filled: true,
                                                        hintStyle: TextStyle(
                                                            color: Color.fromARGB(
                                                                255,
                                                                187,
                                                                187,
                                                                187)),
                                                        focusColor: red,
                                                        icon: const Icon(
                                                          Icons.mail,
                                                          color: black,
                                                        ),
                                                        enabledBorder:
                                                            UnderlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .white))),
                                                    onSaved: (value) {
                                                      logemailController.text =
                                                          value!;
                                                    },
                                                    keyboardType: TextInputType
                                                        .emailAddress,
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return 'Email Is Required';
                                                      } else if (!value
                                                          .contains('@')) {
                                                        return 'Email Tidak Valid';
                                                      }
                                                      return null;
                                                    }),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    /*EMAIL*/

                                    /*PASSWORD*/
                                    Container(
                                      margin: EdgeInsets.only(top: 40.0),
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        child: Column(
                                          children: [
                                            SingleChildScrollView(
                                              padding:
                                                  EdgeInsets.only(top: 9.0),
                                              child: Center(
                                                child: Container(
                                                  padding: EdgeInsets.only(
                                                      top: 5.0,
                                                      left: 10.0,
                                                      bottom: 5.0,
                                                      right: 10.0),
                                                  child: TextFormField(
                                                      style: GoogleFonts.roboto(
                                                          textStyle: TextStyle(
                                                              color: black)),
                                                      controller:
                                                          logpasswordController,
                                                      decoration:
                                                          InputDecoration(
                                                        fillColor:
                                                            Color.fromARGB(255,
                                                                255, 255, 255),
                                                        enabledBorder:
                                                            UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          255,
                                                                          255,
                                                                          255)),
                                                        ),
                                                        hoverColor: black,
                                                        filled: true,
                                                        hintText:
                                                            "Enter Your Password",
                                                        hintStyle: TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    187,
                                                                    187,
                                                                    187)),
                                                        focusColor: red,
                                                        icon: const Icon(
                                                          Icons.password,
                                                          color: black,
                                                        ),
                                                        border: UnderlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        6.0),
                                                            borderSide: BorderSide(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        187,
                                                                        187,
                                                                        187))),
                                                      ),
                                                      onSaved: (value) {
                                                        logpasswordController
                                                            .text = value!;
                                                      },
                                                      keyboardType:
                                                          TextInputType
                                                              .visiblePassword,
                                                      obscureText: true,
                                                      validator: (value) {
                                                        if (value!.isEmpty) {
                                                          return 'Password Is Required';
                                                        } else if (value
                                                                .length <
                                                            8) {
                                                          return 'Password Must Be 8 Character';
                                                        }
                                                        return null;
                                                      }),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    /*PASSWORD*/
                                  ],
                                ),
                              ),

                              /*FORGOT PASSWORD*/
                              Container(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  child: TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      'Forgot Password ?',
                                      style: GoogleFonts.roboto(
                                        textStyle: TextStyle(
                                            color: black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ] /*FORGOT PASSWORD*/
                                ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: 40, right: 40, top: 30, bottom: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  color: Color.fromARGB(255, 238, 238, 238),
                                  height: 3,
                                  width: 120,
                                ),
                                Text(
                                  'or',
                                  style: GoogleFonts.roboto(
                                    textStyle: TextStyle(
                                        color:
                                            Color.fromARGB(255, 238, 238, 238),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ),
                                Container(
                                  color: Color.fromARGB(255, 238, 238, 238),
                                  height: 3,
                                  width: 120,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: black, width: 3.0)),
                            child: ElevatedButton(
                                onPressed: () async {
                                  check = !check;
                                  MyApp().checks(check);

                                  if (FirebaseAuth.instance.currentUser ==
                                      null) {
                                    GoogleSignInAccount? account =
                                        await GoogleSignIn().signIn();

                                    if (account != null) {
                                      GoogleSignInAuthentication auth =
                                          await account.authentication;
                                      OAuthCredential credential =
                                          GoogleAuthProvider.credential(
                                        accessToken: auth.accessToken,
                                        idToken: auth.idToken,
                                      );

                                      final UserCredential authResult =
                                          await FirebaseAuth.instance
                                              .signInWithCredential(credential);

                                      final User? GUsers = authResult.user;

                                      GoogleSignIn _googleSignIn =
                                          GoogleSignIn(scopes: ['email']);

                                      String idToken =
                                          (await account.authentication)
                                              .idToken!;
                                      print('ID Token: $idToken');
                                      String token = idToken;
                                      String? username = account.displayName;
                                      String email = account.email;
                                      String id = GUsers!.uid;
                                      String? url = account.photoUrl;

                                      postRDB().posted(
                                          token, username, email, id, url);

                                      db
                                          .collection('googleSignInUser')
                                          .doc(GUsers.uid)
                                          .set({
                                        'uid': GUsers.uid,
                                        'token': idToken,
                                        'name': account.displayName,
                                        'email': account.email,
                                        'photoUrl': account.photoUrl,
                                      });

                                      int docCount = 0;

                                      QuerySnapshot qSnap =
                                          await FirebaseFirestore.instance
                                              .collection('allUsers')
                                              .doc(GUsers.uid)
                                              .collection("datas")
                                              .get();

                                      docCount = qSnap.docs.length;

                                      if (docCount == 0) {
                                        db
                                            .collection('allUsers')
                                            .doc(GUsers.uid)
                                            .collection('datas')
                                            .doc()
                                            .set({
                                          'name': account.displayName,
                                          'email': account.email,
                                        });
                                      }

                                      QuerySnapshot qSnapSun =
                                          await FirebaseFirestore.instance
                                              .collection('sundaySch')
                                              .doc(GUsers.uid)
                                              .collection("datas")
                                              .get();

                                      docCountSun = qSnapSun.docs.length;

                                      QuerySnapshot qSnapMon =
                                          await FirebaseFirestore.instance
                                              .collection('mondaySch')
                                              .doc(GUsers.uid)
                                              .collection("datas")
                                              .get();

                                      docCountMon = qSnapMon.docs.length;

                                      QuerySnapshot qSnapTues =
                                          await FirebaseFirestore.instance
                                              .collection('tuesdaySch')
                                              .doc(GUsers.uid)
                                              .collection("datas")
                                              .get();

                                      docCountTues = qSnapTues.docs.length;

                                      QuerySnapshot qSnapWednes =
                                          await FirebaseFirestore.instance
                                              .collection('wednesdaySch')
                                              .doc(GUsers.uid)
                                              .collection("datas")
                                              .get();

                                      docCountWednes = qSnapWednes.docs.length;

                                      QuerySnapshot qSnapThurs =
                                          await FirebaseFirestore.instance
                                              .collection('thursdaySch')
                                              .doc(GUsers.uid)
                                              .collection("datas")
                                              .get();

                                      docCountThurs = qSnapThurs.docs.length;

                                      QuerySnapshot qSnapFri =
                                          await FirebaseFirestore.instance
                                              .collection('fridaySch')
                                              .doc(GUsers.uid)
                                              .collection("datas")
                                              .get();

                                      docCountFri = qSnapFri.docs.length;

                                      QuerySnapshot qSnapSat =
                                          await FirebaseFirestore.instance
                                              .collection('saturdaySch')
                                              .doc(GUsers.uid)
                                              .collection("datas")
                                              .get();

                                      docCountSatur = qSnapSat.docs.length;

                                      db
                                          .collection('statsSch')
                                          .doc(GUsers.uid)
                                          .collection("datas")
                                          .doc("Sunday")
                                          .set({
                                        'data': docCountSun,
                                        'day': 'Sunday'
                                      });
                                      db
                                          .collection('statsSch')
                                          .doc(GUsers.uid)
                                          .collection("datas")
                                          .doc("Monday")
                                          .set({
                                        'data': docCountMon,
                                        'day': 'Monday'
                                      });
                                      db
                                          .collection('statsSch')
                                          .doc(GUsers.uid)
                                          .collection("datas")
                                          .doc("Tuesday")
                                          .set({
                                        'data': docCountTues,
                                        'day': 'Tuesday'
                                      });
                                      db
                                          .collection('statsSch')
                                          .doc(GUsers.uid)
                                          .collection("datas")
                                          .doc("Wednesday")
                                          .set({
                                        'data': docCountWednes,
                                        'day': 'Wednesday'
                                      });
                                      db
                                          .collection('statsSch')
                                          .doc(GUsers.uid)
                                          .collection("datas")
                                          .doc("Thursday")
                                          .set({
                                        'data': docCountThurs,
                                        'day': 'Thursday'
                                      });
                                      db
                                          .collection('statsSch')
                                          .doc(GUsers.uid)
                                          .collection("datas")
                                          .doc("Friday")
                                          .set({
                                        'data': docCountFri,
                                        'day': 'Friday'
                                      });
                                      db
                                          .collection('statsSch')
                                          .doc(GUsers.uid)
                                          .collection("datas")
                                          .doc("Saturday")
                                          .set({
                                        'data': docCountSatur,
                                        'day': 'Saturday'
                                      });
                                    }
                                  } else {
                                    GoogleSignIn().signOut();
                                    FirebaseAuth.instance.signOut();
                                  }

                                  await AuthManager.logIn('your_auth_token');

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor:
                                          Color.fromARGB(255, 0, 35, 65),
                                      width: 185,
                                      content: Center(
                                        child: Container(
                                          height: 20,
                                          child: const Text(
                                            'Login Successfully',
                                            style: TextStyle(color: white),
                                          ),
                                        ),
                                      ),
                                      behavior: SnackBarBehavior.floating,
                                      elevation: 0,
                                    ),
                                  );

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BottomNavBarPage(),
                                    ),
                                  );
                                },
                                style: ButtonStyle(
                                  shape:
                                      WidgetStateProperty.all(CircleBorder()),
                                  backgroundColor: WidgetStateProperty.all(
                                      Colors.white), // <-- Button color
                                  overlayColor:
                                      WidgetStateProperty.resolveWith<Color?>(
                                          (states) {
                                    if (states.contains(WidgetState.pressed))
                                      return black;
                                    return null; // <-- Splash color
                                  }),
                                ),
                                child: Image.asset(
                                  'assets/images/google.png',
                                  width: 50,
                                )),
                          ),

                          /*BUTTON LOGIN*/
                          Container(
                            margin:
                                EdgeInsets.only(top: 50, left: 40, right: 40),
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    boxShadow: [
                                      const BoxShadow(
                                        color: Color.fromARGB(255, 0, 35, 65),
                                        offset: Offset(0, 4),
                                        blurRadius: 3,
                                        spreadRadius: 0,
                                      ),
                                    ],
                                  ),
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      shape: WidgetStateProperty.all(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10))),
                                      backgroundColor:
                                          WidgetStateProperty.all(
                                              theme), // <-- Button color
                                      overlayColor: WidgetStateProperty
                                          .resolveWith<Color?>((states) {
                                        if (states
                                            .contains(WidgetState.pressed))
                                          return black;
                                        return null; // <-- Splash color
                                      }),
                                    ),
                                    onPressed: () async {
                                      check = !check;
                                      MyApp().checks(check);

                                      if (logemailController.text.isEmpty) {
                                        _showEmptyDialog("Type something");
                                      } else if (logpasswordController
                                          .text.isEmpty) {
                                        _showEmptyDialog("Type something");
                                      }
                                      setState(() {
                                        _isLoading = true;
                                      });
                                      String result =
                                          await AuthMethods().logInUser(
                                        email: logemailController.text,
                                        password: logpasswordController.text,
                                      );
                                      if (result == 'success') {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                BottomNavBarPage(),
                                          ),
                                        );

                                        await AuthManager.logIn(
                                            'your_auth_token');

                                        QuerySnapshot qSnapSun =
                                            await FirebaseFirestore.instance
                                                .collection('sundaySch')
                                                .doc(user!.uid)
                                                .collection("datas")
                                                .get();

                                        docCountSun = qSnapSun.docs.length;

                                        QuerySnapshot qSnapMon =
                                            await FirebaseFirestore.instance
                                                .collection('mondaySch')
                                                .doc(user!.uid)
                                                .collection("datas")
                                                .get();

                                        docCountMon = qSnapMon.docs.length;

                                        QuerySnapshot qSnapTues =
                                            await FirebaseFirestore.instance
                                                .collection('tuesdaySch')
                                                .doc(user!.uid)
                                                .collection("datas")
                                                .get();

                                        docCountTues = qSnapTues.docs.length;

                                        QuerySnapshot qSnapWednes =
                                            await FirebaseFirestore.instance
                                                .collection('wednesdaySch')
                                                .doc(user!.uid)
                                                .collection("datas")
                                                .get();

                                        docCountWednes =
                                            qSnapWednes.docs.length;

                                        QuerySnapshot qSnapThurs =
                                            await FirebaseFirestore.instance
                                                .collection('thursdaySch')
                                                .doc(user!.uid)
                                                .collection("datas")
                                                .get();

                                        docCountThurs = qSnapThurs.docs.length;

                                        QuerySnapshot qSnapFri =
                                            await FirebaseFirestore.instance
                                                .collection('fridaySch')
                                                .doc(user!.uid)
                                                .collection("datas")
                                                .get();

                                        docCountFri = qSnapFri.docs.length;

                                        QuerySnapshot qSnapSat =
                                            await FirebaseFirestore.instance
                                                .collection('saturdaySch')
                                                .doc(user!.uid)
                                                .collection("datas")
                                                .get();

                                        docCountSatur = qSnapSat.docs.length;

                                        db
                                            .collection('statsSch')
                                            .doc(user!.uid)
                                            .collection("datas")
                                            .doc("Sunday")
                                            .set({
                                          'data': docCountSun,
                                          'day': 'Sunday'
                                        });
                                        db
                                            .collection('statsSch')
                                            .doc(user!.uid)
                                            .collection("datas")
                                            .doc("Monday")
                                            .set({
                                          'data': docCountMon,
                                          'day': 'Monday'
                                        });
                                        db
                                            .collection('statsSch')
                                            .doc(user!.uid)
                                            .collection("datas")
                                            .doc("Tuesday")
                                            .set({
                                          'data': docCountTues,
                                          'day': 'Tuesday'
                                        });
                                        db
                                            .collection('statsSch')
                                            .doc(user!.uid)
                                            .collection("datas")
                                            .doc("Wednesday")
                                            .set({
                                          'data': docCountWednes,
                                          'day': 'Wednesday'
                                        });
                                        db
                                            .collection('statsSch')
                                            .doc(user!.uid)
                                            .collection("datas")
                                            .doc("Thursday")
                                            .set({
                                          'data': docCountThurs,
                                          'day': 'Thursday'
                                        });
                                        db
                                            .collection('statsSch')
                                            .doc(user!.uid)
                                            .collection("datas")
                                            .doc("Friday")
                                            .set({
                                          'data': docCountFri,
                                          'day': 'Friday'
                                        });
                                        db
                                            .collection('statsSch')
                                            .doc(user!.uid)
                                            .collection("datas")
                                            .doc("Saturday")
                                            .set({
                                          'data': docCountSatur,
                                          'day': 'Saturday'
                                        });
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            width: 185,
                                            backgroundColor:
                                                Color.fromARGB(255, 0, 35, 65),
                                            content: Center(
                                              child: Container(
                                                height: 20,
                                                child: const Text(
                                                  'Login Failed',
                                                  style:
                                                      TextStyle(color: white),
                                                ),
                                              ),
                                            ),
                                            behavior: SnackBarBehavior.floating,
                                            elevation: 0,
                                          ),
                                        );

                                        logemailController.clear();
                                        logpasswordController.clear();
                                      }

                                      setState(() {
                                        _isLoading = false;
                                      });

                                      ;
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding: EdgeInsets.only(
                                          top: 10.0, bottom: 10.0),
                                      child: Text(
                                        "Login",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.roboto(
                                          textStyle: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                /*BUTTON LOGIN*/

                                /*FORGOT PASSWORD*/
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: Container(
                                        child: Text(
                                          'Dont Have Any Account ?',
                                          style: GoogleFonts.roboto(
                                            textStyle: TextStyle(
                                              fontSize: 11,
                                              color: Color.fromARGB(
                                                  255, 187, 187, 187),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: Container(
                                        child: TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) => RegisterPage(),
                                              ),
                                            );
                                          },
                                          child: Text('CREATE AN ACCOUNT',
                                              style: GoogleFonts.roboto(
                                                textStyle: TextStyle(
                                                    fontSize: 9,
                                                    color: black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                /*FORGOT PASSWORD*/
                              ],
                            ),
                          ),
                        ],
                      )

                      //  FORM LOGIN
                      /*BUTTON LOGIN*/
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _showEmptyDialog(String title) {
    if (Platform.isAndroid) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => AlertDialog(
          content: Text("$title can't be empty"),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"))
          ],
        ),
      );
    } else if (Platform.isIOS) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => CupertinoAlertDialog(
          content: Text("$title can't be empty"),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"))
          ],
        ),
      );
    }
  }
}
