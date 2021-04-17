import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InputDialog {
  InputDialog({this.context, this.title});

  final BuildContext context;
  final String title;

  TextEditingController _controller = TextEditingController();

  Future<String> showInputDialog() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: TextField(
            keyboardType: TextInputType.number,
            controller: _controller,
          ),
          actions: <Widget>[
            MaterialButton(
              elevation: 5.0,
              child: Text('OK'),
              onPressed: () {
                // We take the value from _controller and move forward
                Navigator.of(context).pop(_controller.text.toString());
              },
            )
          ],
        );
      },
    );
  }
}
