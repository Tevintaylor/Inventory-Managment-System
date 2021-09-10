import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inventoryMan/models/InventoryItem.dart';
import 'package:inventoryMan/services/database.dart';
import 'package:inventoryMan/util/theme_config.dart';
// import 'dart:io';

class AddInventory extends StatefulWidget {
  @override
  _AddInventoryState createState() => _AddInventoryState();
}

class _AddInventoryState extends State<AddInventory> {
  DatabaseReference _ref;
  final _formkey = GlobalKey<FormState>();

  var _pCode = TextEditingController();
  var _pName = TextEditingController();
  var _pCategory = TextEditingController();
  var _pSupplier = TextEditingController();
  var _pUCost = TextEditingController();
  var _pUPrice = TextEditingController();
  var _pQuantity = TextEditingController();

  // text field state
  String pCode = '';
  String pName = '';
  String pCategory = '';
  String pSupplier = '';
  String pUCost = '';
  String pUPrice = '';
  String pQuantity = '';
  String error = '';

  @override
  void initState() {
    super.initState();

    _ref = FirebaseDatabase.instance.reference().child('Item');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      // padding: EdgeInsets.all(10),
      height: 230,
      // decoration: BoxDecoration(
      //   color: Colors.black.withOpacity(0.8),
      //   image: DecorationImage(
      //       colorFilter: new ColorFilter.mode(
      //           Colors.black.withOpacity(0.5), BlendMode.dstATop),
      //       image: AssetImage('images/back.jpg'),
      //       fit: BoxFit.cover,
      //       scale: 0.5),
      // ),
      child: Material(
        elevation: 1,
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          child: Form(
            key: _formkey,
            // key: form,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                AppBar(
                  leading: Icon(
                    Icons.verified_user,
                    color: ThemeConfig.lightPrimary,
                  ),
                  elevation: 0,
                  title: Text(
                    'Inventory Item Detail',
                    style: TextStyle(
                        fontStyle: FontStyle.normal,
                        color: ThemeConfig.lightPrimary),
                  ),
                  backgroundColor: ThemeConfig.lightAccent,
                  // backgroundColor: Theme.of(context).accentColor,
                  centerTitle: true,
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(Icons.delete),
                      color: ThemeConfig.lightPrimary,
                      onPressed: () {
                        _pCode.clear();
                        _pName.clear();
                        _pCategory.clear();
                        _pSupplier.clear();
                        _pUCost.clear();
                        _pUPrice.clear();
                        _pQuantity.clear();
                      },
                      // onPressed: widget.onDelete,
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 3,
                              child: TextFormField(
                                controller: _pCode,
                                validator: (val) =>
                                    val.isEmpty ? 'Enter a Product Code' : null,
                                onChanged: (val) {
                                  setState(() => pCode = val);
                                },
                                keyboardType: TextInputType.text,
                                decoration: new InputDecoration(
                                  labelText: 'Product Code',
                                  hintText: 'Enter Product Code',
                                  // icon: Icon(Icons.person),
                                  isDense: true,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                      ),
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 3,
                              child: TextFormField(
                                controller: _pName,
                                validator: (val) =>
                                    val.isEmpty ? 'Enter Product Name' : null,
                                onChanged: (val) {
                                  setState(() => pName = val);
                                },
                                keyboardType: TextInputType.text,
                                decoration: new InputDecoration(
                                  labelText: 'Enter Product Name',
                                  hintText: 'Enter Product Name',
                                  // icon: Icon(Icons.person),
                                  isDense: true,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 3,
                              child: TextFormField(
                                controller: _pCategory,
                                validator: (val) => val.isEmpty
                                    ? 'Enter Product Category'
                                    : null,
                                onChanged: (val) {
                                  setState(() => pCategory = val);
                                },
                                keyboardType: TextInputType.text,
                                decoration: new InputDecoration(
                                  labelText: 'Enter Product Category',
                                  hintText: 'Enter Product Category',
                                  // icon: Icon(Icons.person),
                                  isDense: true,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                      ),
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 3,
                              child: TextFormField(
                                controller: _pSupplier,
                                validator: (val) => val.isEmpty
                                    ? 'Enter a Product Supplier'
                                    : null,
                                onChanged: (val) {
                                  setState(() => pSupplier = val);
                                },
                                keyboardType: TextInputType.text,
                                decoration: new InputDecoration(
                                  labelText: 'Enter Product Supplier',
                                  hintText: 'Enter Product Supplier',
                                  // icon: Icon(Icons.person),
                                  isDense: true,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 3,
                              child: TextFormField(
                                controller: _pUCost,
                                validator: (val) => val.isEmpty
                                    ? 'Enter a Product Unit Cost'
                                    : null,
                                onChanged: (val) {
                                  setState(() => pUCost = val);
                                },
                                keyboardType: TextInputType.number,
                                decoration: new InputDecoration(
                                  labelText: 'Enter Product Unit Cost',
                                  hintText: 'Enter Product Unit Cost',
                                  // icon: Icon(Icons.person),
                                  isDense: true,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                      ),
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 3,
                              child: TextFormField(
                                controller: _pQuantity,
                                validator: (val) => val.isEmpty
                                    ? 'Enter a Product Quantity'
                                    : null,
                                onChanged: (val) {
                                  setState(() => pQuantity = val);
                                },
                                keyboardType: TextInputType.number,
                                decoration: new InputDecoration(
                                  labelText: 'Enter Product Quantity',
                                  hintText: 'Enter Product Quantity',
                                  // icon: Icon(Icons.person),
                                  isDense: true,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 3,
                              child: TextFormField(
                                controller: _pUPrice,
                                validator: (val) => val.isEmpty
                                    ? 'Enter a Product Unit Price'
                                    : null,
                                onChanged: (val) {
                                  setState(() => pUPrice = val);
                                },
                                keyboardType: TextInputType.number,
                                decoration: new InputDecoration(
                                  labelText: 'Enter Product Unit Price',
                                  hintText: 'Enter Product Unit Price',
                                  // icon: Icon(Icons.person),
                                  isDense: true,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                new Padding(padding: const EdgeInsets.only(top: 10.0)),
                Center(
                  child: FloatingActionButton.extended(
                      label: Text(
                        'Add Item',
                        style: TextStyle(
                            fontStyle: FontStyle.normal,
                            color: ThemeConfig.lightPrimary),
                      ),
                      backgroundColor: ThemeConfig.lightAccent,
                      icon: Icon(
                        Icons.add,
                        color: ThemeConfig.lightPrimary,
                      ),
                      onPressed: () {
                        if (_formkey.currentState.validate()) {
                          saveItem();
                          _pCode.clear();
                          _pName.clear();
                          _pCategory.clear();
                          _pSupplier.clear();
                          _pUCost.clear();
                          _pUPrice.clear();
                          _pQuantity.clear();
                          Fluttertoast.showToast(
                              msg: 'Item added to Inventory',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIos: 1,
                              backgroundColor: ThemeConfig.darkBG,
                              textColor: ThemeConfig.lightBG);
                        } else {
                          Fluttertoast.showToast(
                              msg: 'Please fill in all fields',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIos: 1,
                              backgroundColor: ThemeConfig.darkBG,
                              textColor: ThemeConfig.lightBG);
                        }
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void saveItem() {
    String productCode = _pCode.text;
    String procuctName = _pName.text;
    String productCategory = _pCategory.text;
    String productSuplier = _pSupplier.text;
    String productUnitPrice = _pUCost.text;
    String productUnitCost = _pUPrice.text;
    String productQuantity = _pQuantity.text;

    Map<String, String> item = {
      'Product Code': productCode,
      'Product Name': procuctName,
      'Product Category': productCategory,
      'Product Supplier': productSuplier,
      'Product Unit Price': productUnitPrice,
      'Product Unit Cost': productUnitCost,
      'Product Quantity': productQuantity,
    };

    _ref.push().set(item);
  }
}
