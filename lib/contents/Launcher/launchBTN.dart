import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:whatswant/contents/auth/login_page.dart';

class LaunchBtnPage extends StatefulWidget {
  const LaunchBtnPage({super.key});

  @override
  State<LaunchBtnPage> createState() => _LaunchBtnPageState();
}

class _LaunchBtnPageState extends State<LaunchBtnPage> {
  double _containerWidth = 200.0;
  double _containerHeight = 200.0;
  double offset = 25.0;
  double widhBord = 0.5;
  final db = FirebaseFirestore.instance;
User? user = FirebaseAuth.instance.currentUser;
  bool countbl = false;
  int count = 0;
  var jam = '';
  void startJam() {
    Timer.periodic(new Duration(seconds: 1), (timer) {
      var tgl = new DateTime.now();
      var formatedjam = new DateFormat.Hms().format(tgl);

      jam = formatedjam;
    });
  }

  @override
  void initState() {
    super.initState();
    startJam();
  }

 
  @override
  Widget build(BuildContext context) { 
    Stream<QuerySnapshot<Map<String, dynamic>>> visitCount =
      FirebaseFirestore.instance.collection("visitCount").snapshots();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 0, 35, 65),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: widhBord,
                ),
                color: Color.fromARGB(255, 0, 35, 65),
                borderRadius: BorderRadius.circular(100),
                boxShadow: [
                  BoxShadow(
                      color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
                      offset: Offset(0, offset),
                      blurRadius: 3,
                      spreadRadius: -10)
                ],
              ),
              width: _containerWidth,
              height: _containerHeight,
              child: Image.asset(
                'assets/images/icon landingPage.png',
              ),
            ),
            SizedBox(
              height: 30,
            ),
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: visitCount,
                builder: (context, snapshot) {
                  return ElevatedButton(
                    style: ButtonStyle(
                      shape: WidgetStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                      backgroundColor: WidgetStateProperty.all(
                          Color.fromARGB(255, 0, 35, 65)), // <-- Button color
                      overlayColor:
                          WidgetStateProperty.resolveWith<Color?>((states) {
                        if (states.contains(WidgetState.pressed))
                          return const Color.fromARGB(255, 0, 0, 0);
                        return null; // <-- Splash color
                      }),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 28),
                      child: const Text(
                        'Launch Now',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    onPressed: () async {
                      await db.collection('visitCount').add({
                        'bool': !countbl,
                        'visited at': jam,
                      });

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => LoginPage(),
                        ),
                      );
                    },
                  );
                }),
          ],
        )),
      ),
    );
  }
}
