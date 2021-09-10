import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:inventoryMan/util/theme_config.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: ThemeConfig.lightAccent,
        child: Center(
            child: SpinKitFoldingCube(
          color: ThemeConfig.lightAccent,
          size: 130.0,
        )));
  }
}
