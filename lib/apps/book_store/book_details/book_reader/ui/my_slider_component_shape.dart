
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MySliderComponentShape extends SliderComponentShape{
  const MySliderComponentShape( {
     this.text,
    this.enabledThumbRadius = 10.0,
    required this.t1, required this.t2,
    this.disabledThumbRadius,
    this.fontFamily,
    this.elevation = 1.0,
    this.pressedElevation = 6.0,
  });

  /// The preferred radius of the round thumb shape when the slider is enabled.
  ///
  /// If it is not provided, then the Material Design default of 10 is used.
  final double enabledThumbRadius;
  final String? text;
  final String? fontFamily;
  final String t1;
  final String t2;

  /// The preferred radius of the round thumb shape when the slider is disabled.
  ///
  /// If no disabledRadius is provided, then it is equal to the
  /// [enabledThumbRadius]
  final double? disabledThumbRadius;
  double get _disabledThumbRadius => disabledThumbRadius ?? enabledThumbRadius;

  /// The resting elevation adds shadow to the unpressed thumb.
  ///
  /// The default is 1.
  ///
  /// Use 0 for no shadow. The higher the value, the larger the shadow. For
  /// example, a value of 12 will create a very large shadow.
  ///
  final double elevation;

  /// The pressed elevation adds shadow to the pressed thumb.
  ///
  /// The default is 6.
  ///
  /// Use 0 for no shadow. The higher the value, the larger the shadow. For
  /// example, a value of 12 will create a very large shadow.
  final double pressedElevation;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(isEnabled == true ? enabledThumbRadius : _disabledThumbRadius);
  }

  @override
  void paint(
      PaintingContext context,
      Offset center, {
        required Animation<double> activationAnimation,
        required Animation<double> enableAnimation,
        required bool isDiscrete,
        required TextPainter labelPainter,
        required RenderBox parentBox,
        required SliderThemeData sliderTheme,
        required TextDirection textDirection,
        required double value,
        required double textScaleFactor,
        required Size sizeWithOverflow,
      }) {
    assert(sliderTheme.disabledThumbColor != null);
    assert(sliderTheme.thumbColor != null);

    final Canvas canvas = context.canvas;
    final Tween<double> radiusTween = Tween<double>(
      begin: _disabledThumbRadius,
      end: enabledThumbRadius,
    );
    final ColorTween colorTween = ColorTween(
      begin: sliderTheme.disabledThumbColor,
      end: sliderTheme.thumbColor,
    );

    final Color color = colorTween.evaluate(enableAnimation)!;
    final double radius = radiusTween.evaluate(enableAnimation);

    final Tween<double> elevationTween = Tween<double>(
      begin: elevation,
      end: pressedElevation,
    );

    final double evaluatedElevation = elevationTween.evaluate(activationAnimation);
    final Path path = Path()
      ..addArc(Rect.fromCenter(center: center, width: 2 * radius, height: 2 * radius), 0, math.pi * 2);

    bool paintShadows = true;

    if (paintShadows) {
      canvas.drawShadow(path, Colors.black, evaluatedElevation, true);
    }

    ui.ParagraphBuilder a1 = ui.ParagraphBuilder(ui.ParagraphStyle(
      textAlign: TextAlign.center,
      fontSize: 12,
      textDirection: TextDirection.ltr,
      fontWeight: FontWeight.w500,
      fontFamily:fontFamily,
      maxLines: 1,
    ));
    a1.pushStyle(
      ui.TextStyle(
          color: Color(0xff585F69), textBaseline: ui.TextBaseline.alphabetic),
    );
    a1.addText(t1);

    ui.Paragraph a1p = a1.build();

    a1p.layout( const ui.ParagraphConstraints(width: 15));
    canvas.drawParagraph(a1p, Offset(enabledThumbRadius/2+6, center.dy-8));


    var a2 = ui.ParagraphBuilder(ui.ParagraphStyle(
      textAlign: TextAlign.center,
      fontSize: 12,
      textDirection: TextDirection.ltr,
      fontWeight: FontWeight.w500,
      fontFamily:fontFamily,
      maxLines: 1,
    ));
    a2.pushStyle(
      ui.TextStyle(
          color: Color(0xff585F69), textBaseline: ui.TextBaseline.alphabetic),
    );
    a2.addText(t2);
    ui.Paragraph a2p = a2.build();
    a2p.layout( ui.ParagraphConstraints(width: 18));
    canvas.drawParagraph(a2p, Offset(parentBox.constraints.maxWidth-enabledThumbRadius*1.5-6, center.dy-8));

    canvas.drawCircle(
      center,
      radius,
      Paint()..color = color,
    );
    var builder = ui.ParagraphBuilder(ui.ParagraphStyle(
      textAlign: TextAlign.center,
      fontSize: 12,
      textDirection: TextDirection.ltr,
      fontWeight: FontWeight.w500,
      maxLines: 1,
    ));
    builder.pushStyle(
      ui.TextStyle(
          color: Get.textTheme.bodySmall!.color, textBaseline: ui.TextBaseline.alphabetic),
    );
    labelPainter.plainText.isNum;
    if(labelPainter.plainText.isNum){
      builder.addText(text??double.parse(labelPainter.plainText).toStringAsFixed(0));
    }else{
      builder.addText('');
    }

    ui.Paragraph paragraph = builder.build();
    paragraph.layout( ui.ParagraphConstraints(width: 24));
    canvas.drawParagraph(paragraph, Offset(center.dx-12, center.dy-8));
  }

}


