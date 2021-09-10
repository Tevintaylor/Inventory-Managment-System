import 'package:flutter/material.dart';
import 'package:inventoryMan/screens/Login.dart';
import 'package:inventoryMan/screens/NavigationPages/AboutUs.dart';
import 'package:inventoryMan/screens/NavigationPages/Profile.dart';
import 'package:inventoryMan/screens/NavigationPages/Setting.dart';
import 'package:inventoryMan/screens/NavigationPages/landingPage.dart';
import 'package:inventoryMan/screens/map.dart';
import 'package:inventoryMan/util/theme_config.dart';
import 'package:page_transition/page_transition.dart';

class DrawerCode extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('images/appDrawer.jpg'))),
            child: Column(
              children: <Widget>[
                Positioned(
                  bottom: 12.0,
                  left: 16.0,
                  child: Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(bottom: 5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(
                              "https://www.pikpng.com/pngl/m/80-805068_my-profile-icon-blank-profile-picture-circle-clipart.png"),
                          fit: BoxFit.fill),
                    ),
                  ),
                ),
                Text(
                  "佟维",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: ThemeConfig.lightPrimary),
                ),
                Text(
                  "tevintaylor_1996@yahoo.com",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: ThemeConfig.lightPrimary),
                ),
              ],
            ),
          ),
          // Text("Main"),

          ListTile(
            leading: Icon(
              Icons.house_outlined,
              color: ThemeConfig.darkBG,
              size: 28,
            ),
            title: Text(
              "Home",
              style: TextStyle(
                  fontStyle: FontStyle.normal, color: ThemeConfig.darkBG),
            ),
            onTap: () {
              print("Chart");
              Navigator.pop(context);
              navigateToLandingPage(context);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.location_city_rounded,
              color: ThemeConfig.darkBG,
              size: 28,
            ),
            title: Text(
              "Locations",
              style: TextStyle(
                  fontStyle: FontStyle.normal, color: ThemeConfig.darkBG),
            ),
            onTap: () {
              print("Logout Users");
              Navigator.pop(context);
              navigateToMapPage(context);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.account_circle_outlined,
              color: ThemeConfig.darkBG,
              size: 28,
            ),
            title: Text(
              "Profile",
              style: TextStyle(
                  fontStyle: FontStyle.normal, color: ThemeConfig.darkBG),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Profile()));
            },
          ),
          // RichText(
          //   textScaleFactor: 1.5,
          //   text: TextSpan(
          //     text: 'System',
          //     style: DefaultTextStyle.of(context).style,
          //   ),
          // ),
          _buildDivider(),
          ListTile(
            leading: Icon(
              Icons.info_outline,
              color: ThemeConfig.darkBG,
              size: 28,
            ),
            title: Text(
              "About Us",
              style: TextStyle(
                  fontStyle: FontStyle.normal, color: ThemeConfig.darkBG),
            ),
            onTap: () {
              print("Logout Users");
              Navigator.pop(context);
              navigateToAboutUs(context);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: ThemeConfig.darkBG,
              size: 28,
            ),
            title: Text(
              "Logout",
              style: TextStyle(
                  fontStyle: FontStyle.normal, color: ThemeConfig.darkBG),
            ),
            onTap: () async {
              Navigator.push(
                  context,
                  PageTransition(
                      child: LoginPage(),
                      type: PageTransitionType.rightToLeft));
              // FirebaseAuth.instance.signOut();
            },
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              color: ThemeConfig.darkBG,
              size: 28,
            ),
            title: Text(
              "Setting",
              style: TextStyle(
                  fontStyle: FontStyle.normal, color: ThemeConfig.darkBG),
            ),
            onTap: () {
              Navigator.pop(context);
              // Navigator.pushReplacementNamed(context, '/Setting');
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Setting()));
              print("Go to Settings");
            },
          ),
        ],
      ),
    );
  }
}

Future navigateToLandingPage(context) async {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => LandingPage()));
}

Future navigateToAboutUs(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => AboutUs()));
}

Future navigateToMapPage(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => MapSample()));
}

Container _buildDivider() {
  return Container(
    margin: const EdgeInsets.symmetric(
      horizontal: 8.0,
    ),
    width: double.infinity,
    height: 3.0,
    color: ThemeConfig.darkBG,
  );
}
