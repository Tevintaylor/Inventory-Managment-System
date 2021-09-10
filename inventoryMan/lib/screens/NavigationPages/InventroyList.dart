import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:inventoryMan/models/custom_dialog_box.dart';
import 'package:inventoryMan/screens/NavigationPages/AddInventory.dart';
import 'package:inventoryMan/util/theme_config.dart';

class InventoryList extends StatefulWidget {
  @override
  _InventoryListState createState() => _InventoryListState();
}

class _InventoryListState extends State<InventoryList> {
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
      height: 200,
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
            image: AssetImage('images/back.jpg'),
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
                'images/leading.png',
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
                      item['Product Name'],
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
                    new Text('Product Catergory: ' + item['Product Category'],
                        style: TextStyle(
                            fontStyle: FontStyle.normal,
                            color: Colors.white,
                            fontWeight: FontWeight.w600)),
                    new Text(
                      'Product Code: ' + item['Product Code'],
                      style: TextStyle(
                          fontStyle: FontStyle.normal,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ],
          ),
          new Padding(padding: const EdgeInsets.all(10.0)),
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

  moreInfo(item) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialogBox(
            title: "Item Information" '\n' + '++++++++++++++',
            descriptions: 'Product Name: ' +
                item["Product Name"] +
                '\n' +
                'Product Code: ' +
                item["Product Code"] +
                '\n' +
                'Product Category: ' +
                item["Product Category"] +
                '\n' +
                'Product Supplier: ' +
                item["Product Supplier"] +
                '\n' +
                'Product Unit Cost: ' +
                item["Product Unit Cost"] +
                '\n' +
                'Product Quantity: ' +
                item["Product Quantity"] +
                '\n' +
                'Product Unit Price: ' +
                item["Product Unit Price"],
            text: "Close",
          );
        });
  }
}
