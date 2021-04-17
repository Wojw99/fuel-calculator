import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fuel_calculator/constants/colors.dart';

class DoubleText extends StatelessWidget {
  DoubleText({
    this.value = 23.54454,
    this.valueUnit = '',
    this.paragraph = 'Paragraph',
    this.titleFontSize = 24.0,
    this.paragraphFontSize,
  });

  final double value;
  final String valueUnit;
  final String paragraph;
  final double titleFontSize;
  final double paragraphFontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kTransparent,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          children: <Widget>[
            /// * * * * * * * * * * ROW 1 - VALUE * * * * * * * * * *
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                /// * * * * * * * * * * COLUMN 1 - VALUE * * * * * * * * * *
                Text(
                  value.toStringAsPrecision(3),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                /// * * * * * * * * * * COLUMN 2 - UNIT * * * * * * * * * *
                Text(
                  '$valueUnit',
                  style: TextStyle(
                    color: Colors.white,
                    height: 1.5,
                    fontSize: titleFontSize - 10.0,
                  ),
                ),
              ],
            ),

            /// * * * * * * * * * * ROW 2 - PARAGRAPH * * * * * * * * * *
            Text(
              paragraph,
              style: TextStyle(
                // color: kGrayDark,
                color: Colors.white,
                fontSize: paragraphFontSize == null
                    ? titleFontSize - 10.0
                    : paragraphFontSize,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
