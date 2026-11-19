import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:whatswant/assets/Colors/colors.dart';


class ActivitiesPage extends StatefulWidget {
  const ActivitiesPage({super.key});

  @override
  State<ActivitiesPage> createState() => _ActivitiesPageState();
}

class _ActivitiesPageState extends State<ActivitiesPage> {
  User? user = FirebaseAuth.instance.currentUser;

  int jamInt = TimeOfDay.now().hour;
  var jam = '';
  void startJam() {
    Timer.periodic(new Duration(seconds: 1), (timer) {
      var tgl = new DateTime.now();
      var formatedjam = new DateFormat.Hms().format(tgl);

      jam = formatedjam;
    });
  }

  final db = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();

  final dailyControllerText = TextEditingController();

  final dailyActControllerText = TextEditingController();
  final sundayControllerText = TextEditingController();
  final mondayControllerText = TextEditingController();
  final tuesdayControllerText = TextEditingController();
  final wednesdayControllerText = TextEditingController();
  final thursdayControllerText = TextEditingController();
  final fridayControllerText = TextEditingController();
  final saturdayControllerText = TextEditingController();

  final searchControllerText = TextEditingController();

  final List<String> daysOnWeek = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
  ];

  final List<String> hour = <String>[];

  int countTtl = 0;

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

  final dbArch2 =
      FirebaseFirestore.instance.collection("sundaySchArch").snapshots();
  final dbArch3 =
      FirebaseFirestore.instance.collection("mondaySchArch").snapshots();
  final dbArch4 =
      FirebaseFirestore.instance.collection("tuesdaySchArch").snapshots();
  final dbArch5 =
      FirebaseFirestore.instance.collection("wednesdaySchArch").snapshots();
  final dbArch6 =
      FirebaseFirestore.instance.collection("thursdaySchArch").snapshots();
  final dbArch7 =
      FirebaseFirestore.instance.collection("fridaySchArch").snapshots();
  final dbArch8 =
      FirebaseFirestore.instance.collection("saturdaySchArch").snapshots();

  final dbArchCount =
      FirebaseFirestore.instance.collection("countArchive").snapshots();

  DatabaseReference ref = FirebaseDatabase.instance.ref().child('saturdayAct');

  Future<AggregateQuerySnapshot> sunCount =
      FirebaseFirestore.instance.collection('sundayAct').count().get();
  Future<AggregateQuerySnapshot> monCount =
      FirebaseFirestore.instance.collection('mondayAct').count().get();
  Future<AggregateQuerySnapshot> tuesCount =
      FirebaseFirestore.instance.collection('tuesdayAct').count().get();
  Future<AggregateQuerySnapshot> wednesCount =
      FirebaseFirestore.instance.collection('wednesdayAct').count().get();
  Future<AggregateQuerySnapshot> thursCount =
      FirebaseFirestore.instance.collection('thursdayAct').count().get();
  Future<AggregateQuerySnapshot> friCount =
      FirebaseFirestore.instance.collection('fridayAct').count().get();
  Future<AggregateQuerySnapshot> saturCount =
      FirebaseFirestore.instance.collection('saturdayAct').count().get();

  String greetings() {
    final hour = TimeOfDay.now().hour;

    if (hour >= 4 && hour < 12) {
      return '🌤️Good Morning';
    } else if (hour >= 12 && hour < 17) {
      return '☀️Good Afternoon';
    } else if (hour >= 17 && hour < 22) {
      return '🌖Good Evening';
    }
    return '🌙Good Night';
  }

  @override
  void initState() {
    startJam();
    Day();
    greetings();
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    Stream<QuerySnapshot<Map<String, dynamic>>> db9 = FirebaseFirestore.instance
        .collection("sundayAct")
        .doc(user!.uid)
        .collection("datas")
        .snapshots();
    Stream<QuerySnapshot<Map<String, dynamic>>> db10 = FirebaseFirestore
        .instance
        .collection("mondayAct")
        .doc(user!.uid)
        .collection("datas")
        .snapshots();
    Stream<QuerySnapshot<Map<String, dynamic>>> db11 = FirebaseFirestore
        .instance
        .collection("tuesdayAct")
        .doc(user!.uid)
        .collection("datas")
        .snapshots();
    Stream<QuerySnapshot<Map<String, dynamic>>> db12 = FirebaseFirestore
        .instance
        .collection("wednesdayAct")
        .doc(user!.uid)
        .collection("datas")
        .snapshots();
    Stream<QuerySnapshot<Map<String, dynamic>>> db13 = FirebaseFirestore
        .instance
        .collection("thursdayAct")
        .doc(user!.uid)
        .collection("datas")
        .snapshots();
    Stream<QuerySnapshot<Map<String, dynamic>>> db14 = FirebaseFirestore
        .instance
        .collection("fridayAct")
        .doc(user!.uid)
        .collection("datas")
        .snapshots();
    Stream<QuerySnapshot<Map<String, dynamic>>> db15 = FirebaseFirestore
        .instance
        .collection("saturdayAct")
        .doc(user!.uid)
        .collection("datas")
        .snapshots();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 35, 65),
        title: const Text('Activity Page'),
      ),
      body: Center(
        child: Container(
          width: 390,
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisSpacing: 1.0,
                  crossAxisSpacing: 1.0,
                  childAspectRatio: 1.8),
              itemCount: daysOnWeek.length,
              itemBuilder: ((context, index) {
                return index == 0
                    ? Column(
                        children: [
                          Container(
                            child: Container(
                              height: 150,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromARGB(255, 214, 214, 214),
                                      spreadRadius: 0,
                                      blurRadius: 3,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                  color: day == daysOnWeek[0]
                                      ? Color.fromARGB(255, 0, 35, 65)
                                      : white),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Text(
                                      day == daysOnWeek[0]
                                          ? 'Today'
                                          : daysOnWeek[0],
                                      style: TextStyle(
                                          color: day == daysOnWeek[0]
                                              ? white
                                              : Color.fromARGB(255, 0, 35, 65),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25),
                                    ),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: Container(
                                        height: 100,
                                        child: StreamBuilder<
                                                QuerySnapshot<
                                                    Map<String, dynamic>>>(
                                            stream: db9,
                                            builder: (context, snapshot) {
                                              if (snapshot.data == null) {
                                                return Center(
                                                    child:
                                                        CircularProgressIndicator());
                                              }
                                              if (snapshot.data!.docs.length ==
                                                  0) {
                                                return Center(
                                                    child: Row(children: [
                                                  Text(
                                                    " Tap",
                                                    style: TextStyle(
                                                      color: day == daysOnWeek[0]
                                                          ? white
                                                          : Color.fromARGB(
                                                              255, 0, 35, 65),
                                                    ),
                                                  ),
                                                  Icon(
                                                    Icons.add,
                                                    color: day == daysOnWeek[0]
                                                        ? white
                                                        : Color.fromARGB(
                                                            255, 0, 35, 65),
                                                  ),
                                                  Text(
                                                    "Icon For Add",
                                                    style: TextStyle(
                                                      color: day == daysOnWeek[0]
                                                          ? white
                                                          : Color.fromARGB(
                                                              255, 0, 35, 65),
                                                    ),
                                                  )
                                                ]));
                                              }
      
                                              return ListView.builder(
                                                scrollDirection: Axis.vertical,
                                                itemCount:
                                                    snapshot.data!.docs.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  DocumentSnapshot document =
                                                      snapshot.data!.docs[index];
                                                  return SingleChildScrollView(
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    child: Container(
                                                      padding: EdgeInsets.all(3),
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      10)),
                                                          color: Color.fromARGB(
                                                              255, 247, 247, 247),
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            Checkbox(
                                                              checkColor: day ==
                                                                      daysOnWeek[
                                                                          0]
                                                                  ? Color
                                                                      .fromARGB(
                                                                          255,
                                                                          0,
                                                                          35,
                                                                          65)
                                                                  : white,
                                                              shape:
                                                                  CircleBorder(),
                                                              activeColor: day ==
                                                                      daysOnWeek[
                                                                          0]
                                                                  ? white
                                                                  : Color
                                                                      .fromARGB(
                                                                          255,
                                                                          0,
                                                                          35,
                                                                          65),
                                                              onChanged: (value) {
                                                                db
                                                                    .collection(
                                                                        'sundayAct')
                                                                    .doc(document
                                                                        .id)
                                                                    .update({
                                                                  'bool': value!
                                                                });
                                                              },
                                                              value: document[
                                                                  'bool'],
                                                            ),
                                                            Container(
                                                              width: 100,
                                                              height: 35,
                                                              child:
                                                                  SingleChildScrollView(
                                                                      scrollDirection:
                                                                          Axis.vertical,
                                                                      child: Text(
                                                                        document[
                                                                            'Task'],
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              20,
                                                                          decoration: document['bool']
                                                                              ? TextDecoration.lineThrough
                                                                              : TextDecoration.none,
                                                                        ),
                                                                      )),
                                                            ),
                                                            Column(
                                                              children: [
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    showDialog(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (BuildContext
                                                                                context) {
                                                                          return AlertDialog(
                                                                            shape:
                                                                                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                                                            backgroundColor: Color.fromARGB(
                                                                                255,
                                                                                0,
                                                                                35,
                                                                                65),
                                                                            content:
                                                                                SingleChildScrollView(
                                                                              scrollDirection:
                                                                                  Axis.vertical,
                                                                              child:
                                                                                  const Text(
                                                                                'Are You Sure To Continue?',
                                                                                style: TextStyle(color: white),
                                                                              ),
                                                                            ),
                                                                            actions: <Widget>[
                                                                              ElevatedButton(
                                                                                child: const Text('Delete'),
                                                                                onPressed: () {
                                                                                  db.collection('sundayAct').doc(user!.uid).collection("datas").doc(document.id).delete();
                                                                                  Navigator.of(context).pop();
                                                                                },
                                                                                style: ButtonStyle(
                                                                                  backgroundColor: WidgetStateProperty.all(Color.fromARGB(255, 63, 63, 63)),
                                                                                  foregroundColor: WidgetStateProperty.all(white),
                                                                                  shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                                                                                  overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
                                                                                    if (states.contains(WidgetState.pressed)) return black;
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
                                                                                  backgroundColor: WidgetStateProperty.all(Color.fromARGB(255, 0, 9, 94)),
                                                                                  foregroundColor: WidgetStateProperty.all(white),
                                                                                  shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                                                                                  overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
                                                                                    if (states.contains(WidgetState.pressed)) return black;
                                                                                    return null; // <-- Splash color
                                                                                  }),
                                                                                ),
                                                                              )
                                                                            ],
                                                                          );
                                                                        });
                                                                  },
                                                                  child: Icon(
                                                                    Icons
                                                                        .delete_outline_rounded,
                                                                    size: 40,
                                                                    color: red,
                                                                  ),
                                                                ),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    showDialog(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (BuildContext
                                                                                context) {
                                                                          return AlertDialog(
                                                                            shape:
                                                                                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                                                            title:
                                                                                const Text('Add a task to your list'),
                                                                            content:
                                                                                Form(
                                                                              key:
                                                                                  _formKey,
                                                                              child:
                                                                                  TextField(
                                                                                controller: dailyActControllerText,
                                                                                keyboardType: TextInputType.multiline,
                                                                                maxLines: 4,
                                                                                decoration: const InputDecoration(hintText: 'Enter task here'),
                                                                              ),
                                                                            ),
                                                                            actions: <Widget>[
                                                                              ElevatedButton(
                                                                                child: const Text('Update'),
                                                                                onPressed: () {
                                                                                  Navigator.of(context).pop();
                                                                                  showDialog(
                                                                                      context: context,
                                                                                      builder: (BuildContext context) {
                                                                                        return AlertDialog(
                                                                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
                                                                                              child: const Text('Okay'),
                                                                                              onPressed: () async {
                                                                                                await db.collection("sundayAct").doc(user!.uid).collection("datas").doc(document.id).update({
                                                                                                  'Task': dailyActControllerText.text,
                                                                                                  'jam': jam,
                                                                                                  'bool': false,
                                                                                                });
      
                                                                                                Navigator.of(context).pop();
                                                                                                ScaffoldMessenger.of(context).showSnackBar(
                                                                                                  SnackBar(
                                                                                                    backgroundColor: Color.fromARGB(255, 0, 35, 65),
                                                                                                    width: 200,
                                                                                                    content: Center(
                                                                                                      child: Container(
                                                                                                        color: Color.fromARGB(255, 0, 35, 65),
                                                                                                        height: 20,
                                                                                                        child: const Text(
                                                                                                          'Data Updated Successfully',
                                                                                                          style: TextStyle(color: white),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                    behavior: SnackBarBehavior.floating,
                                                                                                    elevation: 0,
                                                                                                  ),
                                                                                                );
                                                                                              },
                                                                                              style: ButtonStyle(
                                                                                                backgroundColor: WidgetStateProperty.all(Color.fromARGB(255, 63, 63, 63)),
                                                                                                foregroundColor: WidgetStateProperty.all(white),
                                                                                                shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                                                                                                overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
                                                                                                  if (states.contains(WidgetState.pressed)) return black;
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
                                                                                                backgroundColor: WidgetStateProperty.all(Color.fromARGB(255, 0, 9, 94)),
                                                                                                foregroundColor: WidgetStateProperty.all(white),
                                                                                                shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                                                                                                overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
                                                                                                  if (states.contains(WidgetState.pressed)) return black;
                                                                                                  return null; // <-- Splash color
                                                                                                }),
                                                                                              ),
                                                                                            )
                                                                                          ],
                                                                                        );
                                                                                      });
                                                                                },
                                                                                style: ButtonStyle(
                                                                                  backgroundColor: WidgetStateProperty.all(Color.fromARGB(255, 0, 9, 94)),
                                                                                  foregroundColor: WidgetStateProperty.all(white),
                                                                                  shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                                                                                  overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
                                                                                    if (states.contains(WidgetState.pressed)) return black;
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
                                                                                  backgroundColor: WidgetStateProperty.all(Color.fromARGB(255, 0, 9, 94)),
                                                                                  foregroundColor: WidgetStateProperty.all(white),
                                                                                  shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                                                                                  overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
                                                                                    if (states.contains(WidgetState.pressed)) return black;
                                                                                    return null; // <-- Splash color
                                                                                  }),
                                                                                ),
                                                                              )
                                                                            ],
                                                                          );
                                                                        });
                                                                  },
                                                                  child: Icon(
                                                                    Icons
                                                                        .edit_attributes_rounded,
                                                                    size: 40,
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            0,
                                                                            35,
                                                                            65),
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            }),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                        ],
                      )
                    : index == 1
                        ? Column(
                            children: [
                              Container(
                                child: Container(
                                  height: 150,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color:
                                              Color.fromARGB(255, 214, 214, 214),
                                          spreadRadius: 0,
                                          blurRadius: 3,
                                          offset: Offset(
                                              0, 3), // changes position of shadow
                                        ),
                                      ],
                                      color: day == daysOnWeek[1]
                                          ? Color.fromARGB(255, 0, 35, 65)
                                          : white),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          day == daysOnWeek[1]
                                              ? 'Today'
                                              : daysOnWeek[1],
                                          style: TextStyle(
                                              color: day == daysOnWeek[1]
                                                  ? white
                                                  : Color.fromARGB(
                                                      255, 0, 35, 65),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25),
                                        ),
                                        SingleChildScrollView(
                                          scrollDirection: Axis.vertical,
                                          child: Container(
                                            height: 100,
                                            child: StreamBuilder<
                                                    QuerySnapshot<
                                                        Map<String, dynamic>>>(
                                                stream: db10,
                                                builder: (context, snapshot) {
                                                  if (snapshot.data == null) {
                                                    return Center(
                                                        child:
                                                            CircularProgressIndicator());
                                                  }
                                                  if (snapshot
                                                          .data!.docs.length ==
                                                      0) {
                                                    return Center(
                                                        child: Row(children: [
                                                      Text(
                                                        " Tap",
                                                        style: TextStyle(
                                                          color: day ==
                                                                  daysOnWeek[1]
                                                              ? white
                                                              : Color.fromARGB(
                                                                  255, 0, 35, 65),
                                                        ),
                                                      ),
                                                      Icon(
                                                        Icons.add,
                                                        color: day ==
                                                                daysOnWeek[1]
                                                            ? white
                                                            : Color.fromARGB(
                                                                255, 0, 35, 65),
                                                      ),
                                                      Text(
                                                        "Icon For Add",
                                                        style: TextStyle(
                                                          color: day ==
                                                                  daysOnWeek[1]
                                                              ? white
                                                              : Color.fromARGB(
                                                                  255, 0, 35, 65),
                                                        ),
                                                      )
                                                    ]));
                                                  }
      
                                                  return ListView.builder(
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    itemCount: snapshot
                                                        .data!.docs.length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      DocumentSnapshot document =
                                                          snapshot
                                                              .data!.docs[index];
                                                      return SingleChildScrollView(
                                                        scrollDirection:
                                                            Axis.vertical,
                                                        child: Container(
                                                          padding:
                                                              EdgeInsets.all(3),
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .all(Radius
                                                                          .circular(
                                                                              10)),
                                                              color:
                                                                  Color.fromARGB(
                                                                      255,
                                                                      247,
                                                                      247,
                                                                      247),
                                                            ),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: [
                                                                Checkbox(
                                                                  checkColor: day ==
                                                                          daysOnWeek[
                                                                              1]
                                                                      ? Color
                                                                          .fromARGB(
                                                                              255,
                                                                              0,
                                                                              35,
                                                                              65)
                                                                      : white,
                                                                  shape:
                                                                      CircleBorder(),
                                                                  activeColor: day ==
                                                                          daysOnWeek[
                                                                              1]
                                                                      ? white
                                                                      : Color
                                                                          .fromARGB(
                                                                              255,
                                                                              0,
                                                                              35,
                                                                              65),
                                                                  onChanged:
                                                                      (value) {
                                                                    db
                                                                        .collection(
                                                                            'mondayAct')
                                                                        .doc(document
                                                                            .id)
                                                                        .update({
                                                                      'bool':
                                                                          value!
                                                                    });
                                                                  },
                                                                  value: document[
                                                                      'bool'],
                                                                ),
                                                                Container(
                                                                  width: 100,
                                                                  height: 35,
                                                                  child:
                                                                      SingleChildScrollView(
                                                                          scrollDirection:
                                                                              Axis
                                                                                  .vertical,
                                                                          child:
                                                                              Text(
                                                                            document[
                                                                                'Task'],
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize:
                                                                                  20,
                                                                              decoration: document['bool']
                                                                                  ? TextDecoration.lineThrough
                                                                                  : TextDecoration.none,
                                                                            ),
                                                                          )),
                                                                ),
                                                                Column(
                                                                  children: [
                                                                    GestureDetector(
                                                                      onTap: () {
                                                                        showDialog(
                                                                            context:
                                                                                context,
                                                                            builder:
                                                                                (BuildContext context) {
                                                                              return AlertDialog(
                                                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
                                                                                    child: const Text('Delete'),
                                                                                    onPressed: () {
                                                                                      db.collection('mondayAct').doc(user!.uid).collection("datas").doc(document.id).delete();
                                                                                      Navigator.of(context).pop();
                                                                                    },
                                                                                    style: ButtonStyle(
                                                                                      backgroundColor: WidgetStateProperty.all(Color.fromARGB(255, 63, 63, 63)),
                                                                                      foregroundColor: WidgetStateProperty.all(white),
                                                                                      shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                                                                                      overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
                                                                                        if (states.contains(WidgetState.pressed)) return black;
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
                                                                                      backgroundColor: WidgetStateProperty.all(Color.fromARGB(255, 0, 9, 94)),
                                                                                      foregroundColor: WidgetStateProperty.all(white),
                                                                                      shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                                                                                      overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
                                                                                        if (states.contains(WidgetState.pressed)) return black;
                                                                                        return null; // <-- Splash color
                                                                                      }),
                                                                                    ),
                                                                                  )
                                                                                ],
                                                                              );
                                                                            });
                                                                      },
                                                                      child: Icon(
                                                                        Icons
                                                                            .delete_outline_rounded,
                                                                        size: 40,
                                                                        color:
                                                                            red,
                                                                      ),
                                                                    ),
                                                                    GestureDetector(
                                                                      onTap: () {
                                                                        showDialog(
                                                                            context:
                                                                                context,
                                                                            builder:
                                                                                (BuildContext context) {
                                                                              return AlertDialog(
                                                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                                                                title: const Text('Add a task to your list'),
                                                                                content: Form(
                                                                                  key: _formKey,
                                                                                  child: TextField(
                                                                                    controller: dailyActControllerText,
                                                                                    keyboardType: TextInputType.multiline,
                                                                                    maxLines: 4,
                                                                                    decoration: const InputDecoration(hintText: 'Enter task here'),
                                                                                  ),
                                                                                ),
                                                                                actions: <Widget>[
                                                                                  ElevatedButton(
                                                                                    child: const Text('Update'),
                                                                                    onPressed: () {
                                                                                      Navigator.of(context).pop();
                                                                                      showDialog(
                                                                                          context: context,
                                                                                          builder: (BuildContext context) {
                                                                                            return AlertDialog(
                                                                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
                                                                                                  child: const Text('Okay'),
                                                                                                  onPressed: () async {
                                                                                                    await db.collection("mondayAct").doc(user!.uid).collection("datas").doc(document.id).update({
                                                                                                      'Task': dailyActControllerText.text,
                                                                                                      'jam': jam,
                                                                                                      'bool': false,
                                                                                                    });
      
                                                                                                    Navigator.of(context).pop();
                                                                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                                                                      SnackBar(
                                                                                                        backgroundColor: Color.fromARGB(255, 0, 35, 65),
                                                                                                        width: 200,
                                                                                                        content: Center(
                                                                                                          child: Container(
                                                                                                            color: Color.fromARGB(255, 0, 35, 65),
                                                                                                            height: 20,
                                                                                                            child: const Text(
                                                                                                              'Data Updated Successfully',
                                                                                                              style: TextStyle(color: white),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                        behavior: SnackBarBehavior.floating,
                                                                                                        elevation: 0,
                                                                                                      ),
                                                                                                    );
                                                                                                  },
                                                                                                  style: ButtonStyle(
                                                                                                    backgroundColor: WidgetStateProperty.all(Color.fromARGB(255, 63, 63, 63)),
                                                                                                    foregroundColor: WidgetStateProperty.all(white),
                                                                                                    shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                                                                                                    overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
                                                                                                      if (states.contains(WidgetState.pressed)) return black;
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
                                                                                                    backgroundColor: WidgetStateProperty.all(Color.fromARGB(255, 0, 9, 94)),
                                                                                                    foregroundColor: WidgetStateProperty.all(white),
                                                                                                    shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                                                                                                    overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
                                                                                                      if (states.contains(WidgetState.pressed)) return black;
                                                                                                      return null; // <-- Splash color
                                                                                                    }),
                                                                                                  ),
                                                                                                )
                                                                                              ],
                                                                                            );
                                                                                          });
                                                                                    },
                                                                                    style: ButtonStyle(
                                                                                      backgroundColor: WidgetStateProperty.all(Color.fromARGB(255, 0, 9, 94)),
                                                                                      foregroundColor: WidgetStateProperty.all(white),
                                                                                      shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                                                                                      overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
                                                                                        if (states.contains(WidgetState.pressed)) return black;
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
                                                                                      backgroundColor: WidgetStateProperty.all(Color.fromARGB(255, 0, 9, 94)),
                                                                                      foregroundColor: WidgetStateProperty.all(white),
                                                                                      shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                                                                                      overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
                                                                                        if (states.contains(WidgetState.pressed)) return black;
                                                                                        return null; // <-- Splash color
                                                                                      }),
                                                                                    ),
                                                                                  )
                                                                                ],
                                                                              );
                                                                            });
                                                                      },
                                                                      child: Icon(
                                                                        Icons
                                                                            .edit_attributes_rounded,
                                                                        size: 40,
                                                                        color: Color
                                                                            .fromARGB(
                                                                                255,
                                                                                0,
                                                                                35,
                                                                                65),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  );
                                                }),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                            ],
                          )
                        : index == 2
                            ? Column(
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        child: Container(
                                          height: 150,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Color.fromARGB(
                                                      255, 214, 214, 214),
                                                  spreadRadius: 0,
                                                  blurRadius: 3,
                                                  offset: Offset(0,
                                                      3), // changes position of shadow
                                                ),
                                              ],
                                              color: day == daysOnWeek[2]
                                                  ? Color.fromARGB(255, 0, 35, 65)
                                                  : white),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                Text(
                                                  day == daysOnWeek[2]
                                                      ? 'Today'
                                                      : daysOnWeek[2],
                                                  style: TextStyle(
                                                      color: day == daysOnWeek[2]
                                                          ? white
                                                          : Color.fromARGB(
                                                              255, 0, 35, 65),
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 25),
                                                ),
                                                SingleChildScrollView(
                                                  scrollDirection: Axis.vertical,
                                                  child: Container(
                                                    height: 100,
                                                    child: StreamBuilder<
                                                            QuerySnapshot<
                                                                Map<String,
                                                                    dynamic>>>(
                                                        stream: db11,
                                                        builder:
                                                            (context, snapshot) {
                                                          if (snapshot.data ==
                                                              null) {
                                                            return Center(
                                                                child:
                                                                    CircularProgressIndicator());
                                                          }
                                                          if (snapshot.data!.docs
                                                                  .length ==
                                                              0) {
                                                            return Center(
                                                                child: Row(
                                                                    children: [
                                                                  Text(
                                                                    " Tap",
                                                                    style:
                                                                        TextStyle(
                                                                      color: day ==
                                                                              daysOnWeek[
                                                                                  2]
                                                                          ? white
                                                                          : Color.fromARGB(
                                                                              255,
                                                                              0,
                                                                              35,
                                                                              65),
                                                                    ),
                                                                  ),
                                                                  Icon(
                                                                    Icons.add,
                                                                    color: day ==
                                                                            daysOnWeek[
                                                                                2]
                                                                        ? white
                                                                        : Color.fromARGB(
                                                                            255,
                                                                            0,
                                                                            35,
                                                                            65),
                                                                  ),
                                                                  Text(
                                                                    "Icon For Add",
                                                                    style:
                                                                        TextStyle(
                                                                      color: day ==
                                                                              daysOnWeek[
                                                                                  2]
                                                                          ? white
                                                                          : Color.fromARGB(
                                                                              255,
                                                                              0,
                                                                              35,
                                                                              65),
                                                                    ),
                                                                  )
                                                                ]));
                                                          }
      
                                                          return ListView.builder(
                                                            scrollDirection:
                                                                Axis.vertical,
                                                            itemCount: snapshot
                                                                .data!
                                                                .docs
                                                                .length,
                                                            itemBuilder:
                                                                (BuildContext
                                                                        context,
                                                                    int index) {
                                                              DocumentSnapshot
                                                                  document =
                                                                  snapshot.data!
                                                                          .docs[
                                                                      index];
                                                              return SingleChildScrollView(
                                                                scrollDirection:
                                                                    Axis.vertical,
                                                                child: Container(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(3),
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.all(
                                                                              Radius.circular(10)),
                                                                      color: Color
                                                                          .fromARGB(
                                                                              255,
                                                                              247,
                                                                              247,
                                                                              247),
                                                                    ),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceEvenly,
                                                                      children: [
                                                                        Checkbox(
                                                                          checkColor: day == daysOnWeek[2]
                                                                              ? Color.fromARGB(
                                                                                  255,
                                                                                  0,
                                                                                  35,
                                                                                  65)
                                                                              : white,
                                                                          shape:
                                                                              CircleBorder(),
                                                                          activeColor: day == daysOnWeek[2]
                                                                              ? white
                                                                              : Color.fromARGB(
                                                                                  255,
                                                                                  0,
                                                                                  35,
                                                                                  65),
                                                                          onChanged:
                                                                              (value) {
                                                                            db.collection('tuesdayAct').doc(user!.uid).collection("datas").doc(document.id).update({
                                                                              'bool':
                                                                                  value!
                                                                            });
                                                                          },
                                                                          value: document[
                                                                              'bool'],
                                                                        ),
                                                                        Container(
                                                                          width:
                                                                              100,
                                                                          height:
                                                                              35,
                                                                          child: SingleChildScrollView(
                                                                              scrollDirection: Axis.vertical,
                                                                              child: Text(
                                                                                document['Task'],
                                                                                style: TextStyle(
                                                                                  fontSize: 20,
                                                                                  decoration: document['bool'] ? TextDecoration.lineThrough : TextDecoration.none,
                                                                                ),
                                                                              )),
                                                                        ),
                                                                        Column(
                                                                          children: [
                                                                            GestureDetector(
                                                                              onTap:
                                                                                  () {
                                                                                showDialog(
                                                                                    context: context,
                                                                                    builder: (BuildContext context) {
                                                                                      return AlertDialog(
                                                                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
                                                                                            child: const Text('Delete'),
                                                                                            onPressed: () {
                                                                                              db.collection('tuesdayAct').doc(user!.uid).collection("datas").doc(document.id).delete();
                                                                                              Navigator.of(context).pop();
                                                                                            },
                                                                                            style: ButtonStyle(
                                                                                              backgroundColor: WidgetStateProperty.all(Color.fromARGB(255, 63, 63, 63)),
                                                                                              foregroundColor: WidgetStateProperty.all(white),
                                                                                              shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                                                                                              overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
                                                                                                if (states.contains(WidgetState.pressed)) return black;
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
                                                                                              backgroundColor: WidgetStateProperty.all(Color.fromARGB(255, 0, 9, 94)),
                                                                                              foregroundColor: WidgetStateProperty.all(white),
                                                                                              shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                                                                                              overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
                                                                                                if (states.contains(WidgetState.pressed)) return black;
                                                                                                return null; // <-- Splash color
                                                                                              }),
                                                                                            ),
                                                                                          )
                                                                                        ],
                                                                                      );
                                                                                    });
                                                                              },
                                                                              child:
                                                                                  Icon(
                                                                                Icons.delete_outline_rounded,
                                                                                size: 40,
                                                                                color: red,
                                                                              ),
                                                                            ),
                                                                            GestureDetector(
                                                                              onTap:
                                                                                  () {
                                                                                showDialog(
                                                                                    context: context,
                                                                                    builder: (BuildContext context) {
                                                                                      return AlertDialog(
                                                                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                                                                        title: const Text('Add a task to your list'),
                                                                                        content: Form(
                                                                                          key: _formKey,
                                                                                          child: TextField(
                                                                                            controller: dailyActControllerText,
                                                                                            keyboardType: TextInputType.multiline,
                                                                                            maxLines: 4,
                                                                                            decoration: const InputDecoration(hintText: 'Enter task here'),
                                                                                          ),
                                                                                        ),
                                                                                        actions: <Widget>[
                                                                                          ElevatedButton(
                                                                                            child: const Text('Update'),
                                                                                            onPressed: () {
                                                                                              Navigator.of(context).pop();
                                                                                              showDialog(
                                                                                                  context: context,
                                                                                                  builder: (BuildContext context) {
                                                                                                    return AlertDialog(
                                                                                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
                                                                                                          child: const Text('Okay'),
                                                                                                          onPressed: () async {
                                                                                                            await db.collection("tuesdayAct").doc(user!.uid).collection("datas").doc(document.id).update({
                                                                                                              'Task': dailyActControllerText.text,
                                                                                                              'jam': jam,
                                                                                                              'bool': false,
                                                                                                            });
      
                                                                                                            Navigator.of(context).pop();
                                                                                                            ScaffoldMessenger.of(context).showSnackBar(
                                                                                                              SnackBar(
                                                                                                                backgroundColor: Color.fromARGB(255, 0, 35, 65),
                                                                                                                width: 200,
                                                                                                                content: Center(
                                                                                                                  child: Container(
                                                                                                                    color: Color.fromARGB(255, 0, 35, 65),
                                                                                                                    height: 20,
                                                                                                                    child: const Text(
                                                                                                                      'Data Updated Successfully',
                                                                                                                      style: TextStyle(color: white),
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                ),
                                                                                                                behavior: SnackBarBehavior.floating,
                                                                                                                elevation: 0,
                                                                                                              ),
                                                                                                            );
                                                                                                          },
                                                                                                          style: ButtonStyle(
                                                                                                            backgroundColor: WidgetStateProperty.all(Color.fromARGB(255, 63, 63, 63)),
                                                                                                            foregroundColor: WidgetStateProperty.all(white),
                                                                                                            shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                                                                                                            overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
                                                                                                              if (states.contains(WidgetState.pressed)) return black;
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
                                                                                                            backgroundColor: WidgetStateProperty.all(Color.fromARGB(255, 0, 9, 94)),
                                                                                                            foregroundColor: WidgetStateProperty.all(white),
                                                                                                            shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                                                                                                            overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
                                                                                                              if (states.contains(WidgetState.pressed)) return black;
                                                                                                              return null; // <-- Splash color
                                                                                                            }),
                                                                                                          ),
                                                                                                        )
                                                                                                      ],
                                                                                                    );
                                                                                                  });
                                                                                            },
                                                                                            style: ButtonStyle(
                                                                                              backgroundColor: WidgetStateProperty.all(Color.fromARGB(255, 0, 9, 94)),
                                                                                              foregroundColor: WidgetStateProperty.all(white),
                                                                                              shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                                                                                              overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
                                                                                                if (states.contains(WidgetState.pressed)) return black;
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
                                                                                              backgroundColor: WidgetStateProperty.all(Color.fromARGB(255, 0, 9, 94)),
                                                                                              foregroundColor: WidgetStateProperty.all(white),
                                                                                              shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                                                                                              overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
                                                                                                if (states.contains(WidgetState.pressed)) return black;
                                                                                                return null; // <-- Splash color
                                                                                              }),
                                                                                            ),
                                                                                          )
                                                                                        ],
                                                                                      );
                                                                                    });
                                                                              },
                                                                              child:
                                                                                  Icon(
                                                                                Icons.edit_attributes_rounded,
                                                                                size: 40,
                                                                                color: Color.fromARGB(255, 0, 35, 65),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          );
                                                        }),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                ],
                              )
                            : index == 3
                                ? Column(
                                    children: [
                                      Container(
                                        child: Container(
                                          height: 150,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Color.fromARGB(
                                                      255, 214, 214, 214),
                                                  spreadRadius: 0,
                                                  blurRadius: 3,
                                                  offset: Offset(0,
                                                      3), // changes position of shadow
                                                ),
                                              ],
                                              color: day == daysOnWeek[3]
                                                  ? Color.fromARGB(255, 0, 35, 65)
                                                  : white),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                Text(
                                                  day == daysOnWeek[3]
                                                      ? 'Today'
                                                      : daysOnWeek[3],
                                                  style: TextStyle(
                                                      color: day == daysOnWeek[3]
                                                          ? white
                                                          : Color.fromARGB(
                                                              255, 0, 35, 65),
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 25),
                                                ),
                                                SingleChildScrollView(
                                                  scrollDirection: Axis.vertical,
                                                  child: Container(
                                                    height: 100,
                                                    child: StreamBuilder<
                                                            QuerySnapshot<
                                                                Map<String,
                                                                    dynamic>>>(
                                                        stream: db12,
                                                        builder:
                                                            (context, snapshot) {
                                                          if (snapshot.data ==
                                                              null) {
                                                            return Center(
                                                                child:
                                                                    CircularProgressIndicator());
                                                          }
                                                          if (snapshot.data!.docs
                                                                  .length ==
                                                              0) {
                                                            return Center(
                                                                child: Row(
                                                                    children: [
                                                                  Text(
                                                                    " Tap",
                                                                    style:
                                                                        TextStyle(
                                                                      color: day ==
                                                                              daysOnWeek[
                                                                                  3]
                                                                          ? white
                                                                          : Color.fromARGB(
                                                                              255,
                                                                              0,
                                                                              35,
                                                                              65),
                                                                    ),
                                                                  ),
                                                                  Icon(
                                                                    Icons.add,
                                                                    color: day ==
                                                                            daysOnWeek[
                                                                                3]
                                                                        ? white
                                                                        : Color.fromARGB(
                                                                            255,
                                                                            0,
                                                                            35,
                                                                            65),
                                                                  ),
                                                                  Text(
                                                                    "Icon For Add",
                                                                    style:
                                                                        TextStyle(
                                                                      color: day ==
                                                                              daysOnWeek[
                                                                                  3]
                                                                          ? white
                                                                          : Color.fromARGB(
                                                                              255,
                                                                              0,
                                                                              35,
                                                                              65),
                                                                    ),
                                                                  )
                                                                ]));
                                                          }
      
                                                          return ListView.builder(
                                                            scrollDirection:
                                                                Axis.vertical,
                                                            itemCount: snapshot
                                                                .data!
                                                                .docs
                                                                .length,
                                                            itemBuilder:
                                                                (BuildContext
                                                                        context,
                                                                    int index) {
                                                              DocumentSnapshot
                                                                  document =
                                                                  snapshot.data!
                                                                          .docs[
                                                                      index];
                                                              return SingleChildScrollView(
                                                                scrollDirection:
                                                                    Axis.vertical,
                                                                child: Container(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(3),
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.all(
                                                                              Radius.circular(10)),
                                                                      color: Color
                                                                          .fromARGB(
                                                                              255,
                                                                              247,
                                                                              247,
                                                                              247),
                                                                    ),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceEvenly,
                                                                      children: [
                                                                        Checkbox(
                                                                          checkColor: day == daysOnWeek[3]
                                                                              ? Color.fromARGB(
                                                                                  255,
                                                                                  0,
                                                                                  35,
                                                                                  65)
                                                                              : white,
                                                                          shape:
                                                                              CircleBorder(),
                                                                          activeColor: day == daysOnWeek[3]
                                                                              ? white
                                                                              : Color.fromARGB(
                                                                                  255,
                                                                                  0,
                                                                                  35,
                                                                                  65),
                                                                          onChanged:
                                                                              (value) {
                                                                            db.collection('wednesdayAct').doc(user!.uid).collection("datas").doc(document.id).update({
                                                                              'bool':
                                                                                  value!
                                                                            });
                                                                          },
                                                                          value: document[
                                                                              'bool'],
                                                                        ),
                                                                        Container(
                                                                          width:
                                                                              100,
                                                                          height:
                                                                              35,
                                                                          child: SingleChildScrollView(
                                                                              scrollDirection: Axis.vertical,
                                                                              child: Text(
                                                                                document['Task'],
                                                                                style: TextStyle(
                                                                                  fontSize: 20,
                                                                                  decoration: document['bool'] ? TextDecoration.lineThrough : TextDecoration.none,
                                                                                ),
                                                                              )),
                                                                        ),
                                                                        Column(
                                                                          children: [
                                                                            GestureDetector(
                                                                              onTap:
                                                                                  () {
                                                                                showDialog(
                                                                                    context: context,
                                                                                    builder: (BuildContext context) {
                                                                                      return AlertDialog(
                                                                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
                                                                                            child: const Text('Delete'),
                                                                                            onPressed: () {
                                                                                              db.collection('wednesdayAct').doc(user!.uid).collection("datas").doc(document.id).delete();
                                                                                              Navigator.of(context).pop();
                                                                                            },
                                                                                            style: ButtonStyle(
                                                                                              backgroundColor: WidgetStateProperty.all(Color.fromARGB(255, 63, 63, 63)),
                                                                                              foregroundColor: WidgetStateProperty.all(white),
                                                                                              shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                                                                                              overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
                                                                                                if (states.contains(WidgetState.pressed)) return black;
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
                                                                                              backgroundColor: WidgetStateProperty.all(Color.fromARGB(255, 0, 9, 94)),
                                                                                              foregroundColor: WidgetStateProperty.all(white),
                                                                                              shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                                                                                              overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
                                                                                                if (states.contains(WidgetState.pressed)) return black;
                                                                                                return null; // <-- Splash color
                                                                                              }),
                                                                                            ),
                                                                                          )
                                                                                        ],
                                                                                      );
                                                                                    });
                                                                              },
                                                                              child:
                                                                                  Icon(
                                                                                Icons.delete_outline_rounded,
                                                                                size: 40,
                                                                                color: red,
                                                                              ),
                                                                            ),
                                                                            GestureDetector(
                                                                              onTap:
                                                                                  () {
                                                                                showDialog(
                                                                                    context: context,
                                                                                    builder: (BuildContext context) {
                                                                                      return AlertDialog(
                                                                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                                                                        title: const Text('Add a task to your list'),
                                                                                        content: Form(
                                                                                          key: _formKey,
                                                                                          child: TextField(
                                                                                            controller: dailyActControllerText,
                                                                                            keyboardType: TextInputType.multiline,
                                                                                            maxLines: 4,
                                                                                            decoration: const InputDecoration(hintText: 'Enter task here'),
                                                                                          ),
                                                                                        ),
                                                                                        actions: <Widget>[
                                                                                          ElevatedButton(
                                                                                            child: const Text('Update'),
                                                                                            onPressed: () {
                                                                                              Navigator.of(context).pop();
                                                                                              showDialog(
                                                                                                  context: context,
                                                                                                  builder: (BuildContext context) {
                                                                                                    return AlertDialog(
                                                                                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
                                                                                                          child: const Text('Okay'),
                                                                                                          onPressed: () async {
                                                                                                            await db.collection("wednesdayAct").doc(user!.uid).collection("datas").doc(document.id).update({
                                                                                                              'Task': dailyActControllerText.text,
                                                                                                              'jam': jam,
                                                                                                              'bool': false,
                                                                                                            });
      
                                                                                                            Navigator.of(context).pop();
                                                                                                            ScaffoldMessenger.of(context).showSnackBar(
                                                                                                              SnackBar(
                                                                                                                backgroundColor: Color.fromARGB(255, 0, 35, 65),
                                                                                                                width: 200,
                                                                                                                content: Center(
                                                                                                                  child: Container(
                                                                                                                    color: Color.fromARGB(255, 0, 35, 65),
                                                                                                                    height: 20,
                                                                                                                    child: const Text(
                                                                                                                      'Data Updated Successfully',
                                                                                                                      style: TextStyle(color: white),
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                ),
                                                                                                                behavior: SnackBarBehavior.floating,
                                                                                                                elevation: 0,
                                                                                                              ),
                                                                                                            );
                                                                                                          },
                                                                                                          style: ButtonStyle(
                                                                                                            backgroundColor: WidgetStateProperty.all(Color.fromARGB(255, 63, 63, 63)),
                                                                                                            foregroundColor: WidgetStateProperty.all(white),
                                                                                                            shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                                                                                                            overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
                                                                                                              if (states.contains(WidgetState.pressed)) return black;
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
                                                                                                            backgroundColor: WidgetStateProperty.all(Color.fromARGB(255, 0, 9, 94)),
                                                                                                            foregroundColor: WidgetStateProperty.all(white),
                                                                                                            shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                                                                                                            overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
                                                                                                              if (states.contains(WidgetState.pressed)) return black;
                                                                                                              return null; // <-- Splash color
                                                                                                            }),
                                                                                                          ),
                                                                                                        )
                                                                                                      ],
                                                                                                    );
                                                                                                  });
                                                                                            },
                                                                                            style: ButtonStyle(
                                                                                              backgroundColor: WidgetStateProperty.all(Color.fromARGB(255, 0, 9, 94)),
                                                                                              foregroundColor: WidgetStateProperty.all(white),
                                                                                              shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                                                                                              overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
                                                                                                if (states.contains(WidgetState.pressed)) return black;
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
                                                                                              backgroundColor: WidgetStateProperty.all(Color.fromARGB(255, 0, 9, 94)),
                                                                                              foregroundColor: WidgetStateProperty.all(white),
                                                                                              shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                                                                                              overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
                                                                                                if (states.contains(WidgetState.pressed)) return black;
                                                                                                return null; // <-- Splash color
                                                                                              }),
                                                                                            ),
                                                                                          )
                                                                                        ],
                                                                                      );
                                                                                    });
                                                                              },
                                                                              child:
                                                                                  Icon(
                                                                                Icons.edit_attributes_rounded,
                                                                                size: 40,
                                                                                color: Color.fromARGB(255, 0, 35, 65),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          );
                                                        }),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                    ],
                                  )
                                : index == 4
                                    ? Column(
                                        children: [
                                          Container(
                                            child: Container(
                                              height: 150,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Color.fromARGB(
                                                          255, 214, 214, 214),
                                                      spreadRadius: 0,
                                                      blurRadius: 3,
                                                      offset: Offset(0,
                                                          3), // changes position of shadow
                                                    ),
                                                  ],
                                                  color: day == daysOnWeek[4]
                                                      ? Color.fromARGB(
                                                          255, 0, 35, 65)
                                                      : white),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      day == daysOnWeek[4]
                                                          ? 'Today'
                                                          : daysOnWeek[4],
                                                      style: TextStyle(
                                                          color: day ==
                                                                  daysOnWeek[4]
                                                              ? white
                                                              : Color.fromARGB(
                                                                  255, 0, 35, 65),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 25),
                                                    ),
                                                    SingleChildScrollView(
                                                      scrollDirection:
                                                          Axis.vertical,
                                                      child: Container(
                                                        height: 100,
                                                        child: StreamBuilder<
                                                                QuerySnapshot<
                                                                    Map<String,
                                                                        dynamic>>>(
                                                            stream: db13,
                                                            builder: (context,
                                                                snapshot) {
                                                              if (snapshot.data ==
                                                                  null) {
                                                                return Center(
                                                                    child:
                                                                        CircularProgressIndicator());
                                                              }
                                                              if (snapshot
                                                                      .data!
                                                                      .docs
                                                                      .length ==
                                                                  0) {
                                                                return Center(
                                                                    child: Row(
                                                                        children: [
                                                                      Text(
                                                                        " Tap",
                                                                        style:
                                                                            TextStyle(
                                                                          color: day == daysOnWeek[4]
                                                                              ? white
                                                                              : Color.fromARGB(
                                                                                  255,
                                                                                  0,
                                                                                  35,
                                                                                  65),
                                                                        ),
                                                                      ),
                                                                      Icon(
                                                                        Icons.add,
                                                                        color: day ==
                                                                                daysOnWeek[
                                                                                    4]
                                                                            ? white
                                                                            : Color.fromARGB(
                                                                                255,
                                                                                0,
                                                                                35,
                                                                                65),
                                                                      ),
                                                                      Text(
                                                                        "Icon For Add",
                                                                        style:
                                                                            TextStyle(
                                                                          color: day == daysOnWeek[4]
                                                                              ? white
                                                                              : Color.fromARGB(
                                                                                  255,
                                                                                  0,
                                                                                  35,
                                                                                  65),
                                                                        ),
                                                                      )
                                                                    ]));
                                                              }
      
                                                              return ListView
                                                                  .builder(
                                                                scrollDirection:
                                                                    Axis.vertical,
                                                                itemCount:
                                                                    snapshot
                                                                        .data!
                                                                        .docs
                                                                        .length,
                                                                itemBuilder:
                                                                    (BuildContext
                                                                            context,
                                                                        int index) {
                                                                  DocumentSnapshot
                                                                      document =
                                                                      snapshot.data!
                                                                              .docs[
                                                                          index];
                                                                  return SingleChildScrollView(
                                                                    scrollDirection:
                                                                        Axis.vertical,
                                                                    child:
                                                                        Container(
                                                                      padding:
                                                                          EdgeInsets
                                                                              .all(3),
                                                                      child:
                                                                          Container(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.all(Radius.circular(10)),
                                                                          color: Color.fromARGB(
                                                                              255,
                                                                              247,
                                                                              247,
                                                                              247),
                                                                        ),
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceEvenly,
                                                                          children: [
                                                                            Checkbox(
                                                                              checkColor: day == daysOnWeek[4]
                                                                                  ? Color.fromARGB(255, 0, 35, 65)
                                                                                  : white,
                                                                              shape:
                                                                                  CircleBorder(),
                                                                              activeColor: day == daysOnWeek[4]
                                                                                  ? white
                                                                                  : Color.fromARGB(255, 0, 35, 65),
                                                                              onChanged:
                                                                                  (value) {
                                                                                db.collection('thursdayAct').doc(user!.uid).collection("datas").doc(document.id).update({
                                                                                  'bool': value!
                                                                                });
                                                                              },
                                                                              value:
                                                                                  document['bool'],
                                                                            ),
                                                                            Container(
                                                                              width:
                                                                                  100,
                                                                              height:
                                                                                  35,
                                                                              child: SingleChildScrollView(
                                                                                  scrollDirection: Axis.vertical,
                                                                                  child: Text(
                                                                                    document['Task'],
                                                                                    style: TextStyle(
                                                                                      fontSize: 20,
                                                                                      decoration: document['bool'] ? TextDecoration.lineThrough : TextDecoration.none,
                                                                                    ),
                                                                                  )),
                                                                            ),
                                                                            Column(
                                                                              children: [
                                                                                GestureDetector(
                                                                                  onTap: () {
                                                                                    showDialog(
                                                                                        context: context,
                                                                                        builder: (BuildContext context) {
                                                                                          return AlertDialog(
                                                                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
                                                                                                child: const Text('Delete'),
                                                                                                onPressed: () {
                                                                                                  db.collection('thursdayAct').doc(user!.uid).collection("datas").doc(document.id).delete();
                                                                                                  Navigator.of(context).pop();
                                                                                                },
                                                                                                style: ButtonStyle(
                                                                                                  backgroundColor: WidgetStateProperty.all(Color.fromARGB(255, 63, 63, 63)),
                                                                                                  foregroundColor: WidgetStateProperty.all(white),
                                                                                                  shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                                                                                                  overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
                                                                                                    if (states.contains(WidgetState.pressed)) return black;
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
                                                                                                  backgroundColor: WidgetStateProperty.all(Color.fromARGB(255, 0, 9, 94)),
                                                                                                  foregroundColor: WidgetStateProperty.all(white),
                                                                                                  shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                                                                                                  overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
                                                                                                    if (states.contains(WidgetState.pressed)) return black;
                                                                                                    return null; // <-- Splash color
                                                                                                  }),
                                                                                                ),
                                                                                              )
                                                                                            ],
                                                                                          );
                                                                                        });
                                                                                  },
                                                                                  child: Icon(
                                                                                    Icons.delete_outline_rounded,
                                                                                    size: 40,
                                                                                    color: red,
                                                                                  ),
                                                                                ),
                                                                                GestureDetector(
                                                                                  onTap: () {
                                                                                    showDialog(
                                                                                        context: context,
                                                                                        builder: (BuildContext context) {
                                                                                          return AlertDialog(
                                                                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                                                                            title: const Text('Add a task to your list'),
                                                                                            content: Form(
                                                                                              key: _formKey,
                                                                                              child: TextField(
                                                                                                controller: dailyActControllerText,
                                                                                                keyboardType: TextInputType.multiline,
                                                                                                maxLines: 4,
                                                                                                decoration: const InputDecoration(hintText: 'Enter task here'),
                                                                                              ),
                                                                                            ),
                                                                                            actions: <Widget>[
                                                                                              ElevatedButton(
                                                                                                child: const Text('Update'),
                                                                                                onPressed: () {
                                                                                                  Navigator.of(context).pop();
                                                                                                  showDialog(
                                                                                                      context: context,
                                                                                                      builder: (BuildContext context) {
                                                                                                        return AlertDialog(
                                                                                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
                                                                                                              child: const Text('Okay'),
                                                                                                              onPressed: () async {
                                                                                                                await db.collection("thursdayAct").doc(user!.uid).collection("datas").doc(document.id).update({
                                                                                                                  'Task': dailyActControllerText.text,
                                                                                                                  'jam': jam,
                                                                                                                  'bool': false,
                                                                                                                });
      
                                                                                                                Navigator.of(context).pop();
                                                                                                                ScaffoldMessenger.of(context).showSnackBar(
                                                                                                                  SnackBar(
                                                                                                                    backgroundColor: Color.fromARGB(255, 0, 35, 65),
                                                                                                                    width: 200,
                                                                                                                    content: Center(
                                                                                                                      child: Container(
                                                                                                                        color: Color.fromARGB(255, 0, 35, 65),
                                                                                                                        height: 20,
                                                                                                                        child: const Text(
                                                                                                                          'Data Updated Successfully',
                                                                                                                          style: TextStyle(color: white),
                                                                                                                        ),
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                    behavior: SnackBarBehavior.floating,
                                                                                                                    elevation: 0,
                                                                                                                  ),
                                                                                                                );
                                                                                                              },
                                                                                                              style: ButtonStyle(
                                                                                                                backgroundColor: WidgetStateProperty.all(Color.fromARGB(255, 63, 63, 63)),
                                                                                                                foregroundColor: WidgetStateProperty.all(white),
                                                                                                                shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                                                                                                                overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
                                                                                                                  if (states.contains(WidgetState.pressed)) return black;
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
                                                                                                                backgroundColor: WidgetStateProperty.all(Color.fromARGB(255, 0, 9, 94)),
                                                                                                                foregroundColor: WidgetStateProperty.all(white),
                                                                                                                shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                                                                                                                overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
                                                                                                                  if (states.contains(WidgetState.pressed)) return black;
                                                                                                                  return null; // <-- Splash color
                                                                                                                }),
                                                                                                              ),
                                                                                                            )
                                                                                                          ],
                                                                                                        );
                                                                                                      });
                                                                                                },
                                                                                                style: ButtonStyle(
                                                                                                  backgroundColor: WidgetStateProperty.all(Color.fromARGB(255, 0, 9, 94)),
                                                                                                  foregroundColor: WidgetStateProperty.all(white),
                                                                                                  shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                                                                                                  overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
                                                                                                    if (states.contains(WidgetState.pressed)) return black;
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
                                                                                                  backgroundColor: WidgetStateProperty.all(Color.fromARGB(255, 0, 9, 94)),
                                                                                                  foregroundColor: WidgetStateProperty.all(white),
                                                                                                  shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                                                                                                  overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
                                                                                                    if (states.contains(WidgetState.pressed)) return black;
                                                                                                    return null; // <-- Splash color
                                                                                                  }),
                                                                                                ),
                                                                                              )
                                                                                            ],
                                                                                          );
                                                                                        });
                                                                                  },
                                                                                  child: Icon(
                                                                                    Icons.edit_attributes_rounded,
                                                                                    size: 40,
                                                                                    color: Color.fromARGB(255, 0, 35, 65),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                              );
                                                            }),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                        ],
                                      )
                                    : index == 5
                                        ? Column(
                                            children: [
                                              Container(
                                                child: Container(
                                                  height: 150,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Color.fromARGB(
                                                              255, 214, 214, 214),
                                                          spreadRadius: 0,
                                                          blurRadius: 3,
                                                          offset: Offset(0,
                                                              3), // changes position of shadow
                                                        ),
                                                      ],
                                                      color: day == daysOnWeek[5]
                                                          ? Color.fromARGB(
                                                              255, 0, 35, 65)
                                                          : white),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(8.0),
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          day == daysOnWeek[5]
                                                              ? 'Today'
                                                              : daysOnWeek[5],
                                                          style: TextStyle(
                                                              color: day ==
                                                                      daysOnWeek[
                                                                          5]
                                                                  ? white
                                                                  : Color
                                                                      .fromARGB(
                                                                          255,
                                                                          0,
                                                                          35,
                                                                          65),
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                              fontSize: 25),
                                                        ),
                                                        SingleChildScrollView(
                                                          scrollDirection:
                                                              Axis.vertical,
                                                          child: Container(
                                                            height: 100,
                                                            child: StreamBuilder<
                                                                    QuerySnapshot<
                                                                        Map<String,
                                                                            dynamic>>>(
                                                                stream: db14,
                                                                builder: (context,
                                                                    snapshot) {
                                                                  if (snapshot
                                                                          .data ==
                                                                      null) {
                                                                    return Center(
                                                                        child:
                                                                            CircularProgressIndicator());
                                                                  }
                                                                  if (snapshot
                                                                          .data!
                                                                          .docs
                                                                          .length ==
                                                                      0) {
                                                                    return Center(
                                                                        child: Row(
                                                                            children: [
                                                                          Text(
                                                                            " Tap",
                                                                            style:
                                                                                TextStyle(
                                                                              color: day == daysOnWeek[5]
                                                                                  ? white
                                                                                  : Color.fromARGB(255, 0, 35, 65),
                                                                            ),
                                                                          ),
                                                                          Icon(
                                                                            Icons
                                                                                .add,
                                                                            color: day == daysOnWeek[5]
                                                                                ? white
                                                                                : Color.fromARGB(255, 0, 35, 65),
                                                                          ),
                                                                          Text(
                                                                            "Icon For Add",
                                                                            style:
                                                                                TextStyle(
                                                                              color: day == daysOnWeek[5]
                                                                                  ? white
                                                                                  : Color.fromARGB(255, 0, 35, 65),
                                                                            ),
                                                                          )
                                                                        ]));
                                                                  }
      
                                                                  return ListView
                                                                      .builder(
                                                                    scrollDirection:
                                                                        Axis.vertical,
                                                                    itemCount:
                                                                        snapshot
                                                                            .data!
                                                                            .docs
                                                                            .length,
                                                                    itemBuilder:
                                                                        (BuildContext
                                                                                context,
                                                                            int index) {
                                                                      DocumentSnapshot
                                                                          document =
                                                                          snapshot
                                                                              .data!
                                                                              .docs[index];
                                                                      return SingleChildScrollView(
                                                                        scrollDirection:
                                                                            Axis.vertical,
                                                                        child:
                                                                            Container(
                                                                          padding:
                                                                              EdgeInsets.all(3),
                                                                          child:
                                                                              Container(
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              borderRadius:
                                                                                  BorderRadius.all(Radius.circular(10)),
                                                                              color: Color.fromARGB(
                                                                                  255,
                                                                                  247,
                                                                                  247,
                                                                                  247),
                                                                            ),
                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment:
                                                                                  MainAxisAlignment.spaceEvenly,
                                                                              children: [
                                                                                Checkbox(
                                                                                  checkColor: day == daysOnWeek[5] ? Color.fromARGB(255, 0, 35, 65) : white,
                                                                                  shape: CircleBorder(),
                                                                                  activeColor: day == daysOnWeek[5] ? white : Color.fromARGB(255, 0, 35, 65),
                                                                                  onChanged: (value) {
                                                                                    db.collection('fridayAct').doc(user!.uid).collection("datas").doc(document.id).update({
                                                                                      'bool': value!
                                                                                    });
                                                                                  },
                                                                                  value: document['bool'],
                                                                                ),
                                                                                Container(
                                                                                  width: 100,
                                                                                  height: 35,
                                                                                  child: SingleChildScrollView(
                                                                                      scrollDirection: Axis.vertical,
                                                                                      child: Text(
                                                                                        document['Task'],
                                                                                        style: TextStyle(
                                                                                          fontSize: 20,
                                                                                          decoration: document['bool'] ? TextDecoration.lineThrough : TextDecoration.none,
                                                                                        ),
                                                                                      )),
                                                                                ),
                                                                                Column(
                                                                                  children: [
                                                                                    GestureDetector(
                                                                                      onTap: () {
                                                                                        showDialog(
                                                                                            context: context,
                                                                                            builder: (BuildContext context) {
                                                                                              return AlertDialog(
                                                                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
                                                                                                    child: const Text('Delete'),
                                                                                                    onPressed: () {
                                                                                                      db.collection('fridayAct').doc(user!.uid).collection("datas").doc(document.id).delete();
                                                                                                      Navigator.of(context).pop();
                                                                                                    },
                                                                                                    style: ButtonStyle(
                                                                                                      backgroundColor: WidgetStateProperty.all(Color.fromARGB(255, 63, 63, 63)),
                                                                                                      foregroundColor: WidgetStateProperty.all(white),
                                                                                                      shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                                                                                                      overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
                                                                                                        if (states.contains(WidgetState.pressed)) return black;
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
                                                                                                      backgroundColor: WidgetStateProperty.all(Color.fromARGB(255, 0, 9, 94)),
                                                                                                      foregroundColor: WidgetStateProperty.all(white),
                                                                                                      shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                                                                                                      overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
                                                                                                        if (states.contains(WidgetState.pressed)) return black;
                                                                                                        return null; // <-- Splash color
                                                                                                      }),
                                                                                                    ),
                                                                                                  )
                                                                                                ],
                                                                                              );
                                                                                            });
                                                                                      },
                                                                                      child: Icon(
                                                                                        Icons.delete_outline_rounded,
                                                                                        size: 40,
                                                                                        color: red,
                                                                                      ),
                                                                                    ),
                                                                                    GestureDetector(
                                                                                      onTap: () {
                                                                                        showDialog(
                                                                                            context: context,
                                                                                            builder: (BuildContext context) {
                                                                                              return AlertDialog(
                                                                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                                                                                title: const Text('Add a task to your list'),
                                                                                                content: Form(
                                                                                                  key: _formKey,
                                                                                                  child: TextField(
                                                                                                    controller: dailyActControllerText,
                                                                                                    keyboardType: TextInputType.multiline,
                                                                                                    maxLines: 4,
                                                                                                    decoration: const InputDecoration(hintText: 'Enter task here'),
                                                                                                  ),
                                                                                                ),
                                                                                                actions: <Widget>[
                                                                                                  ElevatedButton(
                                                                                                    child: const Text('Update'),
                                                                                                    onPressed: () {
                                                                                                      Navigator.of(context).pop();
                                                                                                      showDialog(
                                                                                                          context: context,
                                                                                                          builder: (BuildContext context) {
                                                                                                            return AlertDialog(
                                                                                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
                                                                                                                  child: const Text('Okay'),
                                                                                                                  onPressed: () async {
                                                                                                                    await db.collection("fridayAct").doc(user!.uid).collection("datas").doc(document.id).update({
                                                                                                                      'Task': dailyActControllerText.text,
                                                                                                                      'jam': jam,
                                                                                                                      'bool': false,
                                                                                                                    });
      
                                                                                                                    Navigator.of(context).pop();
                                                                                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                                                                                      SnackBar(
                                                                                                                        backgroundColor: Color.fromARGB(255, 0, 35, 65),
                                                                                                                        width: 200,
                                                                                                                        content: Center(
                                                                                                                          child: Container(
                                                                                                                            color: Color.fromARGB(255, 0, 35, 65),
                                                                                                                            height: 20,
                                                                                                                            child: const Text(
                                                                                                                              'Data Updated Successfully',
                                                                                                                              style: TextStyle(color: white),
                                                                                                                            ),
                                                                                                                          ),
                                                                                                                        ),
                                                                                                                        behavior: SnackBarBehavior.floating,
                                                                                                                        elevation: 0,
                                                                                                                      ),
                                                                                                                    );
                                                                                                                  },
                                                                                                                  style: ButtonStyle(
                                                                                                                    backgroundColor: WidgetStateProperty.all(Color.fromARGB(255, 63, 63, 63)),
                                                                                                                    foregroundColor: WidgetStateProperty.all(white),
                                                                                                                    shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                                                                                                                    overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
                                                                                                                      if (states.contains(WidgetState.pressed)) return black;
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
                                                                                                                    backgroundColor: WidgetStateProperty.all(Color.fromARGB(255, 0, 9, 94)),
                                                                                                                    foregroundColor: WidgetStateProperty.all(white),
                                                                                                                    shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                                                                                                                    overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
                                                                                                                      if (states.contains(WidgetState.pressed)) return black;
                                                                                                                      return null; // <-- Splash color
                                                                                                                    }),
                                                                                                                  ),
                                                                                                                )
                                                                                                              ],
                                                                                                            );
                                                                                                          });
                                                                                                    },
                                                                                                    style: ButtonStyle(
                                                                                                      backgroundColor: WidgetStateProperty.all(Color.fromARGB(255, 0, 9, 94)),
                                                                                                      foregroundColor: WidgetStateProperty.all(white),
                                                                                                      shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                                                                                                      overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
                                                                                                        if (states.contains(WidgetState.pressed)) return black;
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
                                                                                                      backgroundColor: WidgetStateProperty.all(Color.fromARGB(255, 0, 9, 94)),
                                                                                                      foregroundColor: WidgetStateProperty.all(white),
                                                                                                      shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                                                                                                      overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
                                                                                                        if (states.contains(WidgetState.pressed)) return black;
                                                                                                        return null; // <-- Splash color
                                                                                                      }),
                                                                                                    ),
                                                                                                  )
                                                                                                ],
                                                                                              );
                                                                                            });
                                                                                      },
                                                                                      child: Icon(
                                                                                        Icons.edit_attributes_rounded,
                                                                                        size: 40,
                                                                                        color: Color.fromARGB(255, 0, 35, 65),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                )
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      );
                                                                    },
                                                                  );
                                                                }),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                            ],
                                          )
                                        : Column(
                                            children: [
                                              Container(
                                                child: Container(
                                                  height: 150,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Color.fromARGB(
                                                              255, 214, 214, 214),
                                                          spreadRadius: 0,
                                                          blurRadius: 3,
                                                          offset: Offset(0,
                                                              3), // changes position of shadow
                                                        ),
                                                      ],
                                                      color: day == daysOnWeek[6]
                                                          ? Color.fromARGB(
                                                              255, 0, 35, 65)
                                                          : white),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(8.0),
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          day == daysOnWeek[6]
                                                              ? 'Today'
                                                              : daysOnWeek[6],
                                                          style: TextStyle(
                                                            color: day ==
                                                                    daysOnWeek[6]
                                                                ? white
                                                                : Color.fromARGB(
                                                                    255,
                                                                    0,
                                                                    35,
                                                                    65),
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 25,
                                                          ),
                                                        ),
                                                        SingleChildScrollView(
                                                          scrollDirection:
                                                              Axis.vertical,
                                                          child: Container(
                                                            height: 100,
                                                            child: StreamBuilder<
                                                                    QuerySnapshot<
                                                                        Map<String,
                                                                            dynamic>>>(
                                                                stream: db15,
                                                                builder: (context,
                                                                    snapshot) {
                                                                  if (snapshot
                                                                          .data ==
                                                                      null) {
                                                                    return Center(
                                                                        child:
                                                                            CircularProgressIndicator());
                                                                  }
                                                                  if (snapshot
                                                                          .data!
                                                                          .docs
                                                                          .length ==
                                                                      0) {
                                                                    return Center(
                                                                        child: Row(
                                                                            children: [
                                                                          Text(
                                                                            " Tap",
                                                                            style:
                                                                                TextStyle(
                                                                              color: day == daysOnWeek[6]
                                                                                  ? white
                                                                                  : Color.fromARGB(255, 0, 35, 65),
                                                                            ),
                                                                          ),
                                                                          Icon(
                                                                            Icons
                                                                                .add,
                                                                            color: day == daysOnWeek[6]
                                                                                ? white
                                                                                : Color.fromARGB(255, 0, 35, 65),
                                                                          ),
                                                                          Text(
                                                                            "Icon For Add",
                                                                            style:
                                                                                TextStyle(
                                                                              color: day == daysOnWeek[6]
                                                                                  ? white
                                                                                  : Color.fromARGB(255, 0, 35, 65),
                                                                            ),
                                                                          )
                                                                        ]));
                                                                  }
      
                                                                  return ListView
                                                                      .builder(
                                                                    scrollDirection:
                                                                        Axis.vertical,
                                                                    itemCount:
                                                                        snapshot
                                                                            .data!
                                                                            .docs
                                                                            .length,
                                                                    itemBuilder:
                                                                        (BuildContext
                                                                                context,
                                                                            int index) {
                                                                      DocumentSnapshot
                                                                          document =
                                                                          snapshot
                                                                              .data!
                                                                              .docs[index];
                                                                      return SingleChildScrollView(
                                                                        scrollDirection:
                                                                            Axis.vertical,
                                                                        child:
                                                                            Container(
                                                                          padding:
                                                                              EdgeInsets.all(3),
                                                                          child:
                                                                              Container(
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              borderRadius:
                                                                                  BorderRadius.all(Radius.circular(10)),
                                                                              color: Color.fromARGB(
                                                                                  255,
                                                                                  247,
                                                                                  247,
                                                                                  247),
                                                                            ),
                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment:
                                                                                  MainAxisAlignment.spaceEvenly,
                                                                              children: [
                                                                                Checkbox(
                                                                                  checkColor: day == daysOnWeek[6] ? Color.fromARGB(255, 0, 35, 65) : white,
                                                                                  shape: CircleBorder(),
                                                                                  activeColor: day == daysOnWeek[6] ? white : Color.fromARGB(255, 0, 35, 65),
                                                                                  onChanged: (value) {
                                                                                    db.collection('saturdayAct').doc(user!.uid).collection("datas").doc(document.id).update({
                                                                                      'bool': value!
                                                                                    });
                                                                                  },
                                                                                  value: document['bool'],
                                                                                ),
                                                                                Container(
                                                                                  width: 100,
                                                                                  height: 35,
                                                                                  child: SingleChildScrollView(
                                                                                      scrollDirection: Axis.vertical,
                                                                                      child: Text(
                                                                                        document['Task'],
                                                                                        style: TextStyle(
                                                                                          fontSize: 20,
                                                                                          decoration: document['bool'] ? TextDecoration.lineThrough : TextDecoration.none,
                                                                                        ),
                                                                                      )),
                                                                                ),
                                                                                Column(
                                                                                  children: [
                                                                                    GestureDetector(
                                                                                      onTap: () {
                                                                                        showDialog(
                                                                                            context: context,
                                                                                            builder: (BuildContext context) {
                                                                                              return AlertDialog(
                                                                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
                                                                                                    child: const Text('Delete'),
                                                                                                    onPressed: () {
                                                                                                      db.collection('saturdayAct').doc(user!.uid).collection("datas").doc(document.id).delete();
                                                                                                      Navigator.of(context).pop();
                                                                                                    },
                                                                                                    style: ButtonStyle(
                                                                                                      backgroundColor: WidgetStateProperty.all(Color.fromARGB(255, 63, 63, 63)),
                                                                                                      foregroundColor: WidgetStateProperty.all(white),
                                                                                                      shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                                                                                                      overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
                                                                                                        if (states.contains(WidgetState.pressed)) return black;
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
                                                                                                      backgroundColor: WidgetStateProperty.all(Color.fromARGB(255, 0, 9, 94)),
                                                                                                      foregroundColor: WidgetStateProperty.all(white),
                                                                                                      shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                                                                                                      overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
                                                                                                        if (states.contains(WidgetState.pressed)) return black;
                                                                                                        return null; // <-- Splash color
                                                                                                      }),
                                                                                                    ),
                                                                                                  )
                                                                                                ],
                                                                                              );
                                                                                            });
                                                                                      },
                                                                                      child: Icon(
                                                                                        Icons.delete_outline_rounded,
                                                                                        size: 40,
                                                                                        color: red,
                                                                                      ),
                                                                                    ),
                                                                                    GestureDetector(
                                                                                      onTap: () {
                                                                                        showDialog(
                                                                                            context: context,
                                                                                            builder: (BuildContext context) {
                                                                                              return AlertDialog(
                                                                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                                                                                title: const Text('Add a task to your list'),
                                                                                                content: Form(
                                                                                                  key: _formKey,
                                                                                                  child: TextField(
                                                                                                    controller: dailyActControllerText,
                                                                                                    keyboardType: TextInputType.multiline,
                                                                                                    maxLines: 4,
                                                                                                    decoration: const InputDecoration(hintText: 'Enter task here'),
                                                                                                  ),
                                                                                                ),
                                                                                                actions: <Widget>[
                                                                                                  ElevatedButton(
                                                                                                    child: const Text('Update'),
                                                                                                    onPressed: () {
                                                                                                      Navigator.of(context).pop();
                                                                                                      showDialog(
                                                                                                          context: context,
                                                                                                          builder: (BuildContext context) {
                                                                                                            return AlertDialog(
                                                                                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
                                                                                                                  child: const Text('Okay'),
                                                                                                                  onPressed: () async {
                                                                                                                    await db.collection("saturdayAct").doc(user!.uid).collection("datas").doc(document.id).update({
                                                                                                                      'Task': dailyActControllerText.text,
                                                                                                                      'jam': jam,
                                                                                                                      'bool': false,
                                                                                                                    });
      
                                                                                                                    Navigator.of(context).pop();
                                                                                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                                                                                      SnackBar(
                                                                                                                        backgroundColor: Color.fromARGB(255, 0, 35, 65),
                                                                                                                        width: 200,
                                                                                                                        content: Center(
                                                                                                                          child: Container(
                                                                                                                            color: Color.fromARGB(255, 0, 35, 65),
                                                                                                                            height: 20,
                                                                                                                            child: const Text(
                                                                                                                              'Data Updated Successfully',
                                                                                                                              style: TextStyle(color: white),
                                                                                                                            ),
                                                                                                                          ),
                                                                                                                        ),
                                                                                                                        behavior: SnackBarBehavior.floating,
                                                                                                                        elevation: 0,
                                                                                                                      ),
                                                                                                                    );
                                                                                                                  },
                                                                                                                  style: ButtonStyle(
                                                                                                                    backgroundColor: WidgetStateProperty.all(Color.fromARGB(255, 63, 63, 63)),
                                                                                                                    foregroundColor: WidgetStateProperty.all(white),
                                                                                                                    shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                                                                                                                    overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
                                                                                                                      if (states.contains(WidgetState.pressed)) return black;
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
                                                                                                                    backgroundColor: WidgetStateProperty.all(Color.fromARGB(255, 0, 9, 94)),
                                                                                                                    foregroundColor: WidgetStateProperty.all(white),
                                                                                                                    shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                                                                                                                    overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
                                                                                                                      if (states.contains(WidgetState.pressed)) return black;
                                                                                                                      return null; // <-- Splash color
                                                                                                                    }),
                                                                                                                  ),
                                                                                                                )
                                                                                                              ],
                                                                                                            );
                                                                                                          });
                                                                                                    },
                                                                                                    style: ButtonStyle(
                                                                                                      backgroundColor: WidgetStateProperty.all(Color.fromARGB(255, 0, 9, 94)),
                                                                                                      foregroundColor: WidgetStateProperty.all(white),
                                                                                                      shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                                                                                                      overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
                                                                                                        if (states.contains(WidgetState.pressed)) return black;
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
                                                                                                      backgroundColor: WidgetStateProperty.all(Color.fromARGB(255, 0, 9, 94)),
                                                                                                      foregroundColor: WidgetStateProperty.all(white),
                                                                                                      shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                                                                                                      overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
                                                                                                        if (states.contains(WidgetState.pressed)) return black;
                                                                                                        return null; // <-- Splash color
                                                                                                      }),
                                                                                                    ),
                                                                                                  )
                                                                                                ],
                                                                                              );
                                                                                            });
                                                                                      },
                                                                                      child: Icon(
                                                                                        Icons.edit_attributes_rounded,
                                                                                        size: 40,
                                                                                        color: Color.fromARGB(255, 0, 35, 65),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                )
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      );
                                                                    },
                                                                  );
                                                                }),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                            ],
                                          );
              })),
        ),
      ),
    );
  }
}
