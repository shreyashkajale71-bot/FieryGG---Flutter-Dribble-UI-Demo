import 'package:fiery_gg/ui/widgets/demo_tab.dart';
import 'package:fiery_gg/ui/widgets/game_tab.dart';
import 'package:flutter/material.dart';

class TabItem {
  final String title;
  final IconData icon;
  final Widget content;

  TabItem({required this.title, required this.icon, required this.content});
}

final List<TabItem> tabItems = [
  TabItem(title: 'Game', icon: Icons.dashboard, content: const GameTab()),
  TabItem(
      title: 'Jackpot',
      icon: Icons.settings_suggest,
      content: const DemoTab(text: 'Jackpot')),
  TabItem(
      title: 'Roulette',
      icon: Icons.person,
      content: const DemoTab(text: 'Roulette')),
  TabItem(
      title: 'Slots',
      icon: Icons.casino,
      content: const DemoTab(text: 'Slots')),
  TabItem(
      title: 'Coinflip',
      icon: Icons.monetization_on,
      content: const DemoTab(text: 'Coinflip')),
  TabItem(
      title: 'Cases',
      icon: Icons.diamond,
      content: const DemoTab(text: 'Cases')),
  TabItem(
      title: 'Crash',
      icon: Icons.rocket_launch,
      content: const DemoTab(text: 'Crash')),
];