class MyRoundedRectSliderTrackShape extends SliderTrackShape with BaseSliderTrackShape {
  /// Create a slider track that draws two rectangles with rounded outer edges.
  const MyRoundedRectSliderTrackShape();

  @override
  void paint(
      PaintingContext context,
      Offset offset, {
        required RenderBox parentBox,
        required SliderThemeData sliderTheme,
        required Animation<double> enableAnimation,
        required TextDirection textDirection,
        required Offset thumbCenter,
        Offset? secondaryOffset,
        bool isDiscrete = false,
        bool isEnabled = false,
        double additionalActiveTrackHeight = 2,
      }) {
    assert(sliderTheme.disabledActiveTrackColor != null);
    assert(sliderTheme.disabledInactiveTrackColor != null);
    assert(sliderTheme.activeTrackColor != null);
    assert(sliderTheme.inactiveTrackColor != null);
    assert(sliderTheme.thumbShape != null);
    // If the slider [SliderThemeData.trackHeight] is less than or equal to 0,
    // then it makes no difference whether the track is painted or not,
    // therefore the painting can be a no-op.
    if (sliderTheme.trackHeight == null || sliderTheme.trackHeight! <= 0) {
      return;
    }

    // Assign the track segment paints, which are leading: active and
    // trailing: inactive.
    final ColorTween activeTrackColorTween = ColorTween(begin: sliderTheme.disabledActiveTrackColor, end: sliderTheme.activeTrackColor);
    final ColorTween inactiveTrackColorTween = ColorTween(begin: sliderTheme.disabledInactiveTrackColor, end: sliderTheme.inactiveTrackColor);
    final Paint activePaint = Paint()..color = activeTrackColorTween.evaluate(enableAnimation)!;
    final Paint inactivePaint = Paint()..color = inactiveTrackColorTween.evaluate(enableAnimation)!;
    final Paint leftTrackPaint;
    final Paint rightTrackPaint;
    switch (textDirection) {
      case TextDirection.ltr:
        leftTrackPaint = activePaint;
        rightTrackPaint = inactivePaint;
      case TextDirection.rtl:
        leftTrackPaint = inactivePaint;
        rightTrackPaint = activePaint;
    }

    final Rect trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );
    final Radius trackRadius = Radius.circular(trackRect.height / 2);
    final Radius activeTrackRadius = Radius.circular((trackRect.height + additionalActiveTrackHeight) / 2);

    context.canvas.drawRRect(
      RRect.fromLTRBAndCorners(
       4,
        (textDirection == TextDirection.ltr) ? trackRect.top - (additionalActiveTrackHeight / 2): trackRect.top,
        thumbCenter.dx,
        (textDirection == TextDirection.ltr) ? trackRect.bottom + (additionalActiveTrackHeight / 2) : trackRect.bottom,
        topLeft: (textDirection == TextDirection.ltr) ? activeTrackRadius : trackRadius,
        bottomLeft: (textDirection == TextDirection.ltr) ? activeTrackRadius: trackRadius,
      ),
      leftTrackPaint,
    );
    context.canvas.drawRRect(
      RRect.fromLTRBAndCorners(
        thumbCenter.dx,
        (textDirection == TextDirection.rtl) ? trackRect.top - (additionalActiveTrackHeight / 2) : trackRect.top,
        trackRect.right+20,
        (textDirection == TextDirection.rtl) ? trackRect.bottom + (additionalActiveTrackHeight / 2) : trackRect.bottom,
        topRight: (textDirection == TextDirection.rtl) ? activeTrackRadius : trackRadius,
        bottomRight: (textDirection == TextDirection.rtl) ? activeTrackRadius : trackRadius,
      ),
      rightTrackPaint,
    );

    final bool showSecondaryTrack = (secondaryOffset != null) &&
        ((textDirection == TextDirection.ltr)
            ? (secondaryOffset.dx > thumbCenter.dx)
            : (secondaryOffset.dx < thumbCenter.dx));

    if (showSecondaryTrack) {
      final ColorTween secondaryTrackColorTween = ColorTween(begin: sliderTheme.disabledSecondaryActiveTrackColor, end: sliderTheme.secondaryActiveTrackColor);
      final Paint secondaryTrackPaint = Paint()..color = secondaryTrackColorTween.evaluate(enableAnimation)!;
      if (textDirection == TextDirection.ltr) {
        context.canvas.drawRRect(
          RRect.fromLTRBAndCorners(
            thumbCenter.dx,
            trackRect.top,
            secondaryOffset.dx,
            trackRect.bottom,
            topRight: trackRadius,
            bottomRight: trackRadius,
          ),
          secondaryTrackPaint,
        );
      } else {
        context.canvas.drawRRect(
          RRect.fromLTRBAndCorners(
            secondaryOffset.dx,
            trackRect.top,
            thumbCenter.dx,
            trackRect.bottom,
            topLeft: trackRadius,
            bottomLeft: trackRadius,
          ),
          secondaryTrackPaint,
        );
      }
    }
  }
}