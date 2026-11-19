import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:whatswant/assets/Colors/colors.dart';
import 'package:whatswant/contents/Database/database_page.dart';
import 'package:whatswant/contents/main_screen/home_page.dart';
import 'package:whatswant/contents/main_screen/profile_page.dart';

class BottomNavBarPage extends StatefulWidget {
  @override
  State<BottomNavBarPage> createState() => _BottomNavBarPageState();
}

class _BottomNavBarPageState extends State<BottomNavBarPage> {
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  final user = FirebaseAuth.instance.currentUser;

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final body = user?.email == "muhammaddzulfiqar03@gmail.com"
        ? <Widget>[HomePage(), ProfilePage(), DatabasePage()]
        : <Widget>[HomePage(), ProfilePage()];
    List<IconData> dataOutlined = user?.email == "muhammaddzulfiqar03@gmail.com"
        ? [Icons.home_outlined, Icons.people_outlined, Icons.data_object_sharp]
        : [
            Icons.home_outlined,
            Icons.people_outlined,
          ];
    List<IconData> dataFill = user?.email == "muhammaddzulfiqar03@gmail.com"
        ? [Icons.home, Icons.people, Icons.data_object_sharp]
        : [Icons.home, Icons.people];
    List<String> label = user?.email == "muhammaddzulfiqar03@gmail.com"
        ? ['Home', 'Profile', 'Database']
        : ['Home', 'Profile'];

    return Scaffold(
        backgroundColor: Color.fromARGB(255, 0, 35, 65),
        body: body[currentIndex],
        /*BottomNavigationBar*/
        bottomNavigationBar: user?.email == "muhammaddzulfiqar03@gmail.com"
            ? BottomNavigationBar(
                backgroundColor: Color.fromARGB(255, 0, 35, 65),
                selectedItemColor: white,
                unselectedItemColor: black,
                selectedLabelStyle:
                    TextStyle(fontWeight: FontWeight.bold, color: black),
                unselectedLabelStyle: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Color.fromARGB(255, 255, 255, 255)),
                currentIndex: currentIndex,
                onTap: (index) => setState(() => currentIndex = index),
                items: [
                  BottomNavigationBarItem(
                    icon:
                        Icon(currentIndex == 0 ? dataFill[0] : dataOutlined[0]),
                    label: label[0],
                    backgroundColor: Color.fromARGB(255, 0, 35, 65),
                  ),
                  BottomNavigationBarItem(
                    icon:
                        Icon(currentIndex == 1 ? dataFill[1] : dataOutlined[1]),
                    label: label[1],
                    backgroundColor: Color.fromARGB(255, 0, 35, 65),
                  ),
                  BottomNavigationBarItem(
                    icon:
                        Icon(currentIndex == 2 ? dataFill[2] : dataOutlined[2]),
                    label: label[2],
                    backgroundColor: Color.fromARGB(255, 0, 35, 65),
                  ),
                ],
              )
            : BottomNavigationBar(
                backgroundColor: Color.fromARGB(255, 0, 35, 65),
                selectedItemColor: white,
                unselectedItemColor: black,
                selectedLabelStyle:
                    TextStyle(fontWeight: FontWeight.bold, color: black),
                unselectedLabelStyle: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Color.fromARGB(255, 255, 255, 255)),
                currentIndex: currentIndex,
                onTap: (index) => setState(() => currentIndex = index),
                items: [
                  BottomNavigationBarItem(
                    icon:
                        Icon(currentIndex == 0 ? dataFill[0] : dataOutlined[0]),
                    label: label[0],
                    backgroundColor: Color.fromARGB(255, 0, 35, 65),
                  ),
                  BottomNavigationBarItem(
                    icon:
                        Icon(currentIndex == 1 ? dataFill[1] : dataOutlined[1]),
                    label: label[1],
                    backgroundColor: Color.fromARGB(255, 0, 35, 65),
                  ),
                ],
              ));
  }
}
