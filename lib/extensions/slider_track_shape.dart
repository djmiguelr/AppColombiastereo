/*
 *  RoundSliderTrackShape.dart
 *
 *  Created by Ilya Chirkunov <xc@yar.net> on 18.12.2020.
 */

import 'package:flutter/material.dart';

class RoundSliderTrackShape extends SliderTrackShape {
  final double disabledThumbGapWidth = 0;
  final double radius = 4;

  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    // NotNull
    final double trackHeight = sliderTheme.trackHeight!;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required Offset thumbCenter,
    Offset? secondaryOffset,
    bool isDiscrete = false,
    bool isEnabled = false,
    required TextDirection textDirection,
  }) {
    if (sliderTheme.trackHeight == 0) {
      return;
    }

    final ColorTween activeTrackColorTween = ColorTween(
        begin: sliderTheme.disabledActiveTrackColor,
        end: sliderTheme.activeTrackColor);
    final ColorTween inactiveTrackColorTween = ColorTween(
        begin: sliderTheme.disabledInactiveTrackColor,
        end: sliderTheme.inactiveTrackColor);

    // NotNull
    final Paint activePaint = Paint()
      ..color = activeTrackColorTween.evaluate(enableAnimation)!;
    // NotNull
    final Paint inactivePaint = Paint()
      ..color = inactiveTrackColorTween.evaluate(enableAnimation)!;

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

    double horizontalAdjustment = 0.0;

    if (!isEnabled) {
      // NotNull
      final double disabledThumbRadius =
          sliderTheme.thumbShape!.getPreferredSize(false, isDiscrete).width /
              2.0;
      final double gap = disabledThumbGapWidth * (1.0 - enableAnimation.value);
      horizontalAdjustment = disabledThumbRadius + gap;
    }

    final Rect trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );

    final RRect leftTrackSegment = RRect.fromLTRBR(
      trackRect.left,
      trackRect.top,
      thumbCenter.dx - horizontalAdjustment,
      trackRect.bottom,
      Radius.circular(radius),
    );
    context.canvas.drawRRect(leftTrackSegment, leftTrackPaint);

    final RRect rightTrackSegment = RRect.fromLTRBR(
      thumbCenter.dx + horizontalAdjustment,
      trackRect.top,
      trackRect.right,
      trackRect.bottom,
      Radius.circular(radius),
    );
    context.canvas.drawRRect(rightTrackSegment, rightTrackPaint);
  }
}
