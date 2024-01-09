/*
 *  config.dart
 *
 *  Created by Ilya Chirkunov <xc@yar.net> on 12.12.2020.
 */

class Config {
  static const title = 'La Colombiana Stereo ';
  static const description = 'La emisora de los colombianos en el exterior';
  static const streamUrl = 'https://radio.milivingradio.com/listen/la_colombiana_stereo/radio.mp3';

  // Social links
  static const instagram = '';
  static const twitter = 'https://twitter.com/FlutterDev';
  static const facebook = 'https://www.facebook.com/FlutterCommunity/';
  static const website = 'https://lacolombianastereo.com/';
  static const email = 'contacto@lacolombianastereo.com';

  // Share
  static const shareSubject = 'La Colombiana Stereo';
  static const shareText = "Sientete como en Colombia";

  // Rate Us
  static const appStoreId = '0123456789';

  // Automatically start playing when the app is launched.
  static const autoplay = true;

  // Replace default image with album cover.
  static const showAlbumCover = true;

  // Search album cover on iTunes.
  static const albumCoverFromItunes = true;

  // Long text scrolling.
  static const textScrolling = true;

  // See documentation to enable Admob.
  static const admobIosAdUnit = 'ca-app-pub-3940256099942544/6300978111';
  static const admobAndroidAdUnit = 'ca-app-pub-3940256099942544/6300978111';

  // Parse metadata from third-party sources.
  static const metadataUrl = '';
  static const artistTag = 'artist';
  static const trackTag = 'title';
  static const coverTag = 'thumb';
  static const titleTag = '';
  static const titleSeparator = ' - ';
  static const timerPeriod = 2;
}
