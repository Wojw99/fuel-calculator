import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fuel_calculator/constants/colors.dart';
import 'package:fuel_calculator/constants/strings.dart';
import 'package:fuel_calculator/constants/styles.dart';

class CardButton extends StatelessWidget {
  CardButton({this.text, this.onPressed});

  final String text;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBlack,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: RaisedButton(
          color: Colors.white,
          padding: EdgeInsets.all(13.0),
          onPressed: onPressed,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
            side: BorderSide(width: 0.0),
          ),
          child: Container(
            child: Text(
              text,
              style: kButtonTextStyle,
            ),
          ),
        ),
      ),
    );
  }
}
