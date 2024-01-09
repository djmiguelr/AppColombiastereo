/*
 *  sidebar.dart
 *
 *  Created by Ilya Chirkunov <xc@yar.net> on 14.11.2020.
 */

import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:single_radio/config.dart';
import 'package:single_radio/theme.dart';
import 'package:single_radio/language.dart';
import 'package:single_radio/widgets/markdown.dart';
import 'package:single_radio/screens/about/about_view.dart';

class Sidebar extends StatelessWidget {
  Sidebar({super.key});
  final inAppReview = InAppReview.instance;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppTheme.drawerBackgroundColor,
      child: ListView(
        padding: const EdgeInsets.only(top: 0),
        children: [
          const _Header(),
          ..._buildItems(context),
        ],
      ),
    );
  }

  List<Widget> _buildItems(BuildContext context) {
    return [
      // Timer
      _Item(
        icon: Icons.watch_later_outlined,
        title: Language.timer,
        onTap: () {
          Navigator.pop(context);
          Navigator.pushNamed(context, '/timer');
        },
      ),

      // Instagram
      _Item(
        svgFileName: 'assets/icons/instagram.svg',
        title: Language.instagram,
        visible: Config.instagram.isNotEmpty,
        onTap: () async {
          Navigator.pop(context);
          await launchUrl(Uri.parse(Config.instagram),
              mode: LaunchMode.externalApplication);
        },
      ),

      // Twitter
      _Item(
        svgFileName: 'assets/icons/twitter.svg',
        title: Language.twitter,
        visible: Config.twitter.isNotEmpty,
        onTap: () async {
          Navigator.pop(context);
          await launchUrl(Uri.parse(Config.twitter),
              mode: LaunchMode.externalApplication);
        },
      ),

      // Facebook
      _Item(
        svgFileName: 'assets/icons/facebook.svg',
        title: Language.facebook,
        visible: Config.facebook.isNotEmpty,
        onTap: () async {
          Navigator.pop(context);
          await launchUrl(Uri.parse(Config.facebook),
              mode: LaunchMode.externalApplication);
        },
      ),

      // Website
      _Item(
        svgFileName: 'assets/icons/website.svg',
        title: Language.website,
        visible: Config.website.isNotEmpty,
        onTap: () async {
          Navigator.pop(context);
          await launchUrl(Uri.parse(Config.website),
              mode: LaunchMode.externalApplication);
        },
      ),

      // Email
      _Item(
        icon: Icons.email_outlined,
        title: Language.email,
        visible: Config.email.isNotEmpty,
        onTap: () async {
          Navigator.pop(context);
          launchUrl(
            Uri(
              scheme: 'mailto',
              path: Config.email,
              query: 'subject=${Config.title}',
            ),
          );
        },
      ),

      // Rate Us
      _Item(
        icon: Icons.star_outline,
        title: Language.rateUs,
        onTap: () {
          Navigator.pop(context);
          inAppReview.openStoreListing(appStoreId: Config.appStoreId);
        },
      ),

      // Privacy Policy
      _Item(
        icon: Icons.description_outlined,
        title: Language.privacyPolicy,
        onTap: () {
          Navigator.pop(context);

          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const MarkdownDialog(
                filename: 'assets/text/privacy_policy.md',
              );
            },
          );
        },
      ),

      // Share
      _Item(
        icon: Icons.share_outlined,
        title: Language.share,
        onTap: () {
          Navigator.pop(context);
          Share.share(Config.shareText, subject: Config.shareSubject);
        },
      ),

      // About Us
      _Item(
        icon: Icons.group_outlined,
        title: Language.aboutUs,
        onTap: () {
          Navigator.pop(context);
          Navigator.pushNamed(context, AboutView.routeName);
        },
      ),
    ];
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Container(
      color: AppTheme.drawerHeaderBackgroundColor,
      padding: EdgeInsets.only(
        left: AppTheme.drawerTitlePadding,
        top: statusBarHeight + 16,
        right: AppTheme.drawerTitlePadding,
        bottom: 8,
      ),
      constraints: BoxConstraints(minHeight: statusBarHeight + 160.0 + 1.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Image.asset(
              'assets/images/sidebar.png',
              width: 55,
              height: 55,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            Config.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.lerp(
                FontWeight.w500,
                FontWeight.w700,
                AppTheme.fontWeight,
              ),
              fontSize: 20,
              height: 1.5,
              color: AppTheme.drawerTitleFontColor,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            Config.description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.lerp(
                FontWeight.w500,
                FontWeight.w700,
                AppTheme.fontWeight,
              ),
              fontSize: 14,
              height: 1.5,
              color: AppTheme.drawerDescriptionFontColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({
    this.icon,
    this.svgFileName,
    this.visible = true,
    required this.title,
    required this.onTap,
  });

  final IconData? icon;
  final String? svgFileName;
  final bool visible;
  final String title;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return visible
        ? ListTile(
            leading: icon != null
                ? Icon(
                    icon,
                    size: 24,
                    semanticLabel: '$title Icon',
                  )
                : SvgPicture.asset(
                    svgFileName!,
                    width: 24,
                    height: 24,
                    color: AppTheme.drawerItemIconColor,
                    semanticsLabel: '$title Icon',
                  ),
            title: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.lerp(
                  FontWeight.w500,
                  FontWeight.w700,
                  AppTheme.fontWeight,
                ),
                fontSize: 16,
              ),
            ),
            onTap: onTap,
          )
        : const SizedBox.shrink();
  }
}
