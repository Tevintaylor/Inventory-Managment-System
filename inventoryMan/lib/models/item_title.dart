import 'package:inventoryMan/models/InventoryItem.dart';
import 'package:flutter/material.dart';
import 'package:inventoryMan/screens/NavigationPages/Setting.dart';

class BrewTile extends StatelessWidget {
  final InventoryItem item;
  BrewTile({this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
          ),
          title: Text(item.procuctName),
          subtitle: Text('Takes ${item.productCode} sugar(s)'),
        ),
      ),
    );
  }
}
