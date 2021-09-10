import 'package:flutter/material.dart';
// import 'package:inventoryMan/appDrawer/DrawerCode.dart';
import 'package:inventoryMan/screens/NavigationPages/Setting.dart';
import 'package:inventoryMan/screens/NavigationPages/landingPage.dart';
import 'package:inventoryMan/util/theme_config.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeConfig.lightAccent,
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: ThemeConfig.lightPrimary,
          ),
          onPressed: () {
            navigateToSubPage(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: ThemeConfig.lightPrimary,
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => Setting()));
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 0, top: 0, right: 0),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Center(
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('images/appDrawer.jpg'),
                              fit: BoxFit.cover)),
                      child: Container(
                        width: double.infinity,
                        height: 200,
                        child: Container(
                          alignment: Alignment(0.0, 2.5),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                                "https://www.pikpng.com/pngl/m/80-805068_my-profile-icon-blank-profile-picture-circle-clipart.png"),
                            radius: 60.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              new Padding(padding: const EdgeInsets.only(top: 20.0)),
              SizedBox(
                height: 35,
              ),
              new Padding(padding: const EdgeInsets.only(top: 20.0)),
              SizedBox(
                height: 35,
              ),
              Center(
                child: Title(
                    color: ThemeConfig.darkBG,
                    child: Text(
                      "Full Name",
                    )),
              ),
              Center(
                child: Text(
                  "Tevin Taylor",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),
              new Padding(padding: const EdgeInsets.only(top: 15.0)),
              Center(
                child: Title(color: ThemeConfig.darkBG, child: Text("E-mail")),
              ),
              Center(
                child: Text(
                  "tevintaylor_17@yahoo.com",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),
              new Padding(padding: const EdgeInsets.only(top: 15.0)),
              SizedBox(
                height: 35,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future navigateToSubPage(context) async {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => LandingPage()));
}
