/*
 *  duration_extension.dart
 *
 *  Created by Ilya Chirkunov <xc@yar.net> on 02.01.2022.
 */

extension DurationExtension on Duration {
  String format() {
    final hours = inHours;
    final minutes = inMinutes % 60;
    final seconds = inSeconds % 60;

    // ignore: prefer_interpolation_to_compose_strings
    return hours.toString().padLeft(2, "0") +
        ':' +
        minutes.toString().padLeft(2, "0") +
        ':' +
        seconds.toString().padLeft(2, "0");
  }
}
