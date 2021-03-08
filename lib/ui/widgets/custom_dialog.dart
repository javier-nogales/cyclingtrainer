import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final Widget title;
  final Widget content;
  final Widget actions;

  CustomDialog({
    @required this.title,
    @required this.content,
    @required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0)
      ), 
      child: Container(
        height: 300.0,
        width: 300.0,
        child: Column(
          children: <Widget>[
            title,
            content,
            actions,
          ],
        ),
      )
    );
  }
}