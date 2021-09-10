// import 'dart:async';
import 'package:flutter/material.dart';
// import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:inventoryMan/models/app_provider.dart';
// import 'package:inventoryMan/screens/Login.dart';
// import 'package:inventoryMan/screens/NavigationPages/landingPage.dart';
import 'package:inventoryMan/screens/SplashScreen.dart';
import 'package:inventoryMan/util/theme_config.dart';
import 'package:provider/provider.dart';
// import 'package:provider/provider.dart';

// void main() {
//   runApp(new MaterialApp(
//     debugShowCheckedModeBanner: false,
//     theme: ThemeData(),
//     home: new SplashScreen(),
//     routes: <String, WidgetBuilder>{
//       '/LandingPage': (BuildContext context) => new LandingPage()
//     },
//   ));
// }

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppProvider()),
        // ChangeNotifierProvider(create: (_) => HomeProvider()),
        // ChangeNotifierProvider(create: (_) => DetailsProvider()),
        // ChangeNotifierProvider(create: (_) => FavoritesProvider()),
        // ChangeNotifierProvider(create: (_) => GenreProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (BuildContext context, AppProvider appProvider, Widget child) {
        return MaterialApp(
          key: appProvider.key,
          debugShowCheckedModeBanner: false,
          navigatorKey: appProvider.navigatorKey,
          darkTheme: ThemeConfig.darkTheme,
          home: SplashScreen(),
        );
      },
    );
  }
}

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<AppProvider>(
//       builder: (BuildContext context, AppProvider appProvider, Widget child) {
//         return MaterialApp(
//           key: appProvider.key,
//           debugShowCheckedModeBanner: false,
//           navigatorKey: appProvider.navigatorKey,
//           title: Constants.appName,
//           theme: appProvider.theme,
//           darkTheme: ThemeConfig.darkTheme,
//           home: SplashScreen(),
//         );
//       },
//     );
//   }
// }
