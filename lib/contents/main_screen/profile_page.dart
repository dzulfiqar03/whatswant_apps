import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:whatswant/assets/Colors/colors.dart';
import 'package:whatswant/contents/auth/login_page.dart';
import 'package:whatswant/contents/main_screen/notes_page.dart';
import 'package:whatswant/contents/provider/google_sign_in.dart';

class StatsData {
  User? user = FirebaseAuth.instance.currentUser;
  final db = FirebaseFirestore.instance;
  int docCountSun = 0;
  int docCountMon = 0;
  int docCountTues = 0;
  int docCountWednes = 0;
  int docCountThurs = 0;
  int docCountFri = 0;
  int docCountSatur = 0;

  Future<void> fetchDataSun() async {
    try {
      QuerySnapshot qSnapSun = await FirebaseFirestore.instance
          .collection('sundaySch')
          .doc(user!.uid)
          .collection("datas")
          .get();

      docCountSun = qSnapSun.docs.length;



      db
          .collection('statsSch')
          .doc(user!.uid)
          .collection("datas")
          .doc("Sunday")
          .update({'data': docCountSun, 'day': 'Sunday'});
    } catch (e) {}
  }

  Future<void> fetchDataMon() async {
    try {
      QuerySnapshot qSnapMon = await FirebaseFirestore.instance
          .collection('mondaySch')
          .doc(user!.uid)
          .collection("datas")
          .get();

      docCountMon = qSnapMon.docs.length;



      db
          .collection('statsSch')
          .doc(user!.uid)
          .collection("datas")
          .doc("Monday")
          .update({'data': docCountMon, 'day': 'Monday'});
    } catch (e) {}
  }

  Future<void> fetchDataTues() async {
    try {
      QuerySnapshot qSnapTues =
          await FirebaseFirestore.instance.collection('tuesdaySch') .doc(user!.uid)
          .collection("datas").get();

      docCountTues = qSnapTues.docs.length;

    

      db
          .collection('statsSch')
          .doc(user!.uid)
          .collection("datas")
          .doc("Tuesday")
          .update({'data': docCountTues, 'day': 'Tuesday'});
    } catch (e) {}
  }

  Future<void> fetchDataWed() async {
    try {
      QuerySnapshot qSnapWednes =
          await FirebaseFirestore.instance.collection('wednesdaySch') .doc(user!.uid)
          .collection("datas").get();

      docCountWednes = qSnapWednes.docs.length;



      db
          .collection('statsSch')
          .doc(user!.uid)
          .collection("datas")
          .doc("Wednesday")
          .update({'data': docCountWednes, 'day': 'Wednesday'});
    } catch (e) {}
  }

  Future<void> fetchDataThurs() async {
    try {
      QuerySnapshot qSnapThurs =
          await FirebaseFirestore.instance.collection('thursdaySch') .doc(user!.uid)
          .collection("datas").get();

      docCountThurs = qSnapThurs.docs.length;

    

      db
          .collection('statsSch')
          .doc(user!.uid)
          .collection("datas")
          .doc("Thursday")
          .update({'data': docCountThurs, 'day': 'Thursday'});
    } catch (e) {}
  }

  Future<void> fetchDataFri() async {
    try {
      QuerySnapshot qSnapFri =
          await FirebaseFirestore.instance.collection('fridaySch') .doc(user!.uid)
          .collection("datas").get();

      docCountFri = qSnapFri.docs.length;

    

      db
          .collection('statsSch')
          .doc(user!.uid)
          .collection("datas")
          .doc("Friday")
          .update({'data': docCountFri, 'day': 'Friday'});
    } catch (e) {}
  }

