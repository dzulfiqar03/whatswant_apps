import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:whatswant/assets/Colors/colors.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  User? user = FirebaseAuth.instance.currentUser;
  var jam = '';
  void startJam() {
    Timer.periodic(new Duration(seconds: 1), (timer) {
      var tgl = new DateTime.now();
      var formatedjam = new DateFormat.Hms().format(tgl);

      jam = formatedjam;
    });
  }

  final List<String> hour = <String>[];
  final List<String> wdgTxt = <String>[];
  final _formKey = GlobalKey<FormState>();

  final List<Widget> wdgNotes = <Widget>[];
 
  final addTitle = TextEditingController();
  final addNotes = TextEditingController();
  final db = FirebaseFirestore.instance;
  @override
  void initState() {
    startJam();
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notes',
          textAlign: TextAlign.center,
          style: TextStyle(color: white),
        ),
        shadowColor: Color.fromARGB(255, 255, 255, 255),
        backgroundColor: Color.fromARGB(255, 0, 35, 65),
      ),
      backgroundColor: white,
      body: ListView(
        children: [
          Container(
            height: MediaQuery.sizeOf(context).height,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Container(
                      height: MediaQuery.sizeOf(context).height,
                      child: Column(children: _getWdg()),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      
      
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom:8.0),
        child: ElevatedButton(
          style: ButtonStyle(
            shape: WidgetStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100))),
            backgroundColor: WidgetStateProperty.all(
                Color.fromARGB(255, 0, 35, 65)), // <-- Button color
            overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
              if (states.contains(WidgetState.pressed)) return white;
              return null; // <-- Splash color
            }),
          ),
          onPressed: () {
            _displayAlertDialog(context);
          },
          child: Container(
            width: 130,
            height: 50,
            padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: Row(
              children: [
                Icon(Icons.add),
                Text(
                  "Add Notes",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }

  Widget _bldWidget() { Stream<QuerySnapshot<Map<String, dynamic>>> dbNotes =
      FirebaseFirestore.instance.collection("noteList").doc(user!.uid)
          .collection("datas").snapshots();
    return Container(
      height: MediaQuery.sizeOf(context).height,
      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: dbNotes,
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.data!.docs.length == 0) {
              return Center(
                  child: Row(children: [
                Text(" Tap"),
                Icon(Icons.add),
                Text("Icon For Add")
              ]));
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 1.0,
                    crossAxisSpacing: 1.0,
                    childAspectRatio: 0.5),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  DocumentSnapshot document = snapshot.data!.docs[index];

                  return GestureDetector(
                    onTap: () {},
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Container(
                        padding: EdgeInsets.all(5),
                        child: Container(
                          height: 320,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: white,
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(255, 214, 214, 214),
                                spreadRadius: 0,
                                blurRadius: 3,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              )
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      width: 130,
                                      height: 60,
                                      child: SingleChildScrollView(
                                          scrollDirection: Axis.vertical,
                                          child: Container(
                                            child: Text(
                                              document['title'],
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )),
                                    ),
                                    Container(
                                      height: 5,
                                      color: Color.fromARGB(255, 0, 35, 65),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      alignment: Alignment.topLeft,
                                      width: 130,
                                      height: 204,
                                      child: SingleChildScrollView(
                                          scrollDirection: Axis.vertical,
                                          child: Text(document['notes'],
                                              textAlign: TextAlign.start,
                                              style: TextStyle(fontSize: 14))),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      alignment: Alignment.bottomRight,
                                      child: Text(
                                        document['jam'],
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                backgroundColor: Color.fromARGB(
                                                    255, 0, 35, 65),
                                                content: SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  child: const Text(
                                                    'Are You Sure To Continue?',
                                                    style:
                                                        TextStyle(color: white),
                                                  ),
                                                ),
                                                actions: <Widget>[
                                                  ElevatedButton(
                                                    child: const Text('Delete'),
                                                    onPressed: () {
                                                      db
                                                          .collection(
                                                              'noteList').doc(user!.uid)
          .collection("datas")
                                                          .doc(document.id)
                                                          .delete();

                                                      Navigator.of(context)
                                                          .pop();
                                                     },
                                                    style: ButtonStyle(
                                                      backgroundColor:
                                                          WidgetStateProperty
                                                              .all(Color
                                                                  .fromARGB(
                                                                      255,
                                                                      63,
                                                                      63,
                                                                      63)),
                                                      foregroundColor:
                                                          WidgetStateProperty
                                                              .all(white),
                                                      shape: WidgetStateProperty.all(
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20))),
                                                      overlayColor:
                                                          WidgetStateProperty
                                                              .resolveWith<
                                                                      Color?>(
                                                                  (states) {
                                                        if (states.contains(
                                                            WidgetState
                                                                .pressed))
                                                          return black;
                                                        return null; // <-- Splash color
                                                      }),
                                                    ),
                                                  ),

                                                  // Cancel button
                                                  ElevatedButton(
                                                    child: const Text('Cancel'),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    style: ButtonStyle(
                                                      backgroundColor:
                                                          WidgetStateProperty
                                                              .all(Color
                                                                  .fromARGB(
                                                                      255,
                                                                      0,
                                                                      9,
                                                                      94)),
                                                      foregroundColor:
                                                          WidgetStateProperty
                                                              .all(white),
                                                      shape: WidgetStateProperty.all(
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20))),
                                                      overlayColor:
                                                          WidgetStateProperty
                                                              .resolveWith<
                                                                      Color?>(
                                                                  (states) {
                                                        if (states.contains(
                                                            WidgetState
                                                                .pressed))
                                                          return black;
                                                        return null; // <-- Splash color
                                                      }),
                                                    ),
                                                  )
                                                ],
                                              );
                                            });
                                      },
                                      child: Icon(Icons.delete),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Dialog(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                elevation: 0,
                                                backgroundColor:
                                                    Colors.transparent,
                                                child: Container(
                                                  height: 435,
                                                  decoration: BoxDecoration(
                                                      shape:
                                                          BoxShape.rectangle),
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                          width:
                                                              double.infinity,
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10),
                                                          decoration:
                                                              BoxDecoration(
                                                            shape: BoxShape
                                                                .rectangle,
                                                            borderRadius: BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        10),
                                                                topRight: Radius
                                                                    .circular(
                                                                        10)),
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    0,
                                                                    35,
                                                                    65),
                                                          ),
                                                          child: Text(
                                                            "Create Your Notes",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: white),
                                                          )),
                                                      Container(
                                                        width: double.infinity,
                                                        padding:
                                                            EdgeInsets.all(10),
                                                        decoration:
                                                            BoxDecoration(
                                                          shape: BoxShape
                                                              .rectangle,
                                                          color: white,
                                                        ),
                                                        child: Form(
                                                          key: _formKey,
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                'Title',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              TextField(
                                                                controller:
                                                                    addTitle,
                                                                keyboardType:
                                                                    TextInputType
                                                                        .text,
                                                                maxLines: 4,
                                                                decoration: const InputDecoration(
                                                                    hintText:
                                                                        'Enter Title here',
                                                                    border:
                                                                        OutlineInputBorder()),
                                                              ),
                                                              Text(''),
                                                              Text(
                                                                'Notes',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        19,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              TextField(
                                                                controller:
                                                                    addNotes,
                                                                keyboardType:
                                                                    TextInputType
                                                                        .multiline,
                                                                maxLines: 4,
                                                                decoration: const InputDecoration(
                                                                    hintText:
                                                                        'Enter notes here',
                                                                    border:
                                                                        OutlineInputBorder()),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          ElevatedButton(
                                                            child: Padding(
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      35.0),
                                                              child: Text(
                                                                  'Update'),
                                                            ),
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                              showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (BuildContext
                                                                          context) {
                                                                    return AlertDialog(
                                                                      shape: RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(20)),
                                                                      backgroundColor:
                                                                          Color.fromARGB(
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
                                                                          style:
                                                                              TextStyle(color: white),
                                                                        ),
                                                                      ),
                                                                      actions: <Widget>[
                                                                        ElevatedButton(
                                                                          child:
                                                                              const Text('Okay'),
                                                                          onPressed:
                                                                              () {
                                                                            db.collection('noteList').doc(user!.uid)
          .collection("datas").doc(document.id).update({
                                                                              'title': addTitle.text,
                                                                              'notes': addNotes.text,
                                                                              'jam': jam,
                                                                            });

                                                                            addTitle.clear();
                                                                            addNotes.clear();
                                                                            Navigator.of(context).pop();

                                                                            ScaffoldMessenger.of(context).showSnackBar(
                                                                              SnackBar(
                                                                                width: 200,
                                                                                backgroundColor: Color.fromARGB(255, 0, 35, 65),
                                                                                content: Center(
                                                                                  child: Container(
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
                                                                          style:
                                                                              ButtonStyle(
                                                                            backgroundColor: WidgetStateProperty.all(Color.fromARGB(
                                                                                255,
                                                                                63,
                                                                                63,
                                                                                63)),
                                                                            foregroundColor:
                                                                                WidgetStateProperty.all(white),
                                                                            shape:
                                                                                WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                                                                            overlayColor:
                                                                                WidgetStateProperty.resolveWith<Color?>((states) {
                                                                              if (states.contains(WidgetState.pressed))
                                                                                return black;
                                                                              return null; // <-- Splash color
                                                                            }),
                                                                          ),
                                                                        ),

                                                                        // Cancel button
                                                                        ElevatedButton(
                                                                          child:
                                                                              const Text('Cancel'),
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.of(context).pop();
                                                                          },
                                                                          style:
                                                                              ButtonStyle(
                                                                            backgroundColor: WidgetStateProperty.all(Color.fromARGB(
                                                                                255,
                                                                                0,
                                                                                9,
                                                                                94)),
                                                                            foregroundColor:
                                                                                WidgetStateProperty.all(white),
                                                                            shape:
                                                                                WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                                                                            overlayColor:
                                                                                WidgetStateProperty.resolveWith<Color?>((states) {
                                                                              if (states.contains(WidgetState.pressed))
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
                                                              backgroundColor:
                                                                  WidgetStateProperty
                                                                      .all(Color
                                                                          .fromARGB(
                                                                              255,
                                                                              0,
                                                                              9,
                                                                              94)),
                                                              foregroundColor:
                                                                  WidgetStateProperty
                                                                      .all(
                                                                          white),
                                                              shape: WidgetStateProperty.all(
                                                                  RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.only(
                                                                              bottomLeft: Radius.circular(20)))),
                                                              overlayColor: WidgetStateProperty
                                                                  .resolveWith<
                                                                          Color?>(
                                                                      (states) {
                                                                if (states.contains(
                                                                    WidgetState
                                                                        .pressed))
                                                                  return black;
                                                                return null; // <-- Splash color
                                                              }),
                                                            ),
                                                          ),
                                                          ElevatedButton(
                                                            child: Padding(
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      35.0),
                                                              child: Text(
                                                                  'Cancel'),
                                                            ),
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            style: ButtonStyle(
                                                              backgroundColor:
                                                                  WidgetStateProperty.all(
                                                                      Color.fromARGB(
                                                                          255,
                                                                          63,
                                                                          63,
                                                                          63)),
                                                              foregroundColor:
                                                                  WidgetStateProperty
                                                                      .all(
                                                                          white),
                                                              shape: WidgetStateProperty.all(
                                                                  RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.only(
                                                                              bottomRight: Radius.circular(20)))),
                                                              overlayColor: WidgetStateProperty
                                                                  .resolveWith<
                                                                          Color?>(
                                                                      (states) {
                                                                if (states.contains(
                                                                    WidgetState
                                                                        .pressed))
                                                                  return black;
                                                                return null; // <-- Splash color
                                                              }),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      // Cancel button
                                                    ],
                                                  ),
                                                ),
                                              );
                                            });
                                      },
                                      child: Icon(Icons.edit),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }),
    );
  }

  List<Widget> _getWdg() {
    wdgNotes.add(_bldWidget());

    return wdgNotes;
  }

  _displayAlertDialog(BuildContext context) async {
    // alter the app state to show a dialog
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: Container(
              height: 435,
              decoration: BoxDecoration(shape: BoxShape.rectangle),
              child: Column(
                children: [
                  Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                        color: Color.fromARGB(255, 0, 35, 65),
                      ),
                      child: Text(
                        "Create Your Notes",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: white),
                      )),

                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: white,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Title',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          TextField(
                            controller: addTitle,
                            keyboardType: TextInputType.text,
                            maxLines: 4,
                            decoration: const InputDecoration(
                                hintText: 'Enter Title here',
                                border: OutlineInputBorder()),
                          ),
                          Text(''),
                          Text(
                            'Notes',
                            style: TextStyle(
                                fontSize: 19, fontWeight: FontWeight.bold),
                          ),
                          TextField(
                            controller: addNotes,
                            keyboardType: TextInputType.multiline,
                            maxLines: 4,
                            decoration: const InputDecoration(
                                hintText: 'Enter notes here',
                                border: OutlineInputBorder()),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      color: white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            style: ButtonStyle(
                              shape: WidgetStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              backgroundColor: WidgetStateProperty.all(
                                  Color.fromARGB(
                                      255, 0, 35, 65)), // <-- Button color
                              overlayColor:
                                  WidgetStateProperty.resolveWith<Color?>(
                                      (states) {
                                if (states.contains(WidgetState.pressed))
                                  return white;
                                return null; // <-- Splash color
                              }),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 28),
                              child: const Text('Add'),
                            ),
                            onPressed: () async {
                              Navigator.of(context).pop();
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      backgroundColor:
                                          Color.fromARGB(255, 0, 35, 65),
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
                                            await db
                                                .collection('noteList').doc(user!.uid)
          .collection("datas")
                                                .add({
                                              'title': addTitle.text,
                                              'notes': addNotes.text,
                                              'jam': jam,
                                            });

                                            addTitle.clear();
                                            addNotes.clear();
                                            Navigator.of(context).pop();

                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                width: 200,
                                                backgroundColor: Color.fromARGB(
                                                    255, 0, 35, 65),
                                                content: Center(
                                                  child: Container(
                                                    height: 20,
                                                    child: const Text(
                                                      'Data Added Successfully',
                                                      style: TextStyle(
                                                          color: white),
                                                    ),
                                                  ),
                                                ),
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                elevation: 0,
                                              ),
                                            );
                                          },
                                          style: ButtonStyle(
                                            backgroundColor:
                                                WidgetStateProperty.all(
                                                    Color.fromARGB(
                                                        255, 63, 63, 63)),
                                            foregroundColor:
                                                WidgetStateProperty.all(
                                                    white),
                                            shape: WidgetStateProperty.all(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20))),
                                            overlayColor: WidgetStateProperty
                                                .resolveWith<Color?>((states) {
                                              if (states.contains(
                                                  WidgetState.pressed))
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
                                                    Color.fromARGB(
                                                        255, 0, 9, 94)),
                                            foregroundColor:
                                                WidgetStateProperty.all(
                                                    white),
                                            shape: WidgetStateProperty.all(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20))),
                                            overlayColor: WidgetStateProperty
                                                .resolveWith<Color?>((states) {
                                              if (states.contains(
                                                  WidgetState.pressed))
                                                return black;
                                              return null; // <-- Splash color
                                            }),
                                          ),
                                        )
                                      ],
                                    );
                                  });
                            }),
                        ElevatedButton(
                          style: ButtonStyle(
                            shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            backgroundColor: WidgetStateProperty.all(
                                Color.fromARGB(
                                    255, 255, 255, 255)), // <-- Button color
                            overlayColor:
                                WidgetStateProperty.resolveWith<Color?>(
                                    (states) {
                              if (states.contains(WidgetState.pressed))
                                return Color.fromARGB(255, 0, 35, 65);
                              return null; // <-- Splash color
                            }),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 28),
                            child: const Text(
                              'Cancel',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 35, 65)),
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    ),
                  ),
                  // Cancel button
                ],
              ),
            ),
          );
        });
  }
}
