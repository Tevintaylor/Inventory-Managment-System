import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
// import 'package:inventoryMan/screens/NavigationPages/InventroyList.dart';

class InventoryItem {
  InventoryItem(this.ids, this.reference,
      [this.productCode,
      this.procuctName,
      this.productCategory,
      this.productSuplier,
      this.productUnitPrice,
      this.productUnitCost,
      this.productQuantity]);

  final DocumentReference reference;
  String productCode;
  String procuctName;
  String productCategory;
  String productSuplier;
  String productUnitPrice;
  String productUnitCost;
  String productQuantity;
  String ids;
  // DatabaseReference _id;

  InventoryItem.data(this.ids, this.reference,
      [this.productCode,
      this.procuctName,
      this.productCategory,
      this.productSuplier,
      this.productUnitPrice,
      this.productUnitCost,
      this.productQuantity]) {
    // Set these rather than using the default value because Firebase returns
    // null if the value is not specified.
    this.ids = ids;
    this.productCode ??= '';
    this.procuctName ??= '';
    this.productCategory ??= '';
    this.productSuplier ??= '';
    this.productUnitPrice ??= '';
    this.productUnitCost ??= '';
    this.productQuantity ??= '';
  }

  String get productcode => productCode;
  String get procuctname => procuctName;
  String get productcategory => productCategory;
  String get productsuplier => productSuplier;
  String get productunitPrice => productUnitPrice;
  String get productunitCost => productUnitCost;
  String get productquantity => productQuantity;
  String get idd => ids;

  // factory InventoryItem.from(DocumentSnapshot document) => InventoryItem.data(
  //     document.reference,
  //     document.data['Product Code'],
  //     document.data['Product Name']);

  void save() {
    reference.setData(toMap());
  }

  Map<String, dynamic> toMap() {
    return {
      'Product Code': productCode,
      'Product Name': procuctName,
      'Product Category': productCategory,
      'Product Supplier': productSuplier,
      'Product Unit Price': productUnitPrice,
      'Product Unit Cost': productUnitCost,
      'Product Quantity': productQuantity,
    };
  }

  InventoryItem.fromSnapshot(DataSnapshot snapshot, this.reference) {
    ids = snapshot.key;
    productCode = snapshot.value['Product Code'];
    procuctName = snapshot.value['Product Name'];
    productCategory = snapshot.value['Product Category'];
    productSuplier = snapshot.value['Product Supplier'];
    productUnitPrice = snapshot.value['Product Unit Price'];
    productUnitCost = snapshot.value['Product Unit Cost'];
    productQuantity = snapshot.value['Product Quantity'];
  }
}
