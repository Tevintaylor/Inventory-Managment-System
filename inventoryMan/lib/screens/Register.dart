import 'package:inventoryMan/screens/Login.dart';
import 'package:inventoryMan/services/auth.dart';
import 'package:inventoryMan/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:inventoryMan/util/theme_config.dart';
import 'package:page_transition/page_transition.dart';
// import 'package:inventoryMan/shared/constants.dart';

class SignUpPage extends StatefulWidget {
  final Function toggleView;
  SignUpPage({this.toggleView});

  @override
  State createState() => new SignUpPageState();
}

class SignUpPageState extends State<SignUpPage>
    with SingleTickerProviderStateMixin {
  final AuthService _auth = AuthService();
  final _fromkey = GlobalKey<FormState>();
  bool loading = false;

  // text field state
  String email = '';
  String password = '';
  String username = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.black26,
            body: new Stack(
              fit: StackFit.expand,
              children: <Widget>[
                new Image(
                  image: new AssetImage("images/back.jpg"),
                  fit: BoxFit.cover,
                  color: Colors.black26,
                  colorBlendMode: BlendMode.darken,
                ),
                new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      "assets/images/icon.png",
                      height: 270,
                      width: 270,
                    ),
                    RichText(
                        text: TextSpan(children: <TextSpan>[
                      TextSpan(
                        text: "Sign Up",
                        style: TextStyle(
                            fontSize: 40,
                            color: ThemeConfig.lightPrimary.withOpacity(0.6)),
                      )
                    ])),
                    new Form(
                      key: _fromkey,
                      child: Theme(
                        data: ThemeData(
                            brightness: Brightness.dark,
                            primarySwatch: ThemeConfig.lightAccent,
                            inputDecorationTheme: new InputDecorationTheme(
                                labelStyle: new TextStyle(
                                    color: ThemeConfig.lightAccent,
                                    fontSize: 20.0))),
                        child: Container(
                          padding: const EdgeInsets.all(20.0),
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              // new TextFormField(
                              //   validator: (val) => val.isEmpty ? 'Enter a usernsme' : null,
                              //     onChanged: (val){
                              //     setState(() => username = val);
                              //   },
                              //   decoration: new InputDecoration(
                              //    labelText: "Enter Name",
                              //    ),
                              //   keyboardType: TextInputType.text,
                              //  ),

                              new TextFormField(
                                validator: (val) =>
                                    val.isEmpty ? 'Enter an email' : null,
                                onChanged: (val) {
                                  setState(() => email = val);
                                },
                                decoration: new InputDecoration(
                                  labelText: "Enter Email",
                                ),
                                keyboardType: TextInputType.emailAddress,
                              ),

                              new TextFormField(
                                validator: (val) => val.length < 6
                                    ? 'Enter a password 6+ lomg'
                                    : null,
                                onChanged: (val) {
                                  setState(() => password = val);
                                },
                                decoration: new InputDecoration(
                                  labelText: "Enter Password",
                                ),
                                keyboardType: TextInputType.text,
                                obscureText: true,
                              ),

                              new Padding(
                                  padding: const EdgeInsets.only(top: 20.0)),

                              new MaterialButton(
                                height: 40.0,
                                minWidth: 100.0,
                                color: ThemeConfig.lightAccent,
                                textColor: ThemeConfig.lightPrimary,
                                child: new Text("Sign Up"),
                                onPressed: () async {
                                  if (_fromkey.currentState.validate()) {
                                    // setState(() => loading = true);
                                    dynamic result = await _auth
                                        .registerWithEmailAndPassword(
                                            email, password);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => LoginPage()));
                                    if (result == null) {
                                      setState(() {
                                        error = 'please supply a valid email';
                                        loading = false;
                                      });
                                    }
                                  }
                                },
                                splashColor: ThemeConfig.darkPrimary,
                              ),

                              new Padding(
                                  padding: const EdgeInsets.only(top: 5.0)),

                              RichText(
                                  text: TextSpan(children: <TextSpan>[
                                TextSpan(
                                  text: error,
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.red.withOpacity(0.6)),
                                )
                              ])),

                              new Padding(
                                  padding: const EdgeInsets.only(top: 5.0)),

                              // RichText(
                              //     text: TextSpan(children: <TextSpan>[
                              //   TextSpan(
                              //     text: "have an Account already? Login\n",
                              //     style: TextStyle(
                              //         fontSize: 18,
                              //         color: Colors.white.withOpacity(0.6)),
                              //   )
                              // ])),

                              new Padding(
                                  padding: const EdgeInsets.only(top: 5.0)),

                              // new MaterialButton(
                              //   height: 40.0,
                              //   minWidth: 100.0,
                              //   color: Colors.white,
                              //   textColor: Colors.ThemeConfig.lightAccent,
                              //   child: new Text("Login"),
                              //   onPressed: () async {
                              //     // Navigator.of(context).push()
                              //     // widget.toggleView();
                              //     backToMainPage(context);
                              //   },
                              //   splashColor: Colors.brown[900],
                              // ),

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: new Container(
                                          margin: const EdgeInsets.only(
                                              left: 90.0, right: 15.0),
                                          child: Divider(
                                            color: ThemeConfig.lightPrimary,
                                          )),
                                    ),
                                    Text(
                                      "OR",
                                      style: TextStyle(
                                          color: ThemeConfig.lightPrimary),
                                    ),
                                    Expanded(
                                      child: new Container(
                                        margin: const EdgeInsets.only(
                                            left: 15.0, right: 90.0),
                                        child: Divider(
                                          color: ThemeConfig.lightPrimary,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // signInButton(context, admins),
                              RichText(
                                  text: TextSpan(children: <TextSpan>[
                                TextSpan(
                                  text: "have an Account already? Login\n",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: ThemeConfig.lightPrimary
                                          .withOpacity(0.6)),
                                )
                              ])),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 28.0, bottom: 16),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "Have an account?",
                                      style: TextStyle(
                                          color: ThemeConfig.lightPrimary),
                                    ),
                                    MaterialButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      color: ThemeConfig.lightPrimary,
                                      child: new Text(
                                        'Login here!  ',
                                        style: TextStyle(
                                          color: ThemeConfig.lightAccent,
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          PageTransition(
                                              child: LoginPage(),
                                              type: PageTransitionType
                                                  .rightToLeft),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          );
  }

  void backToMainPage(context) {
    Navigator.pop(context);
  }
}

// // animation for moving from signup to login
// Route _createRouteLogin() {
//   return PageRouteBuilder(
//     pageBuilder: (context, animation, secondaryAnimation) => LoginPage(),
//     transitionsBuilder: (context, animation, secondaryAnimation, child) {
//       var begin = Offset(0.0, 1.0);
//       var end = Offset.zero;
//       var curve = Curves.ease;

//       var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

//       return SlideTransition(
//         position: animation.drive(tween),
//         child: child,
//       );
//     },
//   );
// }
