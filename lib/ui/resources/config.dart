import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LayoutConfig {
  final double headerHeight;
  final double sidebarWidth;
  final double sidebarHeight;
  final double contentPadding;
  final double borderRadius;

  LayoutConfig({
    this.headerHeight = 50,
    this.sidebarWidth = 60,
    this.sidebarHeight = 60,
    this.contentPadding = 10,
    this.borderRadius = 15,
  });

  double get contentLeftPadding => sidebarWidth + contentPadding;
  double get contentTopPadding => headerHeight + contentPadding;
  double get contentBottomPadding => sidebarHeight + contentPadding;
}

class SplashConfig {
  static const String title = 'by Tilarna';
  static const String logoPath = 'assets/images/logo.gif';
  static const double logoHeight = 300;

  static const List<SocialLink> socialLinks = [
    SocialLink(icon: FontAwesomeIcons.github, text: 'TilarnaExdilika'),
    SocialLink(icon: FontAwesomeIcons.discord, text: '_tilarna'),
    SocialLink(icon: FontAwesomeIcons.facebookMessenger, text: 'IShino.Avery'),
  ];

  static const String uiCredit = 'UI by';
  static const String uiCreditName = 'Sok Studio';
  static const String uiCreditImagePath = 'assets/images/dribble_author.png';
}

class SocialLink {
  final IconData icon;
  final String text;

  const SocialLink({required this.icon, required this.text});
}
