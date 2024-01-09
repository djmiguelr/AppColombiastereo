/*
 *  expanded_box.dart
 *
 *  Created by Ilya Chirkunov <xc@yar.net> on 07.03.2023.
 */

import 'package:flutter/material.dart';

class ExpandedBox extends StatelessWidget {
  const ExpandedBox({
    super.key,
    this.flex = 1,
    this.minWidth = 0.0,
    this.minHeight = 0.0,
    this.child,
  });

  final int flex;
  final double minWidth;
  final double minHeight;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: minWidth,
          minHeight: minHeight,
        ),
        child: child,
      ),
    );
  }
}
