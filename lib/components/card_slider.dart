import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fuel_calculator/constants/colors.dart';
import 'package:fuel_calculator/constants/styles.dart';

class CardSlider extends StatelessWidget {
  CardSlider({
    this.label = '',
    this.valueUnit = '',
    this.value = 10.0,
    this.minValue = 5.0,
    this.maxValue = 10.0,
    @required this.onSliderChanged,
    @required this.onEditIconPressed,
    this.onSearchIconPressed,
    this.onSliderChangeEnd,
  });

  final String label;
  final String valueUnit;
  final double value;
  final double maxValue;
  final double minValue;
  final Function onSliderChanged;
  final Function onEditIconPressed;
  final Function onSearchIconPressed;
  final Function onSliderChangeEnd;

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: kBlack,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            /// * * * * * * * Row 1 - LABEL + VALUE + ICONS * * * * * * *
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 23.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// * * * LABEL * * *
                      Text(
                        label,
                        style: kLabelTextStyle,
                      ),
                      SizedBox(
                        height: 6.0,
                      ),

                      /// * * * VALUE * * *
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            value.toStringAsPrecision(3),
                            style: kNumberTextStyle,
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 3.0),
                            child: Text(
                              '$valueUnit',
                              style: kGrayTextStyle,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  /// * * * ICONS * * *
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        /// * * * ICON SEARCH * * *
                        Visibility(
                          child: IconButton(
                            icon: Icon(Icons.search),
                            color: Colors.white,
                            iconSize: 30.0,
                            padding: EdgeInsets.all(0.0),
                            alignment: Alignment.center,
                            onPressed: onSearchIconPressed,
                          ),
                          visible: onSearchIconPressed != null,
                        ),

                        /// * * * ICON EDIT * * *
                        IconButton(
                          icon: Icon(Icons.edit),
                          color: Colors.white,
                          iconSize: 30.0,
                          padding: EdgeInsets.all(0.0),
                          alignment: Alignment.center,
                          onPressed: onEditIconPressed,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            /// * * * * * * * * * * Row 2 - SLIDER * * * * * * * * * *
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 5.0,
                trackShape: GradientRectSliderTrackShape(),
                activeTrackColor: kMainLight,
                inactiveTrackColor: kBlackLight,
                thumbColor: kMainDark,
                overlayColor: kMainDarkTrans,
              ),
              child: Slider(
                value: value,
                min: minValue,
                max: maxValue,
                onChanged: onSliderChanged,
                onChangeEnd: onSliderChangeEnd,
              ),
            ),

            /// * * * * * * * * * * Row 3 - SLIDER TICKS * * * * * * * * * *
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 23.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    minValue.toString(),
                    style: kGrayTextStyle,
                  ),
                  Text(
                    maxValue.toString(),
                    style: kGrayTextStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class IconAnimated extends StatefulWidget {
  IconAnimated({this.onEditIconPressed});

  final Function onEditIconPressed;

  @override
  _IconAnimatedState createState() => _IconAnimatedState();
}

class _IconAnimatedState extends State<IconAnimated>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation animation;

  @override
  void initState() {
    animationController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    animation = ColorTween(begin: Colors.white, end: Colors.grey)
        .animate(animationController);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        animationController.forward();
        animationController.addListener(() {
          setState(() {});
        });
        print('tap down');
      },
      onTapUp: (details) {
        print('tap up');
      },
      onTap: widget.onEditIconPressed,
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Icon(
          Icons.edit,
          color: Colors.white,
          size: 30.0,
        ),
      ),
    );
  }
}

/*
IconButton(
        icon: Icon(Icons.edit),
        color: Colors.white,
        iconSize: 30.0,
        padding: EdgeInsets.all(0.0),
        alignment: Alignment.center,
        onPressed: widget.onEditIconPressed,
      ),
* */

