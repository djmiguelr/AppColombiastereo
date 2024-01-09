/*
 *  player_viewmodel.dart
 *
 *  Created by Ilya Chirkunov <xc@yar.net> on 14.11.2020.
 */

import 'package:flutter/material.dart';
import 'package:radio_player/radio_player.dart';
import 'package:volume_regulator/volume_regulator.dart';
import 'package:single_radio/config.dart';
import 'package:single_radio/language.dart';
import 'package:single_radio/services/metadata_service.dart';
import 'package:single_radio/services/smartstop_service.dart';

class PlayerViewModel with ChangeNotifier {
  final _radioPlayer = RadioPlayer();
  bool isPlaying = false;
  double volume = 0;
  Image? artwork;
  List<String>? metadata;
  MetadataService? _metadataService;
  SmartstopService? _smartstopService;

  String get artist => metadata?[0].trim() ?? _greeting;
  String get track => metadata?[1].trim() ?? Config.title;

  PlayerViewModel() {
    _smartstopService = SmartstopService(
      callback: _radioPlayer.stop,
      duration: const Duration(seconds: 60),
    );

    if (Config.albumCoverFromItunes) {
      _radioPlayer.itunesArtworkParser(true);
    }

    if (Config.metadataUrl.isNotEmpty) {
      _radioPlayer.ignoreIcyMetadata();

      _metadataService = MetadataService(
        callback: (value) => _radioPlayer.setCustomMetadata(value),
      );
    }

    VolumeRegulator.getVolume().then((value) {
      volume = value.toDouble();
      notifyListeners();
    });

    VolumeRegulator.volumeStream.listen((value) {
      volume = value.toDouble();
      notifyListeners();
    });

    _radioPlayer
        .setChannel(
            title: Config.title,
            url: Config.streamUrl,
            imagePath: 'assets/images/cover.jpg')
        .then((_) {
      if (Config.autoplay) play();
    });

    _radioPlayer.metadataStream.listen((value) async {
      metadata = value;
      if (Config.showAlbumCover) artwork = await _radioPlayer.getArtworkImage();
      notifyListeners();
    });

    _radioPlayer.stateStream.listen((state) {
      if (isPlaying == state) return;
      isPlaying = state;
      isPlaying ? _onPlay() : _onPause();
    });
  }

  void play() {
    isPlaying = true;
    _radioPlayer.play();
    _onPlay();
  }

  void pause() {
    isPlaying = false;
    _radioPlayer.pause();
    _onPause();
  }

  void _onPlay() {
    notifyListeners();
    _metadataService?.start();
    _smartstopService?.stop();
  }

  void _onPause() {
    notifyListeners();
    _metadataService?.stop();
    _smartstopService?.start();
  }

  void setVolume(double value) {
    VolumeRegulator.setVolume(value.toInt());
    notifyListeners();
  }

  String get _greeting {
    int hour = DateTime.now().hour;

    if (hour < 12) {
      return Language.goodMorning;
    } else if (hour < 17) {
      return Language.goodAfternoon;
    } else {
      return Language.goodEvening;
    }
  }
}
