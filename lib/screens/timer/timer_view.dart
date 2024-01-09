/*
 *  timer_view.dart
 *
 *  Created by Ilya Chirkunov <xc@yar.net> on 14.11.2020.
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:single_radio/theme.dart';
import 'package:single_radio/language.dart';
import 'package:single_radio/extensions/duration_extension.dart';
import 'package:single_radio/widgets/screen.dart';
import 'package:single_radio/widgets/expanded_box.dart';
import 'package:single_radio/screens/timer/timer_viewmodel.dart';

class TimerView extends StatefulWidget {
  const TimerView({super.key});
  static const routeName = '/timer';

  @override
  State<TimerView> createState() => _TimerViewState();
}

class _TimerViewState extends State<TimerView> {
  late final viewModel = Provider.of<TimerViewModel>(context, listen: true);

  @override
  Widget build(BuildContext context) {
    return Screen(
      title: Language.sleepTimer,
      hideOverscrollIndicator: true,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const ExpandedBox(minHeight: 30),
            const _CircularSlider(),
            const ExpandedBox(minHeight: 30),
            viewModel.timer?.isActive ?? false
                ? _Button(
                    title: Language.stopTimer,
                    color: AppTheme.timerStopButtonBackgroundColor,
                    textColor: AppTheme.timerStopButtonFontColor,
                    onTap: viewModel.stopTimer,
                  )
                : _Button(
                    title: Language.startTimer,
                    color: AppTheme.timerButtonBackgroundColor,
                    textColor: AppTheme.timerButtonFontColor,
                    onTap: viewModel.startTimer,
                  ),
            const ExpandedBox(minHeight: 30),
          ],
        ),
      ),
    );
  }
}

class _CircularSlider extends StatelessWidget {
  const _CircularSlider();

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<TimerViewModel>(context, listen: true);

    return SleekCircularSlider(
      appearance: CircularSliderAppearance(
        size: 260,
        startAngle: 270,
        angleRange: 360,
        customWidths: CustomSliderWidths(
          trackWidth: 5,
          progressBarWidth: 30,
          handlerSize: 6,
          shadowWidth: 42,
        ),
        customColors: CustomSliderColors(
          trackColor: AppTheme.timerSliderTrackColor,
          progressBarColor: AppTheme.timerSliderColor,
          shadowColor: AppTheme.timerSliderColor,
          dotColor: AppTheme.timerSliderDotColor,
          shadowMaxOpacity: 0.1,
        ),
      ),
      onChange: (double value) {
        viewModel.setTimer(Duration(seconds: value.toInt()));
      },
      initialValue: viewModel.timerDuration.inSeconds.toDouble(),
      min: 0,
      max: 5400,
      innerWidget: (value) {
        return _TimeLeft(
          time: viewModel.timerDuration.format(),
        );
      },
    );
  }
}

class _TimeLeft extends StatelessWidget {
  const _TimeLeft({
    required this.time,
  });

  final String time;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          Language.timeLeft,
          style: TextStyle(
            color: AppTheme.timerSliderFontColor,
            fontWeight: FontWeight.lerp(
              FontWeight.w400,
              FontWeight.w600,
              AppTheme.fontWeight,
            ),
          ),
        ),
        const SizedBox(height: 15),
        Text(
          time,
          style: TextStyle(
            fontSize: 22,
            color: AppTheme.timerSliderFontColor,
            fontWeight: FontWeight.lerp(
              FontWeight.w500,
              FontWeight.w700,
              AppTheme.fontWeight,
            ),
          ),
        ),
      ],
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    required this.title,
    required this.color,
    required this.textColor,
    required this.onTap,
  });

  final Color textColor;
  final Color color;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(textColor),
        backgroundColor: MaterialStateProperty.all<Color>(color),
        minimumSize: MaterialStateProperty.all<Size>(const Size(180, 40)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        ),
      ),
      onPressed: onTap,
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.lerp(
            FontWeight.w500,
            FontWeight.w700,
            AppTheme.fontWeight,
          ),
        ),
      ),
    );
  }
}
