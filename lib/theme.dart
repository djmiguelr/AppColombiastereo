/*
 *  theme.dart
 *
 *  Created by Ilya Chirkunov <xc@yar.net> on 15.12.2021.
 */

import 'package:flutter/material.dart';
import 'package:single_radio/extensions/slider_track_shape.dart';

class AppTheme {
  // Primary colors in ARGB format.
  static const headerColor = Color.fromARGB(116, 0, 191, 255);
  static const foregroundColor = Color(0xFFFFFFFF);
  static const backgroundColor = Color(0xFF172230);
  static const accentColor = Color.fromARGB(255, 255, 0, 0);

  // Constants for detailed customization.
  static const appBarColor = headerColor;
  static const appBarFontColor = foregroundColor;
  static const appBarElevation = 4.0;

  static const artistFontColor = foregroundColor;
  static final trackFontColor = foregroundColor.withOpacity(0.25);

  static const controlButtonColor = accentColor;
  static const controlButtonSplashColor = Color(0xFFFFFFFF);
  static const controlButtonIconColor = foregroundColor;

  static const volumeSliderActiveColor = accentColor;
  static final volumeSliderOverlayColor = accentColor.withOpacity(0.12);
  static final volumeSliderInactiveColor = foregroundColor.withOpacity(0.05);

  static const drawerHeaderBackgroundColor = headerColor;
  static const drawerBackgroundColor = backgroundColor;
  static const drawerTitleFontColor = foregroundColor;
  static const drawerTitlePadding = 16.0;
  static final drawerDescriptionFontColor = foregroundColor.withOpacity(0.25);
  static const drawerItemIconColor = foregroundColor;
  static const drawerItemFontColor = foregroundColor;

  static const artworkShadowColor = Color(0x30000000);
  static const artworkShadowOffset = Offset(2.0, 2.0);
  static const artworkShadowRadius = 8.0;

  static const aboutUsTitleColor = foregroundColor;
  static final aboutUsDescriptionColor = foregroundColor.withOpacity(0.25);
  static final aboutUsFontColor = foregroundColor.withOpacity(0.9);
  static const aboutUsContainerTitleColor = Color(0x00ffff00);
  static const aboutUsContainerBackgroundColor = headerColor;

  static const timerColor = foregroundColor;
  static const timerButtonFontColor = foregroundColor;
  static const timerButtonBackgroundColor = Color.fromARGB(255, 5, 8, 10);
  static const timerStopButtonFontColor = foregroundColor;
  static const timerStopButtonBackgroundColor = Color(0xFF9E9E9E);
  static const timerSliderColor = Color(0xFF2196F3);
  static const timerSliderTrackColor = Color(0xFFBBDEFB);
  static const timerSliderDotColor = foregroundColor;
  static const timerSliderFontColor = foregroundColor;

  // You can replace font files in "fonts" directory.
  // To use the default system font, set to null.
  static const fontFamily = 'Custom';

  // The font weight can be adjusted by setting a value between 0.0 and 1.0.
  // For default system font, set this value to 0.0
  static const fontWeight = 0.9;

  // Don't edit this constant.
  static final themeData = ThemeData(
    fontFamily: fontFamily,
    canvasColor: backgroundColor,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: accentColor,
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: foregroundColor),
    ),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      elevation: appBarElevation,
      backgroundColor: appBarColor,
      foregroundColor: appBarFontColor,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.lerp(
          FontWeight.w500,
          FontWeight.w700,
          fontWeight,
        ),
        fontFamily: fontFamily,
      ),
    ),
    sliderTheme: SliderThemeData(
      trackShape: RoundSliderTrackShape(),
      activeTrackColor: volumeSliderActiveColor,
      thumbColor: volumeSliderActiveColor,
      overlayColor: volumeSliderOverlayColor,
      inactiveTrackColor: volumeSliderInactiveColor,
      activeTickMarkColor: Colors.transparent,
      inactiveTickMarkColor: Colors.transparent,
    ),
    listTileTheme: const ListTileThemeData(
      iconColor: drawerItemIconColor,
      textColor: drawerItemFontColor,
    ),
  );
}
