import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fuel_calculator/constants/strings.dart';

class DoubleInputDialog {
  DoubleInputDialog({this.context, this.title});

  final BuildContext context;
  final String title;

  TextEditingController _controllerMark = TextEditingController();
  TextEditingController _controllerModel = TextEditingController();

  Future<String> showInputDialog() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('$sCarMark:'),
                TextField(
                  keyboardType: TextInputType.text,
                  controller: _controllerMark,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text('$sCarModel:'),
                TextField(
                  keyboardType: TextInputType.text,
                  controller: _controllerModel,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            MaterialButton(
              elevation: 5.0,
              child: Text('OK'),
              onPressed: () {
                // We take the value from _controller and move forward
                var value = '${_controllerMark.text},${_controllerModel.text}';
                Navigator.of(context).pop(value);
              },
            )
          ],
        );
      },
    );
  }
}
