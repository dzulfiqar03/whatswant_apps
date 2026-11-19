
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whatswant/assets/Colors/colors.dart';
import 'package:whatswant/contents/auth/login_page.dart';
import 'package:whatswant/contents/provider/auth.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formkey = GlobalKey<FormState>();

  bool _isLoading = false;
  final firstnameController = TextEditingController();

  final lastnameController = TextEditingController();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmpasswordController = TextEditingController();

  final addressController = TextEditingController();

  final lasteducationController = TextEditingController();

  final fieldofstudyController = TextEditingController();
  Stream<QuerySnapshot<Map<String, dynamic>>> dbRegist =
      FirebaseFirestore.instance.collection("registerUser").snapshots();

  WidgetStateProperty<Color> getColor(Color color, Color colorPressed) {
    final getColor = (Set<WidgetState> states) {
      if (states.contains(WidgetState.pressed)) {
        return colorPressed;
      } else {
        return color;
      }
    };
    return WidgetStateProperty.resolveWith(getColor);
  }

  User? user = FirebaseAuth.instance.currentUser;
  final db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Stack(
          children: [
            Container(
              width: MediaQuery.sizeOf(context).width * 0.97,
              height: MediaQuery.sizeOf(context).height * 0.25,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(100)),
                  color: Color.fromARGB(255, 212, 212, 212)),
            ),
            Container(
              width: MediaQuery.sizeOf(context).width * 0.94,
              height: MediaQuery.sizeOf(context).height * 0.25,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(100)),
                  color: Color.fromARGB(255, 0, 35, 65)),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(left: 40, right: 40, top: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 80,
                    ),
                    Form(
                      key: _formkey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /*TITLE*/
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                alignment: Alignment.centerRight,
                                child: FutureBuilder(
                                  future: Future.delayed(Duration(seconds: 3)),
                                  builder: ((context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Text('HOLLA, WELCOME',
                                          style: GoogleFonts.roboto(
                                            textStyle: TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold,
                                              color: white,
                                            ),
                                          ));
                                    } else {
                                      return Text('SIGN UP',
                                          style: GoogleFonts.roboto(
                                            textStyle: TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold,
                                              color: white,
                                            ),
                                          ));
                                    }
                                  }),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                          /*TITLE*/

                          // BODY
                          Container(
                            margin: EdgeInsets.only(top: 28),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // FORM
                                Container(
                                  margin: EdgeInsets.only(top: 20),
                                  child: Column(children: [
                                    /*FIRSTNAME*/
                                    Column(
                                      children: [
                                        SingleChildScrollView(
                                          child: Center(
                                            child: Container(
                                              padding:
                                                  EdgeInsets.only(top: 18.0),
                                              child: Container(
                                                padding: EdgeInsets.only(
                                                    top: 5.0,
                                                    left: 10.0,
                                                    bottom: 5.0,
                                                    right: 10.0),
                                                child: TextFormField(
                                                    style: GoogleFonts.roboto(
                                                        textStyle:
                                                            GoogleFonts.roboto(
                                                                textStyle:
                                                                    TextStyle(
                                                                        color:
                                                                            black))),
                                                    controller:
                                                        firstnameController,
                                                    decoration: InputDecoration(
                                                      fillColor: white,
                                                      contentPadding:
                                                          EdgeInsets.all(6),
                                                      hintStyle: TextStyle(
                                                          color: Color.fromARGB(
                                                              255,
                                                              187,
                                                              187,
                                                              187)),
                                                      hoverColor: black,
                                                      hintText:
                                                          "Enter Your First Name",
                                                      filled: true,
                                                      focusColor: red,
                                                      icon: const Icon(
                                                        Icons.abc,
                                                        color: black,
                                                      ),
                                                      enabledBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    255,
                                                                    255,
                                                                    255)),
                                                      ),
                                                    ),
                                                    onSaved: (value) {
                                                      firstnameController.text =
                                                          value!;
                                                    },
                                                    keyboardType:
                                                        TextInputType.text,
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return 'First Name Is Required';
                                                      }
                                                      return null;
                                                    }),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    /*FIRSTNAME*/

                                    /*LAST NAME*/
                                    Center(
                                      child: Container(
                                        padding: EdgeInsets.only(top: 8.0),
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              top: 5.0,
                                              left: 10.0,
                                              bottom: 5.0,
                                              right: 10.0),
                                          child: TextFormField(
                                              style: GoogleFonts.roboto(
                                                  textStyle: GoogleFonts.roboto(
                                                      textStyle: TextStyle(
                                                          color: black))),
                                              controller: lastnameController,
                                              decoration: InputDecoration(
                                                fillColor: white,
                                                contentPadding:
                                                    EdgeInsets.all(6),
                                                hintStyle: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 187, 187, 187)),
                                                hoverColor: black,
                                                hintText:
                                                    "Enter Your Last Name",
                                                filled: true,
                                                focusColor: red,
                                                icon: const Icon(
                                                  Icons.abc,
                                                  color: black,
                                                ),
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Color.fromARGB(
                                                          255, 255, 255, 255)),
                                                ),
                                              ),
                                              onSaved: (value) {
                                                lastnameController.text =
                                                    value!;
                                              },
                                              keyboardType: TextInputType.text,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return 'Last Name Is Required';
                                                }
                                                return null;
                                              }),
                                        ),
                                      ),
                                    ),
                                    /*LAST NAME*/

                                    /*EMAIL*/
                                    Center(
                                      child: Container(
                                        padding: EdgeInsets.only(top: 8.0),
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              top: 5.0,
                                              left: 10.0,
                                              bottom: 5.0,
                                              right: 10.0),
                                          child: TextFormField(
                                              style: GoogleFonts.roboto(
                                                  textStyle: GoogleFonts.roboto(
                                                      textStyle: TextStyle(
                                                          color: black))),
                                              controller: emailController,
                                              decoration: InputDecoration(
                                                fillColor: white,
                                                contentPadding:
                                                    EdgeInsets.all(6),
                                                hintStyle: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 187, 187, 187)),
                                                hoverColor: black,
                                                hintText: "Enter Your Email",
                                                filled: true,
                                                focusColor: red,
                                                icon: const Icon(
                                                  Icons.mail,
                                                  color: black,
                                                ),
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Color.fromARGB(
                                                          255, 255, 255, 255)),
                                                ),
                                              ),
                                              onSaved: (value) {
                                                emailController.text = value!;
                                              },
                                              keyboardType:
                                                  TextInputType.emailAddress,
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
                                    /*EMAIL*/

                                    /*PASSWORD*/
                                    Center(
                                      child: Container(
                                        padding: EdgeInsets.only(top: 8.0),
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              top: 5.0,
                                              left: 10.0,
                                              bottom: 5.0,
                                              right: 10.0),
                                          child: TextFormField(
                                              style: GoogleFonts.roboto(
                                                  textStyle: GoogleFonts.roboto(
                                                      textStyle: TextStyle(
                                                          color: black))),
                                              controller: passwordController,
                                              decoration: InputDecoration(
                                                fillColor: white,
                                                contentPadding:
                                                    EdgeInsets.all(6),
                                                hintStyle: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 187, 187, 187)),
                                                hoverColor: black,
                                                filled: true,
                                                hintText: "Enter Your Password",
                                                focusColor: red,
                                                icon: const Icon(
                                                  Icons.password,
                                                  color: black,
                                                ),
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Color.fromARGB(
                                                          255, 255, 255, 255)),
                                                ),
                                              ),
                                              onSaved: (value) {
                                                passwordController.text =
                                                    value!;
                                              },
                                              keyboardType:
                                                  TextInputType.visiblePassword,
                                              obscureText: true,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return 'Password Is Required';
                                                } else if (value.length < 8) {
                                                  return 'Password Must Be 8 Character';
                                                }
                                                return null;
                                              }),
                                        ),
                                      ),
                                    ),
                                    /*PASSWORD*/

                                    /*CONFIRMPASSWORD*/
                                    Center(
                                      child: Container(
                                        padding: EdgeInsets.only(top: 8.0),
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              top: 5.0,
                                              left: 10.0,
                                              bottom: 5.0,
                                              right: 10.0),
                                          child: TextFormField(
                                              style: GoogleFonts.roboto(
                                                  textStyle: GoogleFonts.roboto(
                                                textStyle:
                                                    TextStyle(color: black),
                                              )),
                                              controller:
                                                  confirmpasswordController,
                                              decoration: InputDecoration(
                                                fillColor: white,
                                                contentPadding:
                                                    EdgeInsets.all(6),
                                                hoverColor: black,
                                                filled: true,
                                                hintText:
                                                    "Enter Your Confirm Password",
                                                hintStyle: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 187, 187, 187)),
                                                focusColor: red,
                                                icon: const Icon(
                                                  Icons.password,
                                                  color: black,
                                                ),
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Color.fromARGB(
                                                          255, 255, 255, 255)),
                                                ),
                                              ),
                                              onSaved: (value) {
                                                confirmpasswordController.text =
                                                    value!;
                                              },
                                              keyboardType:
                                                  TextInputType.visiblePassword,
                                              obscureText: true,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return 'Confirm Password Is Required';
                                                }

                                                if (confirmpasswordController
                                                        .text !=
                                                    passwordController.text) {
                                                  return 'Confirm Password Must Be Same';
                                                }
                                                return null;
                                              }),
                                        ),
                                      ),
                                    ),
                                    /*CONFIRMPASSWORD*/
                                  ]),
                                )
                                // FORM
                              ],
                            ),
                          )
                        ],
                      ),
                    ),

                    /*BUTTON SIGNUP*/
                    Container(
                      margin: EdgeInsets.only(left: 10, right: 10, top: 50),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          const BoxShadow(
                            color: Color.fromARGB(101, 0, 35, 65),
                            offset: Offset(0, 4),
                            blurRadius: 4,
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape: WidgetStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          backgroundColor: WidgetStateProperty.all(
                              theme), // <-- Button color
                          overlayColor:
                              WidgetStateProperty.resolveWith<Color?>(
                                  (states) {
                            if (states.contains(WidgetState.pressed))
                              return black;
                            return null; // <-- Splash color
                          }),
                        ),
                        onPressed: () async {
                          if (_formkey.currentState!.validate()) {
                            _formkey.currentState!.save();

                            String result = await AuthMethods().signUpUser(
                              name: firstnameController.text +
                                  " " +
                                  lastnameController.text,
                              email: emailController.text,
                              password: passwordController.text,
                            );

                            if (result != 'success') {
                            } else {
                              setState(() {
                                _isLoading = true;
                              });
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => LoginPage(),
                                ),
                              );
                            }
                            setState(() {
                              _isLoading = false;
                            });

                            print("Full Name :" +
                                " " +
                                firstnameController.text +
                                " " +
                                lastnameController.text +
                                "\n" +
                                emailController.text +
                                "\n" +
                                passwordController.text +
                                "\n");
                          }
                          ;
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: Text(
                            "SIGN UP",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
