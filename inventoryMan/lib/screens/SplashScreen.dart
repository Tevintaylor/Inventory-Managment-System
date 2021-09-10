import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:inventoryMan/screens/Login.dart';
import 'package:inventoryMan/screens/NavigationPages/landingPage.dart';
import 'package:inventoryMan/services/auth.dart';
import 'package:inventoryMan/util/functions.dart';
import 'package:inventoryMan/util/theme_config.dart';
import 'package:provider/provider.dart';
import 'package:inventoryMan/models/user.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool gone = false;

  startTime() async {
    return new Timer(Duration(seconds: 4), handleTimeout);
  }

  void handleTimeout() {
    changeScreen();
  }

  changeScreen() async {
    Functions.pushPageReplacement(
      context,
      LoginPage(),
    );
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: ThemeConfig.lightAccent,
      body: Center(
        child: TypewriterAnimatedTextKit(
          // new Image.asset('images/logo.png'),
          isRepeatingAnimation: true,
          speed: Duration(milliseconds: 500),
          text: ['Inventory'],
          textStyle: TextStyle(
              color: ThemeConfig.lightPrimary,
              fontSize: 75.0,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

// class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return StreamProvider<User>.value(
//       value: AuthService().user,
//       child: Scaffold(
//         backgroundColor: Colors.ThemeConfig.lightAccent,
//         body: Center(
//           child: TypewriterAnimatedTextKit(
//             // new Image.asset('images/logo.png'),
//             isRepeatingAnimation: true,
//             speed: Duration(milliseconds: 500),
//             text: ['Inventory'],
//             textStyle: TextStyle(
//                 color: ThemeConfig.lightPrimary,
//                 fontSize: 75.0,
//                 fontWeight: FontWeight.bold),
//           ),
//         ),
//       ),
//     );
//   }
// }
