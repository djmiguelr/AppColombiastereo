/*
 *  player_view.dart
 *
 *  Created by Ilya Chirkunov <xc@yar.net> on 14.11.2020.
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:text_scroll/text_scroll.dart';
import 'package:single_radio/config.dart';
import 'package:single_radio/theme.dart';
import 'package:single_radio/widgets/screen.dart';
import 'package:single_radio/widgets/faded_box.dart';
import 'package:single_radio/widgets/expanded_box.dart';
import 'package:single_radio/screens/player/player_viewmodel.dart';

class PlayerView extends StatefulWidget {
  const PlayerView({super.key});
  static const routeName = '/';

  @override
  State<PlayerView> createState() => _PlayerViewState();
}

class _PlayerViewState extends State<PlayerView> {
  late final viewModel = Provider.of<PlayerViewModel>(context, listen: true);
  double get padding => MediaQuery.of(context).size.width * 0.08;

  @override
  Widget build(BuildContext context) {
    return Screen(
      title: Config.title,
      home: true,
      hideOverscrollIndicator: true,
      child: Column(
        children: [
          const ExpandedBox(flex: 2, minHeight: 20),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: _Cover(
              key: viewModel.artwork?.key,
              size: MediaQuery.of(context).size.width - padding * 2,
              image: viewModel.artwork ??
                  Image.asset(
                    'assets/images/cover.jpg',
                    fit: BoxFit.cover,
                  ),
            ),
          ),
          const ExpandedBox(flex: 4, minHeight: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _Title(
                artist: viewModel.artist,
                track: viewModel.track,
              ),
              const SizedBox(width: 20),
              _ControlButton(
                isPlaying: viewModel.isPlaying,
                play: viewModel.play,
                pause: viewModel.pause,
              ),
            ],
          ),
          const ExpandedBox(flex: 1, minHeight: 10),
          Slider(
            value: viewModel.volume,
            min: 0,
            max: 100,
            divisions: 100,
            label: viewModel.volume.round().toString(),
            onChanged: viewModel.setVolume,
          ),
          const ExpandedBox(flex: 1, minHeight: 10),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class _Cover extends StatelessWidget {
  const _Cover({
    super.key,
    required this.image,
    required this.size,
  });

  final Image image;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: const [
            BoxShadow(
              color: AppTheme.artworkShadowColor,
              offset: AppTheme.artworkShadowOffset,
              blurRadius: AppTheme.artworkShadowRadius,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: image,
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({
    required this.artist,
    required this.track,
  });

  final String artist;
  final String track;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FadedBox(
        height: 65,
        alignment: AlignmentDirectional.centerEnd,
        gradientWidth: 20,
        colors: [
          AppTheme.backgroundColor.withOpacity(0),
          AppTheme.backgroundColor,
        ],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextScroll(
              artist,
              numberOfReps: Config.textScrolling ? null : 0,
              intervalSpaces: 7,
              velocity: const Velocity(pixelsPerSecond: Offset(30, 0)),
              delayBefore: const Duration(seconds: 1),
              pauseBetween: const Duration(seconds: 2),
              style: TextStyle(
                fontSize: 24,
                color: AppTheme.artistFontColor,
                fontWeight: FontWeight.lerp(
                  FontWeight.w700,
                  FontWeight.w800,
                  AppTheme.fontWeight,
                ),
              ),
            ),
            TextScroll(
              track,
              numberOfReps: Config.textScrolling ? null : 0,
              intervalSpaces: 10,
              velocity: const Velocity(pixelsPerSecond: Offset(40, 0)),
              delayBefore: const Duration(seconds: 1),
              pauseBetween: const Duration(seconds: 2),
              style: TextStyle(
                fontSize: 16,
                color: AppTheme.trackFontColor,
                fontWeight: FontWeight.lerp(
                  FontWeight.w700,
                  FontWeight.w800,
                  AppTheme.fontWeight,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ControlButton extends StatelessWidget {
  const _ControlButton({
    required this.isPlaying,
    required this.play,
    required this.pause,
  });

  final bool isPlaying;
  final VoidCallback play;
  final VoidCallback pause;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        color: AppTheme.controlButtonColor,
        child: InkWell(
          splashColor: AppTheme.controlButtonSplashColor,
          child: SizedBox(
            width: 70,
            height: 70,
            child: Icon(
              isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
              size: 38,
              color: AppTheme.controlButtonIconColor,
            ),
          ),
          onTap: () => isPlaying ? pause() : play(),
        ),
      ),
    );
  }
}
