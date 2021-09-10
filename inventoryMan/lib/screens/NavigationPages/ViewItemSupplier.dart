import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:inventoryMan/models/custom_dialog_box.dart';
import 'package:inventoryMan/screens/NavigationPages/AddInventory.dart';
import 'package:inventoryMan/util/theme_config.dart';

class ViewItemSupplier extends StatefulWidget {
  @override
  _ViewItemSupplierState createState() => _ViewItemSupplierState();
}

class _ViewItemSupplierState extends State<ViewItemSupplier> {
  Query _ref;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _ref = FirebaseDatabase.instance
        .reference()
        .child('Item')
        .orderByChild('Product Name');
  }

  Widget _builditemItem({Map item}) {
    // Color typeColor = getTypeColor(item['type']);
    return Center(
        child: Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(10),
      height: 170,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.8),
        borderRadius: new BorderRadius.only(
          topLeft: const Radius.circular(20.0),
          topRight: const Radius.circular(20.0),
          bottomLeft: const Radius.circular(20.0),
          bottomRight: const Radius.circular(20.0),
        ),
        image: DecorationImage(
            colorFilter: new ColorFilter.mode(
                Colors.black.withOpacity(0.5), BlendMode.dstATop),
            image: AssetImage('images/supplier.jpg'),
            fit: BoxFit.cover,
            scale: 0.5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(
                'images/supplier.png',
                fit: BoxFit.contain,
                height: 70,
              ),
              new Padding(padding: const EdgeInsets.all(10.0)),
              new Container(
                height: 80.0,
                child: new Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text(
                      item['Product Supplier'],
                      style: TextStyle(
                          fontStyle: FontStyle.normal,
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w600),
                    ),
                    new Container(
                      height: 2.0,
                      width: 150.0,
                      color: ThemeConfig.darkAccent,
                    ),
                    new Text(
                        'Email :' + item['Product Supplier'] + '@gmail.com',
                        style: TextStyle(
                            fontStyle: FontStyle.normal,
                            color: Colors.white,
                            fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ],
          ),
          Padding(padding: EdgeInsets.all(8)),
          Row(children: [
            Padding(padding: EdgeInsets.all(16)),
            FlatButton(
              color: Colors.blue,
              textColor: Colors.white,
              padding: EdgeInsets.all(8.0),
              splashColor: ThemeConfig.darkBG,
              onPressed: () {
                moreInfo(item);
              },
              child: Row(
                children: <Widget>[Icon(Icons.info), Text("View More")],
              ),
            ),
          ])
        ],
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        child: FirebaseAnimatedList(
          query: _ref,
          itemBuilder: (BuildContext context, DataSnapshot snapshot,
              Animation<double> animation, int index) {
            Map item = snapshot.value;
            return _builditemItem(item: item);
          },
        ),
      ),
    );
  }

  removeData() {}

  moreInfo(item) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialogBox(
            title: "Product Supplier Information" '\n' +
                '++++++++++++++++++++++++',
            descriptions: 'Product Supplier Name: ' +
                item["Product Supplier"] +
                '\n' +
                'Phone #: ' +
                item["Product Code"] +
                '\n' +
                'Email: ' +
                item["Product Supplier"] +
                '@yahoo.com',
            text: "Close",
          );
        });
  }
}