class GradientRectSliderTrackShape extends SliderTrackShape
    with BaseSliderTrackShape {
  /// Create a slider track that draws two rectangles with rounded outer edges.
  const GradientRectSliderTrackShape();

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    @required RenderBox parentBox,
    @required SliderThemeData sliderTheme,
    @required Animation<double> enableAnimation,
    @required TextDirection textDirection,
    @required Offset thumbCenter,
    bool isDiscrete = false,
    bool isEnabled = false,
    double additionalActiveTrackHeight = 2,
  }) {
    assert(context != null);
    assert(offset != null);
    assert(parentBox != null);
    assert(sliderTheme != null);
    assert(sliderTheme.disabledActiveTrackColor != null);
    assert(sliderTheme.disabledInactiveTrackColor != null);
    assert(sliderTheme.activeTrackColor != null);
    assert(sliderTheme.inactiveTrackColor != null);
    assert(sliderTheme.thumbShape != null);
    assert(enableAnimation != null);
    assert(textDirection != null);
    assert(thumbCenter != null);
    // If the slider [SliderThemeData.trackHeight] is less than or equal to 0,
    // then it makes no difference whether the track is painted or not,
    // therefore the painting  can be a no-op.
    if (sliderTheme.trackHeight <= 0) {
      return;
    }

    LinearGradient gradient = LinearGradient(
      colors: <Color>[
        kMainLight,
        kMainDark,
      ],
    );

    final Rect trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );

    final activeGradientRect = Rect.fromLTRB(
      trackRect.left,
      (textDirection == TextDirection.ltr)
          ? trackRect.top - (additionalActiveTrackHeight / 2)
          : trackRect.top,
      thumbCenter.dx,
      (textDirection == TextDirection.ltr)
          ? trackRect.bottom + (additionalActiveTrackHeight / 2)
          : trackRect.bottom,
    );

    // Assign the track segment paints, which are leading: active and
    // trailing: inactive.
    final ColorTween activeTrackColorTween = ColorTween(
        begin: sliderTheme.disabledActiveTrackColor,
        end: sliderTheme.activeTrackColor);
    final ColorTween inactiveTrackColorTween = ColorTween(
        begin: sliderTheme.disabledInactiveTrackColor,
        end: sliderTheme.inactiveTrackColor);
    final Paint activePaint = Paint()
      ..shader = gradient.createShader(activeGradientRect)
      ..color = activeTrackColorTween.evaluate(enableAnimation);
    final Paint inactivePaint = Paint()
      ..color = inactiveTrackColorTween.evaluate(enableAnimation);
    Paint leftTrackPaint;
    Paint rightTrackPaint;
    switch (textDirection) {
      case TextDirection.ltr:
        leftTrackPaint = activePaint;
        rightTrackPaint = inactivePaint;
        break;
      case TextDirection.rtl:
        leftTrackPaint = inactivePaint;
        rightTrackPaint = activePaint;
        break;
    }

    final Radius trackRadius = Radius.circular(trackRect.height / 2);
    final Radius activeTrackRadius = Radius.circular(trackRect.height / 2 + 1);

    context.canvas.drawRRect(
      RRect.fromLTRBAndCorners(
        trackRect.left,
        (textDirection == TextDirection.ltr)
            ? trackRect.top - (additionalActiveTrackHeight / 2)
            : trackRect.top,
        thumbCenter.dx,
        (textDirection == TextDirection.ltr)
            ? trackRect.bottom + (additionalActiveTrackHeight / 2)
            : trackRect.bottom,
        topLeft: (textDirection == TextDirection.ltr)
            ? activeTrackRadius
            : trackRadius,
        bottomLeft: (textDirection == TextDirection.ltr)
            ? activeTrackRadius
            : trackRadius,
      ),
      leftTrackPaint,
    );
    context.canvas.drawRRect(
      RRect.fromLTRBAndCorners(
        thumbCenter.dx,
        (textDirection == TextDirection.rtl)
            ? trackRect.top - (additionalActiveTrackHeight / 2)
            : trackRect.top,
        trackRect.right,
        (textDirection == TextDirection.rtl)
            ? trackRect.bottom + (additionalActiveTrackHeight / 2)
            : trackRect.bottom,
        topRight: (textDirection == TextDirection.rtl)
            ? activeTrackRadius
            : trackRadius,
        bottomRight: (textDirection == TextDirection.rtl)
            ? activeTrackRadius
            : trackRadius,
      ),
      rightTrackPaint,
    );
  }
}