  Future<void> fetchDataSat() async {
    try {
      QuerySnapshot qSnapSat =
          await FirebaseFirestore.instance.collection('saturdaySch') .doc(user!.uid)
          .collection("datas").get();

      docCountSatur = qSnapSat.docs.length;

    

      db
          .collection('statsSch')
          .doc(user!.uid)
          .collection("datas")
          .doc("Saturday")
          .update({'data': docCountSatur, 'day': 'Saturday'});
    } catch (e) {}
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String calender = '';

  String day = "";
  void Day() {
    Timer.periodic(new Duration(seconds: 1), (_) {
      var dayNw = new DateTime.now();
      String formatedDayNw = new DateFormat.EEEE().format(dayNw);
      if (mounted) {
        setState(() {
          day = formatedDayNw;
        });
      }
    });
  }

  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  void Cal() {
    Timer.periodic(new Duration(seconds: 1), (_) {
      var calNw = new DateTime.now();
      var formatedCalNw = new DateFormat.d().format(calNw);
      if (mounted) {
        setState(() {
          calender = formatedCalNw;
        });
      }
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> visitCount =
      FirebaseFirestore.instance.collection("visitCount").snapshots();

  String month = "";
  void Month() {
    Timer.periodic(new Duration(seconds: 1), (_) {
      var monthNw = new DateTime.now();
      String formatedMonthNw = new DateFormat.M().format(monthNw);
      if (mounted) {
        setState(() {
          month = formatedMonthNw;
          month == '1'
              ? month = 'January'
              : month == '2'
                  ? month = 'February'
                  : month == '3'
                      ? month = 'March'
                      : month == '4'
                          ? month = 'April'
                          : month == '5'
                              ? month = 'May'
                              : month == '6'
                                  ? month = 'June'
                                  : month == '7'
                                      ? month = 'July'
                                      : month == '8'
                                          ? month = 'August'
                                          : month == '9'
                                              ? month = 'September'
                                              : month == '10'
                                                  ? month = 'October'
                                                  : month == '11'
                                                      ? month = 'November'
                                                      : month = 'December';
        });
      }
    });
  }

  String year = "";
  void Year() {
    Timer.periodic(new Duration(seconds: 1), (_) {
      var yearNw = new DateTime.now();
      String formatedYearNw = new DateFormat.y().format(yearNw);
      if (mounted) {
        setState(() {
          year = formatedYearNw;
        });
      }
    });
  }

  User? user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    Cal();
    Day();
    Month();
    Year();

    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    final dispName = FirebaseFirestore.instance
        .collection("allUsers")
        .doc(user!.uid)
        .collection('datas')
        .snapshots();
    GoogleSignInAccount? userss = _googleSignIn.currentUser;
    Stream<QuerySnapshot<Map<String, dynamic>>> dbStreamChart =
        FirebaseFirestore.instance
            .collection('statsSch')
            .doc(user!.uid)
            .collection("datas")
            .snapshots();
    Stream<QuerySnapshot<Map<String, dynamic>>> dbNotes = FirebaseFirestore
        .instance
        .collection("noteList")
        .doc(user!.uid)
        .collection("datas")
        .snapshots();

    return Scaffold(
      backgroundColor: white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      calender + ' ',
                      style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 0, 35, 65),
                              fontSize: 20)),
                    ),
                    Text(month + ' ',
                        style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 20))),
                    Text(year + ' ',
                        style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 20))),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                    child: Container(
                        width: 100.0,
                        height: 100.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(100.0),
                          ),
                          color: Color.fromARGB(255, 0, 35, 65),
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.people_outline_outlined,
                            color: Colors.white,
                          ),
                          onPressed: () {},
                        ))),
                SizedBox(
                  height: 30,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    StreamBuilder(
                        stream: dispName,
                        builder: (context, snapshot) {
                          if (snapshot.data == null) {
                            return CircularProgressIndicator();
                          }
                          return Column(
                            children: snapshot.data!.docs.map((e) {
                              return Container(
                                padding: EdgeInsets.symmetric(horizontal: 15.0),
                                child: Text(
                                  user == null
                                      ? "No Data"
                                      : e['name'],
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: theme,
                                      fontWeight: FontWeight.bold),
                                ),
                              );
                            }).toList(),
                          );
                        }),
                    ElevatedButton(
                      onPressed: () async {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                backgroundColor: Color.fromARGB(255, 0, 35, 65),
                                content: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: const Text(
                                    'Are You Sure To Continue?',
                                    style: TextStyle(color: white),
                                  ),
                                ),
                                actions: <Widget>[
                                  ElevatedButton(
                                    child: const Text('Continue'),
                                    onPressed: () async {
                                      var user =
                                          Provider.of<GoogleSignInProvider>(
                                              context,
                                              listen: false);

                                      userss == null
                                          ? await user.logOutEmail()
                                          : user.logOut();

                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                ChangeNotifierProvider(
                                                  create: (context) =>
                                                      GoogleSignInProvider(),
                                                  child: LoginPage(),
                                                )),
                                      );
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                          WidgetStateProperty.all(
                                              Color.fromARGB(255, 63, 63, 63)),
                                      foregroundColor:
                                          WidgetStateProperty.all(white),
                                      shape: WidgetStateProperty.all(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20))),
                                      overlayColor: WidgetStateProperty
                                          .resolveWith<Color?>((states) {
                                        if (states
                                            .contains(WidgetState.pressed))
                                          return black;
                                        return null; // <-- Splash color
                                      }),
                                    ),
                                  ),

                                  // Cancel button
                                  ElevatedButton(
                                    child: const Text('Cancel'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                          WidgetStateProperty.all(
                                              Color.fromARGB(255, 0, 9, 94)),
                                      foregroundColor:
                                          WidgetStateProperty.all(white),
                                      shape: WidgetStateProperty.all(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20))),
                                      overlayColor: WidgetStateProperty
                                          .resolveWith<Color?>((states) {
                                        if (states
                                            .contains(WidgetState.pressed))
                                          return black;
                                        return null; // <-- Splash color
                                      }),
                                    ),
                                  )
                                ],
                              );
                            });
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(theme),
                        foregroundColor: WidgetStateProperty.all(white),
                        shape: WidgetStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                        overlayColor:
                            WidgetStateProperty.resolveWith<Color?>((states) {
                          if (states.contains(WidgetState.pressed))
                            return red;
                          return null; // <-- Splash color
                        }),
                      ),
                      child: Container(
                        child: Text("LogOut",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => NotesPage(),
                              ),
                            );
                          },
                          child: StreamBuilder<
                                  QuerySnapshot<Map<String, dynamic>>>(
                              stream: dbNotes,
                              builder: (context, snapshot) {
                                if (snapshot.data == null) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                }

                                if (snapshot.data!.docs.length == 0) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          const BoxShadow(
                                            color:
                                                Color.fromARGB(255, 87, 87, 87),
                                            offset: Offset(0, 4),
                                            blurRadius: 3,
                                            spreadRadius: 0,
                                          ),
                                        ],
                                        color:
                                            Color.fromARGB(255, 238, 238, 238)),
                                    child: Column(
                                      children: [
                                        Text(
                                          'Notes Count',
                                          style: GoogleFonts.roboto(
                                              textStyle: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromARGB(
                                                      255, 0, 35, 65),
                                                  fontSize: 20)),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          'No Data',
                                          style: GoogleFonts.roboto(
                                              textStyle: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromARGB(
                                                      255, 0, 35, 65),
                                                  fontSize: 20)),
                                        ),
                                      ],
                                    ),
                                  );
                                } else {
                                  int dataLength =
                                      snapshot.data?.docs.length ?? 0;
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          const BoxShadow(
                                            color:
                                                Color.fromARGB(255, 87, 87, 87),
                                            offset: Offset(0, 4),
                                            blurRadius: 3,
                                            spreadRadius: 0,
                                          ),
                                        ],
                                        color:
                                            Color.fromARGB(255, 238, 238, 238)),
                                    child: Column(
                                      children: [
                                        Text(
                                          'Notes Count',
                                          style: GoogleFonts.roboto(
                                              textStyle: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromARGB(
                                                      255, 0, 35, 65),
                                                  fontSize: 20)),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          '$dataLength',
                                          style: GoogleFonts.roboto(
                                              textStyle: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromARGB(
                                                      255, 0, 35, 65),
                                                  fontSize: 30)),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              }),
                        ),
                        StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                            stream: visitCount,
                            builder: (context, snapshot) {
                              if (snapshot.data == null) {
                                return Center(
                                    child: CircularProgressIndicator());
                              }

                              if (snapshot.data!.docs.length == 0) {
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        const BoxShadow(
                                          color:
                                              Color.fromARGB(255, 87, 87, 87),
                                          offset: Offset(0, 4),
                                          blurRadius: 3,
                                          spreadRadius: 0,
                                        ),
                                      ],
                                      color:
                                          Color.fromARGB(255, 238, 238, 238)),
                                  child: Column(
                                    children: [
                                      Text(
                                        'Notes Count',
                                        style: GoogleFonts.roboto(
                                            textStyle: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(
                                                    255, 0, 35, 65),
                                                fontSize: 20)),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        'No Data',
                                        style: GoogleFonts.roboto(
                                            textStyle: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(
                                                    255, 0, 35, 65),
                                                fontSize: 20)),
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                int dataLength =
                                    snapshot.data?.docs.length ?? 0;
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        const BoxShadow(
                                          color:
                                              Color.fromARGB(255, 87, 87, 87),
                                          offset: Offset(0, 4),
                                          blurRadius: 3,
                                          spreadRadius: 0,
                                        ),
                                      ],
                                      color:
                                          Color.fromARGB(255, 238, 238, 238)),
                                  child: Column(
                                    children: [
                                      Text(
                                        'Visit Count',
                                        style: GoogleFonts.roboto(
                                            textStyle: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(
                                                    255, 0, 35, 65),
                                                fontSize: 20)),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        '$dataLength',
                                        style: GoogleFonts.roboto(
                                            textStyle: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(
                                                    255, 0, 35, 65),
                                                fontSize: 30)),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            })
                      ],
                    )
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              'Your Activity',
              style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 35, 65),
                      fontSize: 14)),
            ),
        SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
