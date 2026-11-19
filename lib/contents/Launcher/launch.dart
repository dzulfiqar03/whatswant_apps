import 'package:flutter/material.dart';

class Launch extends StatefulWidget {
  const Launch({super.key});

  @override
  State<Launch> createState() => _LaunchState();
}

class _LaunchState extends State<Launch> {
  double _containerWidth = 100.0;
  double _containerHeight = 100.0;
  double offset = 10.0;
  double widhBord = 2;
  @override
  void initState() {
    super.initState();

    // Example: Automatically start the animation on screen load
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        widhBord = 0.5;
        offset = 25;
        _containerWidth = 200.0;
        _containerHeight = 200.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 0, 35, 65),
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AnimatedContainer(
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
          duration: Duration(seconds: 2),
          width: _containerWidth,
          height: _containerHeight,
          curve: Curves.linear,
          child: Image.asset(
                'assets/images/icon landingPage.png',
          ),
        ),
              SizedBox(
              height: 80,
            ),
              ],
            )),
      ),
    );
  }
}
