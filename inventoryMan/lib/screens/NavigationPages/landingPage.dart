import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'sidebar/sidebar_layout.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventoryMan/appDrawer/DrawerCode.dart';
// import 'package:inventoryMan/models/inventoryList.dart';
import 'package:inventoryMan/screens/Login.dart';
import 'package:inventoryMan/screens/NavigationPages/AddInventory.dart';
import 'package:inventoryMan/screens/NavigationPages/EditEventoryItems.dart';
import 'package:inventoryMan/screens/NavigationPages/InventroyList.dart';
import 'package:inventoryMan/screens/NavigationPages/ViewItemSupplier.dart';
import 'package:inventoryMan/screens/NavigationPages/ViewData.dart';
import 'package:inventoryMan/util/theme_config.dart';
import 'package:page_transition/page_transition.dart';

void main() => runApp(MaterialApp(home: LandingPage()));

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int _selectedIndex = 0;
  final List<Widget> _children = [
    AddInventory(),
    EditEventoryItems(),
    InventoryList(),
    ViewItemSupplier(),
    ViewData(),
  ];

  final _pageController = PageController();
  Color color = Colors.black;

  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeConfig.lightAccent,
        // title: Text("Inventory Management"),
        // leading: Padding(
        //   padding: const EdgeInsets.only(left: 8.0),
        //   // child: Image.asset(
        //   //   'images/logo1.png',
        //   // ),
        // ),
        // backgroundColor: Colors.black,
        elevation: 10,
        // title: Image.asset(
        //   'images/invent.png',
        //   fit: BoxFit.contain,
        //   height: 50,
        // ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.exit_to_app,
                color: ThemeConfig.lightPrimary,
              ),
              onPressed: () {
                return showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Center(
                          child: Text('Logout?'),
                        ),
                        content: Text('Are you sure you wanna log out?'),
                        actions: <Widget>[
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            onPressed: () async {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      child: LoginPage(),
                                      type: PageTransitionType.rightToLeft));
                              // FirebaseAuth.instance.signOut();
                            },
                            color: ThemeConfig.lightAccent,
                            child: Text(
                              'Confirm',
                              style: TextStyle(color: ThemeConfig.lightPrimary),
                            ),
                          )
                        ],
                      );
                    });
              })
        ],
      ),
      backgroundColor: ThemeConfig.lightPrimary,
      drawer: DrawerCode(),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        height: 55.0,
        items: <Widget>[
          Icon(
            Icons.add,
            size: 30,
            color: ThemeConfig.lightPrimary,
          ),
          Icon(
            Icons.edit,
            size: 30,
            color: ThemeConfig.lightPrimary,
          ),
          Icon(
            Icons.list,
            size: 30,
            color: ThemeConfig.lightPrimary,
          ),
          Icon(
            Icons.remove_red_eye_rounded,
            size: 30,
            color: ThemeConfig.lightPrimary,
          ),
          Icon(
            Icons.add_chart,
            size: 30,
            color: ThemeConfig.lightPrimary,
          ),
          // Icon(Icons.call_split, size: 30),
        ],
        color: ThemeConfig.lightAccent,
        buttonBackgroundColor: ThemeConfig.lightAccent,
        backgroundColor: ThemeConfig.lightPrimary,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 400),
        onTap: (index) {
          setState(() {
            _pageController.jumpToPage(index);
          });
        },
      ),
      body: PageView(
        pageSnapping: true,
        controller: _pageController,
        children: _children,
        // onPageChanged: (int index) {
        //   setState(() {
        //     _selectedIndex = index;
        //     _pageController.jumpToPage(index);
        //   });
        // },
      ),
    );
  }
}
