import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:inventoryMan/models/EditDialogue.dart';
import 'package:inventoryMan/models/InventoryItem.dart';
// import 'package:inventoryMan/models/InventoryItem.dart';
// import 'package:inventoryMan/models/custom_dialog_box.dart';
import 'package:inventoryMan/services/database.dart';
import 'package:inventoryMan/util/theme_config.dart';
// import 'package:inventoryMan/util/theme_config.dart';

class EditEventoryItems extends StatefulWidget {
  @override
  _EditEventoryItemsState createState() => _EditEventoryItemsState();
}

class _EditEventoryItemsState extends State<EditEventoryItems>
    implements AddUserCallback {
  bool _anchorToBottom = false;
  FirebaseDatabaseUtil databaseUtil;

  DocumentReference reference;

  @override
  void initState() {
    super.initState();
    databaseUtil = new FirebaseDatabaseUtil();
    databaseUtil.initState();
  }

  @override
  void dispose() {
    super.dispose();
    databaseUtil.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildTitle(BuildContext context) {
      return new InkWell(
        child: new Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(
                'Firebase Database',
                style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      );
    }

    // List<Widget> _buildActions() {
    //   return <Widget>[
    //     new IconButton(
    //       icon: const Icon(
    //         Icons.group_add,
    //         color: Colors.white,
    //       ),
    //       onPressed: () => showEditWidget(null, false),
    //     ),
    //   ];
    // }

    return new Scaffold(
      // appBar: new AppBar(
      //   title: _buildTitle(context),
      //   actions: _buildActions(),
      // ),
      body: new FirebaseAnimatedList(
        key: new ValueKey<bool>(_anchorToBottom),
        query: databaseUtil.getUser(),
        reverse: _anchorToBottom,
        sort: _anchorToBottom
            ? (DataSnapshot a, DataSnapshot b) => b.key.compareTo(a.key)
            : null,
        itemBuilder: (BuildContext context, DataSnapshot snapshot,
            Animation<double> animation, int index) {
          return new SizeTransition(
            sizeFactor: animation,
            child: showUser(snapshot),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showEditWidget(null, false),
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  @override
  void addUser(InventoryItem item) {
    setState(() {
      databaseUtil.addUser(item);
    });
  }

  @override
  void update(InventoryItem user) {
    setState(() {
      databaseUtil.updateUser(user);
    });
  }

  Widget showUser(DataSnapshot res) {
    InventoryItem item = InventoryItem.fromSnapshot(res, this.reference);

    var items = new Card(
        child: new Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(10),
      height: 180,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.8),
        borderRadius: new BorderRadius.only(
          topLeft: const Radius.circular(10.0),
          topRight: const Radius.circular(10.0),
          bottomLeft: const Radius.circular(10.0),
          bottomRight: const Radius.circular(10.0),
        ),
        image: DecorationImage(
            colorFilter: new ColorFilter.mode(
                Colors.black.withOpacity(0.5), BlendMode.dstATop),
            image: AssetImage('images/edit2.png'),
            fit: BoxFit.cover,
            scale: 0.5),
      ),
      child: new Center(
        child: new Row(
          children: <Widget>[
            Image.asset(
              'images/edit3.png',
              fit: BoxFit.contain,
              height: 80,
            ),
            new Padding(padding: const EdgeInsets.all(3.0)),
            Expanded(
              child: new Container(
                height: 80.0,
                child: new Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        item.procuctname,
                        // set some style to text
                        style: new TextStyle(
                            fontSize: 19.0,
                            color: ThemeConfig.lightPrimary,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    new Container(
                      height: 2.0,
                      width: 110.0,
                      color: ThemeConfig.darkAccent,
                    ),
                    Expanded(
                      child: Text(
                        item.productcategory,
                        // set some style to text
                        style: new TextStyle(
                            // fontSize: 22.0,
                            color: ThemeConfig.lightPrimary,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        item.productcode,
                        // set some style to text
                        style: new TextStyle(
                            // fontSize: 22.0,
                            color: ThemeConfig.lightPrimary,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            new Container(
              height: 2.0,
              width: 90.0,
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new IconButton(
                  icon: Icon(
                    Icons.edit,
                    color: ThemeConfig.lightPrimary,
                  ),
                  onPressed: () => showEditWidget(item, true),
                ),
                new IconButton(
                  icon: Icon(
                    Icons.delete_forever,
                    color: ThemeConfig.lightPrimary,
                  ),
                  onPressed: () => deleteUser(item),
                ),
              ],
            ),
          ],
        ),
      ),
    ));

    return items;
  }

  String getShortName(InventoryItem item) {
    String shortName = "";
    if (item.productcode.isNotEmpty) {
      shortName = item.productcode.substring(0, 1);
    }
    return shortName;
  }

  showEditWidget(InventoryItem item, bool isEdit) {
    showDialog(
      context: context,
      builder: (BuildContext context) =>
          new EditDialogue().buildAboutDialog(context, this, isEdit, item),
    );
  }

  deleteUser(InventoryItem item) {
    setState(() {
      databaseUtil.deleteUser(item);
    });
  }
}

//   Query _ref;
//   DatabaseReference _itemRef;
//   InventoryItem item1;
//   @override
//   void initState() {
//     // ignore: todo
//     // TODO: implement initState
//     super.initState();
//     FirebaseDatabase database = new FirebaseDatabase();
//     DatabaseReference _itemRef = database.reference().child('Item');
//     _ref = FirebaseDatabase.instance
//         .reference()
//         .child('Item')
//         .orderByChild('Product Name');
//   }

//   Widget _builditemItem({Map item}) {
//     // Color typeColor = getTypeColor(item['type']);
//     return Center(
//         child: Container(
//       margin: EdgeInsets.symmetric(vertical: 10),
//       padding: EdgeInsets.all(10),
//       height: 200,
//       decoration: BoxDecoration(
//         color: Colors.black.withOpacity(0.8),
//         borderRadius: new BorderRadius.only(
//           topLeft: const Radius.circular(10.0),
//           topRight: const Radius.circular(10.0),
//           bottomLeft: const Radius.circular(10.0),
//           bottomRight: const Radius.circular(10.0),
//         ),
//         image: DecorationImage(
//             colorFilter: new ColorFilter.mode(
//                 Colors.black.withOpacity(0.5), BlendMode.dstATop),
//             image: AssetImage('images/edit2.png'),
//             fit: BoxFit.cover,
//             scale: 0.5),
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
// Row(
//   children: [
//     Image.asset(
//       'images/edit3.png',
//       fit: BoxFit.contain,
//       height: 70,
//     ),
//     new Padding(padding: const EdgeInsets.all(10.0)),
//     new Container(
//       height: 80.0,
//       child: new Column(
//         mainAxisSize: MainAxisSize.max,
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           new Text(
//             item['Product Name'],
//             style: TextStyle(
//                 fontStyle: FontStyle.normal,
//                 color: Colors.white,
//                 fontSize: 30,
//                 fontWeight: FontWeight.w600),
//           ),
//           new Container(
//             height: 2.0,
//             width: 150.0,
//             color: ThemeConfig.darkAccent,
//           ),
//           new Text('Product Catergory: ' + item['Product Category'],
//               style: TextStyle(
//                   fontStyle: FontStyle.normal,
//                   color: Colors.white,
//                   fontWeight: FontWeight.w600)),
//           new Text(
//             'Product Code: ' + item['Product Code'],
//             style: TextStyle(
//                 fontStyle: FontStyle.normal,
//                 color: Colors.white,
//                 fontWeight: FontWeight.w600),
//           ),
//         ],
//       ),
//     ),
//   ],
// ),
//           new Padding(padding: const EdgeInsets.all(10.0)),
//           Row(children: [
//             FlatButton(
//               color: Colors.blue,
//               padding: EdgeInsets.all(2.0),
//               splashColor: ThemeConfig.lightPrimary,
//               onPressed: () {
//                 moreInfo(item);
//               },
//               child: Row(children: <Widget>[
//                 Icon(Icons.delete),
//                 Text("Edit"),
//               ]),
//             ),
//             Padding(padding: EdgeInsets.all(16)),
//             FlatButton(
//               color: Colors.blue,
//               padding: EdgeInsets.all(2.0),
//               splashColor: ThemeConfig.darkBG,
//               onPressed: () {
//                 removeData(item1);
//               },
//               child: Row(
//                 children: <Widget>[Icon(Icons.delete), Text("Delete")],
//               ),
//             ),
//           ])
//         ],
//       ),
//     ));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         height: double.infinity,
//         child: FirebaseAnimatedList(
//           query: _ref,
//           itemBuilder: (BuildContext context, DataSnapshot snapshot,
//               Animation<double> animation, int index) {
//             // var message = snapshot.data.documents[index]["content"];
//             // var from = snapshot.data.documents[index]["idFrom"];
//             Map item = snapshot.value;
//             return _builditemItem(item: item);
//           },
//         ),
//       ),
//     );
//   }

//   void updateUser(InventoryItem item) async {
//     await _itemRef.child(item.ids).update({
//       'Product Code': "" + item.productCode,
//       'Product Name': "" + item.procuctName,
//       'Product Category': "" + item.productCategory,
//       'Product Supplier': "" + item.productSuplier,
//       'Product Unit Price': "" + item.productUnitPrice,
//       'Product Unit Cost': "" + item.productUnitCost,
//       'Product Quantity': "" + item.productQuantity,
//     }).then((_) {
//       print('Transaction  committed.');
//     });
//   }

//   removeData(InventoryItem item) async {
//     await _itemRef.child(item.idd).remove().then((_) {
//       print('Transaction  committed.');
//     });

//     // print(_itemRef.child(item.idd));
//     // print(item["Product Name"]);
//     // print(item["Product Code"]);
//     // print(item["Product Category"]);
//     // print(item["Product Supplier"]);
//     // print(item["Product Unit Cost"]);
//     // print(item["Product Quantity"]);
//     // print(item["Product Unit Price"]);

//     // new Expanded(
//     //   child: new TextField(
//     //     autofocus: true,
//     //     decoration: new InputDecoration(
//     //         labelText: 'Product Name', hintText: item["Product Name"]),
//     //   ),
//     // );
//     Fluttertoast.showToast(
//         msg: 'Item deleted',
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.BOTTOM,
//         timeInSecForIos: 1,
//         backgroundColor: ThemeConfig.darkBG,
//         textColor: ThemeConfig.lightBG);
//   }

//   moreInfo(item) {
//     showDialog(
//         context: context,
//         // child: new _SystemPadding(
//         builder: (_) => new AlertDialog(
//               // shape: RoundedRectangleBorder(
//               //     borderRadius: BorderRadius.all(Radius.circular(10.0))),
//               // contentPadding: EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 24.0),
//               content: new Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 // crossAxisAlignment: CrossAxisAlignment.center,
//                 children: <Widget>[
//                   Row(children: <Widget>[
//                     // Icon can go here
//                     Column(children: <Widget>[
//                       Image.asset(
//                         'images/edit3.png',
//                         fit: BoxFit.contain,
//                         height: 110,
//                         width: 140,
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(0),
//                         child: Flexible(
//                           child: new Container(
//                             height: 5,
//                             width: MediaQuery.of(context).size.width - 144,
//                             color: Colors.lightBlue,

//                             // child: new Column(
//                             //   children: <Widget>[],
//                             // ),
//                           ),
//                         ),
//                       ),
//                     ]),

//                     new Expanded(
//                       child: new TextField(
//                         autofocus: true,
//                         decoration: new InputDecoration(
//                             labelText: 'Product Name',
//                             hintText: item["Product Name"]),
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.all(8),
//                     ),
//                     new Expanded(
//                       child: new TextField(
//                         autofocus: true,
//                         decoration: new InputDecoration(
//                             labelText: 'Product Code',
//                             hintText: item["Product Code"]),
//                       ),
//                     ),
//                   ]),
//                   Row(children: <Widget>[
//                     new Expanded(
//                       child: new TextField(
//                         autofocus: true,
//                         decoration: new InputDecoration(
//                             labelText: 'Product Category',
//                             hintText: item["Product Category"]),
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.all(8),
//                     ),
//                     new Expanded(
//                       child: new TextField(
//                         autofocus: true,
//                         decoration: new InputDecoration(
//                             labelText: 'Product Supplier',
//                             hintText: item["Product Supplier"]),
//                       ),
//                     ),
//                   ]),
//                   Row(children: <Widget>[
//                     new Expanded(
//                       child: new TextField(
//                         autofocus: true,
//                         decoration: new InputDecoration(
//                             labelText: 'Product Unit Cost',
//                             hintText: item["Product Unit Cost"]),
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.all(8),
//                     ),
//                     new Expanded(
//                       child: new TextField(
//                         autofocus: true,
//                         decoration: new InputDecoration(
//                             labelText: 'Product Quantity',
//                             hintText: item["Product Quantity"]),
//                       ),
//                     ),
//                   ]),
//                   Row(children: <Widget>[
//                     new Expanded(
//                       child: new TextField(
//                         autofocus: true,
//                         decoration: new InputDecoration(
//                             labelText: 'Product Unit Price',
//                             hintText: item["Product Unit Price"]),
//                       ),
//                     ),
//                   ]),
//                 ],
//               ),
//               actions: <Widget>[
//                 new FlatButton(
//                     child: const Text('CANCEL'),
//                     onPressed: () {
//                       Navigator.pop(context);
//                     }),
//                 new FlatButton(
//                     child: const Text('SAVE'),
//                     onPressed: () {
//                       Navigator.pop(context);
//                     })
//               ],
//             ));

//     // builder: (BuildContext context) {
//     //   return CustomDialogBox(
//     //     title: "Item Information" '\n' + '++++++++++++++',
//     //     descriptions: 'Product Name: ' +
//     //         item["Product Name"] +
//     //         '\n' +
//     //         'Product Code: ' +
//     //         item["Product Code"] +
//     //         '\n' +
//     //         'Product Category: ' +
//     //         item["Product Category"] +
//     //         '\n' +
//     //         'Product Supplier: ' +
//     //         item["Product Supplier"] +
//     //         '\n' +
//     //         'Product Unit Cost: ' +
//     //         item["Product Unit Cost"] +
//     //         '\n' +
//     //         'Product Quantity: ' +
//     //         item["Product Quantity"] +
//     //         '\n' +
//     //         'Product Unit Price: ' +
//     //         item["Product Unit Price"],
//     //     text: "Close",
//     //   );
//     // });
//   }
// }

// // class _SystemPadding extends StatelessWidget {
// //   final Widget child;

// //   _SystemPadding({Key key, this.child}) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     var mediaQuery = MediaQuery.of(context);
// //     return new AnimatedContainer(
// //         padding: mediaQuery.viewInsets,
// //         duration: const Duration(milliseconds: 300),
// //         child: child);
// //   }
// // }
