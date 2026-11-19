import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatswant/assets/Colors/colors.dart';

class DatabasePage extends StatefulWidget {
  const DatabasePage({super.key});

  @override
  State<DatabasePage> createState() => _DatabasePageState();
}

final db1 = FirebaseFirestore.instance.collection("usersRegister").snapshots();
final db2 =
    FirebaseFirestore.instance.collection("googleSignInUser").snapshots();
User? user = FirebaseAuth.instance.currentUser;

class _DatabasePageState extends State<DatabasePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Database'),
        backgroundColor: Color.fromARGB(255, 0, 35, 65),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    Text(
                      'SignIn With Email',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 35, 65)),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Color.fromARGB(255, 0, 35, 65), width: 2)),
                      width: MediaQuery.sizeOf(context).width * 0.7,
                      height: MediaQuery.sizeOf(context).height * 0.3,
                      child: StreamBuilder(
                        stream: db1,
                        builder: (context, snapshot) {
                          if (snapshot.data == null) {
                            return Center(child: CircularProgressIndicator());
                          }

                          return ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (BuildContext context, int index) {
                              DocumentSnapshot document =
                                  snapshot.data!.docs[index];
                              return GestureDetector(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Dialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          elevation: 0,
                                          backgroundColor: Colors.transparent,
                                          child: Container(
                                            height: 200,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.rectangle),
                                            child: Column(
                                              children: [
                                                Container(
                                                    width: double.infinity,
                                                    padding: EdgeInsets.all(10),
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.rectangle,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(10),
                                                              topRight: Radius
                                                                  .circular(
                                                                      10)),
                                                      color: Color.fromARGB(
                                                          255, 0, 35, 65),
                                                    ),
                                                    child: Text(
                                                      "Your Information",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: white),
                                                    )),
                                                Container(
                                                  width: double.infinity,
                                                  padding: EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.rectangle,
                                                    color: white,
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "User Id: " +
                                                            document['uid'],
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text(
                                                        "Email: " +
                                                            document['email'],
                                                        style: TextStyle(
                                                            fontSize: 19,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                ElevatedButton(
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 120.0),
                                                    child: Text('Cancel'),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  style: ButtonStyle(
                                                    backgroundColor:
                                                        WidgetStateProperty
                                                            .all(Color.fromARGB(
                                                                255, 0, 0, 0)),
                                                    foregroundColor:
                                                        WidgetStateProperty
                                                            .all(white),
                                                    shape: WidgetStateProperty
                                                        .all(RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.only(
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            20),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        20)))),
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
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                },
                                child: ListTile(
                                  leading: Icon(Icons.people),
                                  title: Text('User ' + index.toString()),
                                  trailing: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [Text(document['name'])],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                Column(
                  children: [
                    Text(
                      'Sign in With Google',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 35, 65)),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Color.fromARGB(255, 0, 35, 65), width: 2)),
                      width: MediaQuery.sizeOf(context).width * 0.7,
                      height: MediaQuery.sizeOf(context).height * 0.3,
                      child: StreamBuilder(
                        stream: db2,
                        builder: (context, snapshot) {
                          if (snapshot.data == null) {
                            return Center(child: CircularProgressIndicator());
                          }

                          return ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (BuildContext context, int index) {
                              DocumentSnapshot document =
                                  snapshot.data!.docs[index];
                              return GestureDetector(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Dialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          elevation: 0,
                                          backgroundColor: Colors.transparent,
                                          child: Container(
                                            height: 200,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.rectangle),
                                            child: Column(
                                              children: [
                                                Container(
                                                    width: double.infinity,
                                                    padding: EdgeInsets.all(10),
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.rectangle,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(10),
                                                              topRight: Radius
                                                                  .circular(
                                                                      10)),
                                                      color: Color.fromARGB(
                                                          255, 0, 35, 65),
                                                    ),
                                                    child: Text(
                                                      "Your Information",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: white),
                                                    )),
                                                Container(
                                                  width: double.infinity,
                                                  padding: EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.rectangle,
                                                    color: white,
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "User Id: " +
                                                            document['uid'],
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text(
                                                        "Email: " +
                                                            document['email'],
                                                        style: TextStyle(
                                                            fontSize: 19,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                ElevatedButton(
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 120.0),
                                                    child: Text('Cancel'),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  style: ButtonStyle(
                                                    backgroundColor:
                                                        WidgetStateProperty
                                                            .all(Color.fromARGB(
                                                                255, 0, 0, 0)),
                                                    foregroundColor:
                                                        WidgetStateProperty
                                                            .all(white),
                                                    shape: WidgetStateProperty
                                                        .all(RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.only(
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            20),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        20)))),
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
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                },
                                child: ListTile(
                                  leading: Icon(Icons.people),
                                  title: Text('User ' + index.toString()),
                                  trailing: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [Text(document['name'])],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
