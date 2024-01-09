/*
 *  screen.dart
 *
 *  Created by Ilya Chirkunov <xc@yar.net> on 17.11.2022.
 */

import 'package:flutter/material.dart';
import 'package:back_button_behavior/back_button_behavior.dart';
import 'package:single_radio/widgets/sidebar.dart';
import 'package:single_radio/widgets/expanded_scroll_view.dart';
import 'package:single_radio/widgets/bottom_banner.dart';

class Screen extends StatelessWidget {
  const Screen({
    super.key,
    required this.title,
    this.home = false,
    required this.child,
    this.padding,
    this.hideOverscrollIndicator = false,
  });

  final String title;
  final bool home;
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final bool hideOverscrollIndicator;

  @override
  Widget build(BuildContext context) {
    return BackButtonBehavior(
      onBackTap: home ? BackButtonAction.minimize : BackButtonAction.pop,
      child: Scaffold(
        appBar: AppBar(title: Text(title)),
        drawer: home ? Sidebar() : null,
        body: ExpandedScrollView(
          hideOverscrollIndicator: hideOverscrollIndicator,
          child: BottomBanner(
            enabled: home,
            child: Padding(
              padding: padding ??
                  EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.08,
                  ),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
