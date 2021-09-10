import 'package:flutter/material.dart';

enum DialogAction { yes, abort }

class Dialogs {
  static Future<DialogAction> yesAbortDialog(
    BuildContext context,
    String title,
    String body,
  ) async {
    final action = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          
          actions: <Widget>[
            new Icon(Icons.pin_drop),
            RaisedButton(
              onPressed: () => Navigator.of(context).pop(DialogAction.yes),
              child: const Text(
                'OK',
                style: TextStyle(
                  color: Colors.orange,
                ),
              ),
            ),
          ],
          title: Text(title),
          content: Text(body), 
        );
      },
    );
    return (action != null) ? action : DialogAction.abort;
  }
}