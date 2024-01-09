/*
 *  admob_enable.dart
 *
 *  Created by Ilya Chirkunov <xc@yar.net> on 08.07.2022.
 */

import 'dart:io';
import 'package:dart_common_utils/dart_common_utils.dart';

void main() {
  step1();
  step2();
  step3();
  //step4();
}

// Clean project.
void step1() {
  File('ios/Podfile.lock').adaptPath.deleteIfExistsSync();
  Directory('ios/Pods').adaptPath.deleteIfExistsSync(recursive: true);
  Directory('ios/.symlinks').adaptPath.deleteIfExistsSync(recursive: true);
}

// Add dependencies to 'pubspec.yaml' file.
void step2() {
  const filename = 'pubspec.yaml';
  const line = 'google_mobile_ads: 2.3.0';

  final content = File(filename).adaptPath.readAsStringSync();
  if (!content.contains('#$line')) System.die('Admob is already enabled.');

  File(filename).adaptPath.replaceContent('#$line', line);
}

// Rename Off and Dummy files.
void step3() {
  const filename = 'lib/services/admob_service.dart';
  const filenameOff = 'lib/services/admob_service.off';
  const filenameDummy = 'lib/services/admob_service.dummy';

  if (!File(filename).adaptPath.existsSync()) {
    System.die('File "$filename" not found.');
  }

  if (!File(filenameOff).adaptPath.existsSync()) {
    System.die('File "$filenameOff" not found.');
  }

  File(filename).adaptPath.renameSync(File(filenameDummy).adaptPath.path);
  File(filenameOff).adaptPath.renameSync(File(filename).adaptPath.path);
}

// Add the NSUserTrackingUsageDescription key to Info.plist.
void step4() {
  const filename = 'ios/Runner/Info.plist';
  const line1 = "<key>NSUserTrackingUsageDescription</key>";
  const line1tmp = "<key>AdmobKey1</key>";
  const line2 =
      "<string>This identifier will be used to deliver personalized ads to you.</string>";
  const line2tmp = "<string>AdmobString1</string>";

  File(filename).adaptPath.replaceContent(line1tmp, line1);
  File(filename).adaptPath.replaceContent(line2tmp, line2);
}
