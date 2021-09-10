import 'package:inventoryMan/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on firebase user
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged
        //.map((FirebaseUser user) => _userFromFirebaseUser(user));
        .map(_userFromFirebaseUser);
  }

  // sign in anon
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      // create a new document for the user with the uid
      // await DatabaseService(uid: user.uid);

      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}

// class AuthService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   // create user ob based on firebaseUser
//   User _userFromFirebaseUser(FirebaseUser user) {
//     print("here " + user.email);
//     return user != null ? User(uid: user.uid) : null;
//   }

//   //auth chnage user stream
//   Stream<User> get user {
//     return _auth.onAuthStateChanged
//         // .map((FirebaseUser user) => _userFromFirebaseUser(user));
//         .map(_userFromFirebaseUser);
//   }

//   //sign in anonymous
//   Future signInAnon() async {
//     try {
//       AuthResult result = await _auth.signInAnonymously();
//       FirebaseUser user = result.user;
//       print("signed in");
//       return _userFromFirebaseUser(user);
//     } catch (e) {
//       print(e.toString());
//       return null;
//     }
//   }

//   //sign in with email password
//   Future signInWithEmailAndPassword(String email, String password) async {
//     // print("signing in signInWithEmailAndPassword function");
//     try {
//       // print("signing in signInWithEmailAndPassword function inside try");
//       // email = 'tevintaylor_17@yahoo.com';
//       // password = '123456789';
//       AuthResult result = await _auth.signInWithEmailAndPassword(
//           email: email, password: password);
//       print("sign in result");
//       print(result.user.email);
//       FirebaseUser user = result.user;
//       return _userFromFirebaseUser(user);
//     } catch (e) {
//       // print("signing in signInWithEmailAndPassword function inside catch");
//       print(e.toString());
//       return null;
//     }
//   }

//   //register with email & password
//   Future registerWithEmailAndPassword(
//       String username, String email, String password) async {
//     try {
//       AuthResult result = await _auth.createUserWithEmailAndPassword(
//           email: email, password: password);
//       FirebaseUser user = result.user;

//       // create a new document for the user with the uid
//       // await DatabaseService(uid: user.uid).updateUserData('default', 'default',
//       //     'default', 'default', 'default', 'default', 'default');
//       // return _userFromFirebaseUser(user);
//     } catch (e) {
//       print(e.toString());
//       return null;
//     }
//   }

//   //sign out
//   Future signOut() async {
//     try {
//       return await _auth.signOut();
//     } catch (e) {
//       print(e.toString());
//       return null;
//     }
//   }
// }
