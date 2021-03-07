import 'package:flutter/material.dart';
import 'dart:ui';

class DialogAlert extends StatelessWidget {
  final String alertTitle;
  final String alertContent;

  DialogAlert({this.alertTitle, this.alertContent});
  final TextStyle textStyle = TextStyle(color: Colors.white);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
      child: AlertDialog(
        title: new Text(
          alertTitle,
          style: textStyle,
        ),
        content: new Text(
          alertContent,
          style: textStyle,
        ),
        actions: [
          new FlatButton(
            child: new Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
