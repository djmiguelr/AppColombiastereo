/*
 *  about_view.dart
 *
 *  Created by Ilya Chirkunov <xc@yar.net> on 05.04.2021.
 */

import 'package:flutter/material.dart';
import 'package:single_radio/config.dart';
import 'package:single_radio/theme.dart';
import 'package:single_radio/language.dart';
import 'package:single_radio/widgets/screen.dart';
import 'package:single_radio/widgets/markdown.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});
  static const routeName = '/about';

  @override
  Widget build(BuildContext context) {
    return const Screen(
      title: Language.aboutUs,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30),
          _Profile(),
          SizedBox(height: 30),
          _Description(),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}

class _Profile extends StatelessWidget {
  const _Profile();

  @override
  Widget build(BuildContext context) {
    return _Container(
      title: Language.profile,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 25),
      child: Column(
        children: [
          Text(
            Config.title,
            style: TextStyle(
              color: AppTheme.aboutUsTitleColor,
              fontSize: 20,
              fontWeight: FontWeight.lerp(
                FontWeight.w500,
                FontWeight.w700,
                AppTheme.fontWeight,
              ),
            ),
          ),
          const SizedBox(height: 7),
          Text(
            Config.description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: AppTheme.aboutUsDescriptionColor,
              fontWeight: FontWeight.lerp(
                FontWeight.w500,
                FontWeight.w700,
                AppTheme.fontWeight,
              ),
            ),
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Image.asset(
              'assets/images/about.jpg',
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}

class _Description extends StatelessWidget {
  const _Description();

  @override
  Widget build(BuildContext context) {
    return _Container(
      title: Language.description,
      padding: const EdgeInsets.all(18),
      child: MarkdownText(
        filename: 'assets/text/about.md',
        textStyle: TextStyle(
          color: AppTheme.aboutUsFontColor,
          fontSize: 14,
          height: 1.3,
          fontFamily: AppTheme.fontFamily,
          fontWeight: FontWeight.lerp(
            FontWeight.w400,
            FontWeight.w600,
            AppTheme.fontWeight,
          ),
        ),
      ),
    );
  }
}

class _Container extends StatelessWidget {
  const _Container({
    required this.title,
    this.padding,
    required this.child,
  });

  final String title;
  final EdgeInsetsGeometry? padding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 6, left: 18),
          child: Text(
            title,
            style: TextStyle(
              color: AppTheme.aboutUsContainerTitleColor,
              fontWeight: FontWeight.lerp(
                FontWeight.w400,
                FontWeight.w600,
                AppTheme.fontWeight,
              ),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          padding: padding,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppTheme.aboutUsContainerBackgroundColor,
          ),
          child: child,
        ),
      ],
    );
  }
}
