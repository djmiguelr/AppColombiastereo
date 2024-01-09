/*
 *  smartstop_service.dart
 *
 *  Created by Ilya Chirkunov <xc@yar.net> on 04.02.2022.
 */

import 'dart:async';
import 'package:flutter/foundation.dart';

class SmartstopService {
  SmartstopService({
    required this.callback,
    required this.duration,
  });

  VoidCallback callback;
  Duration duration;
  Duration _count = Duration.zero;
  final _timerPeriod = const Duration(seconds: 1);
  Timer? _timer;

  void start() => _timer = Timer.periodic(_timerPeriod, _onTick);
  void stop() => _timer?.cancel();

  Future<void> _onTick(Timer t) async {
    _count += _timerPeriod;

    if (_count >= duration) {
      _count = Duration.zero;
      t.cancel();
      callback();
    }
  }
}
