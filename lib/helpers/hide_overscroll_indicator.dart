/*
 *  hide_overscroll_indicator.dart
 *
 *  Created by Ilya Chirkunov <xc@yar.net> on 03.11.2022.
 */

import 'package:flutter/material.dart';

class HideOverscrollIndicator extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
