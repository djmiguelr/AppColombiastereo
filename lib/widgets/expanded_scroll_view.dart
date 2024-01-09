/*
 *  expanded_scroll_view.dart
 *
 *  Created by Ilya Chirkunov <xc@yar.net> on 07.03.2023.
 */

import 'package:flutter/material.dart';
import 'package:single_radio/helpers/hide_overscroll_indicator.dart';

class ExpandedScrollView extends StatelessWidget {
  const ExpandedScrollView({
    super.key,
    required this.child,
    this.hideOverscrollIndicator = false,
  });

  final Widget child;
  final bool hideOverscrollIndicator;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      scrollBehavior:
          hideOverscrollIndicator ? HideOverscrollIndicator() : null,
      physics: hideOverscrollIndicator ? const ClampingScrollPhysics() : null,
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: child,
        ),
      ],
    );
  }
}
