import 'package:flutter/material.dart';

/// displays an error modal with the supplied message
Future<Null> displayErrorModal(BuildContext context, String message) =>
    showDialog(
        context: context,
        builder: (var context) => AlertDialog(
          title: Text(
            'Error',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  message,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ));