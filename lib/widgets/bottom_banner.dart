/*
 *  bottom_banner.dart
 *
 *  Created by Ilya Chirkunov <xc@yar.net> on 07.03.2023.
 */

import 'package:flutter/material.dart';
import 'package:single_radio/services/admob_service.dart';

class BottomBanner extends StatelessWidget {
  const BottomBanner({
    super.key,
    this.enabled = false,
    required this.child,
  });

  final bool enabled;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: child),
        enabled ? AdmobService.bannerBottom : const SizedBox.shrink(),
      ],
    );
  }
}
