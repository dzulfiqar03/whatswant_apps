import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:whatswant/app/routes/app_pages.dart';
import 'package:whatswant/contents/Navigation/bottomNavBar_page.dart';
import 'package:whatswant/contents/provider/auth.dart';
import 'package:whatswant/contents/provider/google_sign_in.dart';

class ConnectPage extends StatefulWidget {
  const ConnectPage({super.key});
 
  @override
  State<ConnectPage> createState() => _ConnectPageState();
}
 final result = Connectivity().checkConnectivity();

class _ConnectPageState extends State<ConnectPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 0, 35, 65),
      body: Center(
        child: Column(children: [
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.2,),
          Lottie.asset("assets/svg/animation_ln5uvug4.json", width: 300, height: 300,),
          SizedBox(height: 10,),
          Text("No Internet", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          SizedBox(height: 30,),
          Container(
            child: ElevatedButton(onPressed: () {
              result == ConnectivityResult.mobile ?
              FutureBuilder<bool>(
                    future: AuthManager.isLoggedIn(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      }
                      return MultiProvider(
                        providers: [
                          ChangeNotifierProvider(
                              create: (_) => GoogleSignInProvider()),
                          ChangeNotifierProvider(
                            create: (ctx) => Auth(),
                          ),
                        ],
                        builder: (context, child) => Consumer<Auth>(
                          builder: (context, auth, child) => MaterialApp(
                            debugShowCheckedModeBanner: false,
                            home: auth.isAuth && snapshot.data == true
                                ? BottomNavBarPage()
                                : StreamBuilder(
                                    stream: FirebaseAuth.instance
                                        .authStateChanges(),
                                    builder: (context, snapshot) {
                                      return ChangeNotifierProvider(
                                        create: (context) =>
                                            GoogleSignInProvider(),
                                        child: GetMaterialApp(
                                          debugShowCheckedModeBanner: false,
                                          title: "Application",
                                          initialRoute: Routes.HOME,
                                          getPages: AppPages.routes,
                                        ),
                                      );
                                    }),
                          ),
                        ),
                      );
                    }):    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ConnectPage(),
                        ),
                      );
             

            }, child: Padding(
              padding: const EdgeInsets.symmetric(horizontal:10.0, vertical: 8),
              child: Text("Refresh"),
            )),
          )
        ]),
      ),
    );
  }
}