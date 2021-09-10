import 'package:inventoryMan/models/inventoryList.dart';
import 'package:inventoryMan/models/InventoryItem.dart';
import 'package:inventoryMan/models/item_title.dart';
import 'package:flutter/material.dart';
import 'package:inventoryMan/models/InventoryItem.dart';
import 'package:provider/provider.dart';

class BrewList extends StatefulWidget {
  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final items = Provider.of<List<InventoryItem>>(context);

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return BrewTile(item: items[index]);
      },
    );
  }
}
