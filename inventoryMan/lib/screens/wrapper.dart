// import 'package:inventoryMan/screens/NavigationPages/Profile.dart';
import 'package:inventoryMan/screens/NavigationPages/Setting.dart';
import 'package:inventoryMan/screens/NavigationPages/landingPage.dart';
import 'package:inventoryMan/models/user.dart';
import 'package:flutter/material.dart';
import 'package:inventoryMan/screens/authenticate.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);

    // return iether home or authenticate
    if (user == null) {
      print("not auth");
      return Authenticate();
    } else {
      print("auth");
      return Setting();
    }
  }
}
