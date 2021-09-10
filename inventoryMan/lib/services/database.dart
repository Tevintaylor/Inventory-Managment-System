// import 'dart:ffi';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:inventoryMan/models/InventoryItem.dart';
import 'package:firebase_database/firebase_database.dart';

final databaseRefrence = FirebaseDatabase.instance.reference();

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
}

class FirebaseDatabaseUtil {
  DatabaseReference _counterRef;
  DatabaseReference _userRef;
  StreamSubscription<Event> _counterSubscription;
  StreamSubscription<Event> _messagesSubscription;
  FirebaseDatabase database = new FirebaseDatabase();
  int _counter;
  DatabaseError error;

  static final FirebaseDatabaseUtil _instance =
      new FirebaseDatabaseUtil.internal();

  FirebaseDatabaseUtil.internal();

  factory FirebaseDatabaseUtil() {
    return _instance;
  }

  void initState() {
    // Demonstrates configuring to the database using a file
    _counterRef = FirebaseDatabase.instance.reference().child('counter');
    // Demonstrates configuring the database directly

    _userRef = database.reference().child('Item');
    database.reference().child('counter').once().then((DataSnapshot snapshot) {
      print('Connected to second database and read ${snapshot.value}');
    });
    database.setPersistenceEnabled(true);
    database.setPersistenceCacheSizeBytes(10000000);
    _counterRef.keepSynced(true);

    _counterSubscription = _counterRef.onValue.listen((Event event) {
      error = null;
      _counter = event.snapshot.value ?? 0;
    }, onError: (Object o) {
      error = o;
    });
  }

  DatabaseError getError() {
    return error;
  }

  int getCounter() {
    return _counter;
  }

  DatabaseReference getUser() {
    return _userRef;
  }

  addUser(InventoryItem item) async {
    final TransactionResult transactionResult =
        await _counterRef.runTransaction((MutableData mutableData) async {
      mutableData.value = (mutableData.value ?? 0) + 1;

      return mutableData;
    });

    if (transactionResult.committed) {
      _userRef.push().set(<String, String>{
        'Product Code': "" + item.productCode,
        'Product Name': "" + item.procuctName,
        'Product Category': "" + item.productCategory,
        'Product Supplier': "" + item.productSuplier,
        'Product Unit Price': "" + item.productUnitPrice,
        'Product Unit Cost': "" + item.productUnitCost,
        'Product Quantity': "" + item.productQuantity,
      }).then((_) {
        print('Transaction  committed.');
      });
    } else {
      print('Transaction not committed.');
      if (transactionResult.error != null) {
        print(transactionResult.error.message);
      }
    }
  }

  void deleteUser(InventoryItem item) async {
    await _userRef.child(item.idd).remove().then((_) {
      print('Transaction  committed.');
    });
  }

  void updateUser(InventoryItem item) async {
    await _userRef.child(item.idd).update({
      'Product Code': "" + item.productCode,
      'Product Name': "" + item.procuctName,
      'Product Category': "" + item.productCategory,
      'Product Supplier': "" + item.productSuplier,
      'Product Unit Price': "" + item.productUnitPrice,
      'Product Unit Cost': "" + item.productUnitCost,
      'Product Quantity': "" + item.productQuantity,
    }).then((_) {
      print('Transaction  committed.');
    });
  }

  void dispose() {
    _messagesSubscription.cancel();
    _counterSubscription.cancel();
  }
}

// // collection reference
// final CollectionReference brewCollection =
//     Firestore.instance.collection('brews');

// Future<void> updateUserData(String sugars, String name, int strength) async {
//   return await brewCollection.document(uid).setData({
//     'sugars': sugars,
//     'name': name,
//     'strength': strength,
//   });
// }

// // brew list from snapshot
// List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
//   return snapshot.documents.map((doc) {
//     //print(doc.data);
//     return Brew(
//         name: doc.data['name'] ?? '',
//         strength: doc.data['strength'] ?? 0,
//         sugars: doc.data['sugars'] ?? '0');
//   }).toList();
// }

// // user data from snapshots
// UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
//   return UserData(
//       uid: uid,
//       name: snapshot.data['name'],
//       sugars: snapshot.data['sugars'],
//       strength: snapshot.data['strength']);
// }

// // get brews stream
// Stream<List<Brew>> get brews {
//   return brewCollection.snapshots().map(_brewListFromSnapshot);
// }

// // get user doc stream
// Stream<UserData> get userData {
//   return brewCollection.document(uid).snapshots().map(_userDataFromSnapshot);
// }
