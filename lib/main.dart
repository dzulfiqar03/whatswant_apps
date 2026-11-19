import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';
import 'package:whatswant/app/routes/app_pages.dart';
import 'package:whatswant/contents/Launcher/launch.dart';
import 'package:whatswant/contents/Navigation/bottomNavBar_page.dart';
import 'package:whatswant/contents/provider/auth.dart';
import 'package:whatswant/contents/provider/google_sign_in.dart';
import 'package:flutter/material.dart';
// Import the generated file
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'whatswants',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GoogleSignInProvider()),
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
      ],
      child: MaterialApp(
          theme: ThemeData(
            brightness: Brightness.light,
            /* light theme settings */
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            /* dark theme settings */
          ),
          themeMode: ThemeMode.dark,
          debugShowCheckedModeBanner: false,
          home: MyApp()),
    ),
  );
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  bool checked = false;
  void checks(bool check) {
    checked = check;
  }

  final result = Connectivity().checkConnectivity();
  @override
  Widget build(BuildContext context) {
    return checked
        ?  FutureBuilder<bool>(
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
                    })
             
        : FutureBuilder(
            future: Future.delayed(Duration(seconds: 5)),
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return ChangeNotifierProvider(
                    create: (context) => GoogleSignInProvider(),
                    child: Launch());
              } else {
                return FutureBuilder<bool>(
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
                    });
            
              }
            }),
          );
  }
}
