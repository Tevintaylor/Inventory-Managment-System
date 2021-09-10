import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inventoryMan/util/theme_config.dart';
import 'package:inventoryMan/models/InventoryItem.dart';
import 'package:flutter/material.dart';

class EditDialogue {
  final pCode = TextEditingController();
  final pName = TextEditingController();
  final pCategory = TextEditingController();
  final pSupplier = TextEditingController();
  final pUCost = TextEditingController();
  final pUPrice = TextEditingController();
  final pQuantity = TextEditingController();
  InventoryItem item;

  static const TextStyle linkStyle = const TextStyle(
    color: Colors.blue,
    decoration: TextDecoration.underline,
  );

  Widget buildAboutDialog(BuildContext context,
      AddUserCallback _myHomePageState, bool isEdit, InventoryItem item) {
    if (item != null) {
      this.item = item;
      pCode.text = item.productcode;
      pName.text = item.procuctname;
      pCategory.text = item.productcategory;
      pSupplier.text = item.productsuplier;
      pUCost.text = item.productunitCost;
      pUPrice.text = item.productunitPrice;
      pQuantity.text = item.productquantity;
    }

    return new AlertDialog(
      title: new Text(isEdit ? 'Edit detail!' : 'Add new item!'),
      content: new SingleChildScrollView(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(children: <Widget>[
              // Icon can go here
              Column(children: <Widget>[
                Image.asset(
                  'images/edit3.png',
                  fit: BoxFit.contain,
                  height: 110,
                  width: 140,
                ),
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: Flexible(
                    child: new Container(
                      height: 5,
                      width: MediaQuery.of(context).size.width - 144,
                      color: Colors.lightBlue,
                    ),
                  ),
                ),
              ]),
            ]),
            getTextField("Product Code", pCode),
            getTextField("Product Name", pName),
            getTextField("Product Category", pCategory),
            getTextField("Product Supplier", pSupplier),
            getTextField("Product Unit Price", pUPrice),
            getTextField("Product Unit Cost", pUCost),
            getTextField("Product Quantity", pQuantity),
            new GestureDetector(
              onTap: () => onTap(isEdit, _myHomePageState, context),
              child: new Container(
                margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                child: getAppBorderButton(isEdit ? "Edit" : "Add",
                    EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getTextField(
      String inputBoxName, TextEditingController inputBoxController) {
    var loginBtn = new Padding(
      padding: const EdgeInsets.all(5.0),
      child: new TextFormField(
        controller: inputBoxController,
        decoration: new InputDecoration(
          hintText: inputBoxName,
        ),
      ),
    );

    return loginBtn;
  }

  Widget getAppBorderButton(String buttonLabel, EdgeInsets margin) {
    var loginBtn = new Container(
      margin: margin,
      padding: EdgeInsets.all(8.0),
      alignment: FractionalOffset.center,
      decoration: new BoxDecoration(
        border: Border.all(color: const Color(0xFF28324E)),
        borderRadius: new BorderRadius.all(const Radius.circular(6.0)),
      ),
      child: new Text(
        buttonLabel,
        style: new TextStyle(
          color: const Color(0xFF28324E),
          fontSize: 20.0,
          fontWeight: FontWeight.w300,
          letterSpacing: 0.3,
        ),
      ),
    );
    return loginBtn;
  }

  DocumentReference reference;

  InventoryItem getData(bool isEdit) {
    return new InventoryItem(
        isEdit ? item.idd : "",
        reference,
        pCode.text,
        pName.text,
        pCategory.text,
        pSupplier.text,
        pUCost.text,
        pUPrice.text,
        pQuantity.text);
  }

  onTap(bool isEdit, AddUserCallback _myHomePageState, BuildContext context) {
    if (isEdit) {
      _myHomePageState.update(getData(isEdit));
      Navigator.of(context).pop();
    } else {
      _myHomePageState.addUser(getData(isEdit));
      Navigator.of(context).pop();
    }
  }
}

abstract class AddUserCallback {
  void addUser(InventoryItem item);

  void update(InventoryItem item);
}

// class Constants {
//   Constants._();
//   static const double padding = 20;
//   static const double avatarRadius = 45;
// }

// class EditDialogue extends StatefulWidget {
//   final String title, descriptions, text;
//   final Image img;

//   const EditDialogue(
//       {Key key, this.title, this.descriptions, this.text, this.img})
//       : super(key: key);
//   @override
//   _EditDialogueState createState() => new _EditDialogueState();
// }

// class _EditDialogueState extends State<EditDialogue> {
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(Constants.padding),
//       ),
//       elevation: 0,
//       backgroundColor: Colors.transparent,
//       child: contentBox(context),
//     );
//   }

//   contentBox(context) {
//     return new _SystemPadding(
//         child: Stack(
//       children: <Widget>[
//         Container(
//           padding: EdgeInsets.only(
//               left: Constants.padding,
//               top: Constants.avatarRadius + Constants.padding,
//               right: Constants.padding,
//               bottom: Constants.padding),
//           margin: EdgeInsets.only(top: Constants.avatarRadius),
//           decoration: BoxDecoration(
//               shape: BoxShape.rectangle,
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(Constants.padding),
//               boxShadow: [
//                 BoxShadow(
//                     color: ThemeConfig.darkAccent,
//                     offset: Offset(0, 10),
//                     blurRadius: 10),
//               ]),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               // Text(
//               //   widget.title,
//               //   style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
//               // ),
//               SizedBox(
//                 height: 15,
//               ),
//               // Text(
//               //   widget.descriptions,
//               //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//               //   textAlign: TextAlign.left,
//               // ),
//               SizedBox(
//                 height: 22,
//               ),
//               Align(
//                 alignment: Alignment.bottomRight,
//                 child: FlatButton(
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                     },
//                     child: Text(
//                       "widget.text",
//                       style: TextStyle(fontSize: 18),
//                     )),
//               ),
//             ],
//           ),
//         ),
//         Positioned(
//           left: Constants.padding,
//           right: Constants.padding,
//           child: CircleAvatar(
//             backgroundColor: Colors.transparent,
//             radius: Constants.avatarRadius,
//             child: ClipRRect(
//                 borderRadius:
//                     BorderRadius.all(Radius.circular(Constants.avatarRadius)),
//                 child: Image.asset("images/leading.png")),
//           ),
//         ),
//       ],
//     ));
//   }
// }

// class _SystemPadding extends StatelessWidget {
//   final Widget child;

//   _SystemPadding({Key key, this.child}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     var mediaQuery = MediaQuery.of(context);
//     return new AnimatedContainer(
//         padding: mediaQuery.viewInsets,
//         duration: const Duration(milliseconds: 300),
//         child: child);
//   }
// }
