/*
 *  markdown.dart
 *
 *  Created by Ilya Chirkunov <xc@yar.net> on 07.05.2021.
 */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:single_radio/language.dart';

/// Shows the dialog box containing the MarkdownText.
class MarkdownDialog extends StatelessWidget {
  const MarkdownDialog({
    super.key,
    required this.filename,
  });

  final String filename;
  final EdgeInsetsGeometry padding = const EdgeInsets.all(15);
  final TextStyle textStyle =
      const TextStyle(fontSize: 14, color: Colors.black);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      child: SizedBox(
        height: 500,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: padding,
                  child: MarkdownText(
                    filename: filename,
                    textStyle: textStyle,
                  ),
                ),
              ),
            ),
            Row(
              children: [
                const Spacer(),
                TextButton(
                  child: const Text(Language.privacyPolicyClose),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Displays formatted text.
class MarkdownText extends StatelessWidget {
  const MarkdownText({
    super.key,
    required this.filename,
    this.textStyle,
  });

  final String filename;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    if (textStyle != null) {
      textTheme = TextTheme(bodyMedium: textStyle);
    }

    return FutureBuilder<String>(
      future: rootBundle.loadString(filename),
      builder: (context, snapshot) {
        if (snapshot.hasData == true) {
          return MarkdownBody(
            styleSheet: MarkdownStyleSheet.fromTheme(
              ThemeData(
                textTheme: textTheme,
              ),
            ),
            data: snapshot.data!,
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
