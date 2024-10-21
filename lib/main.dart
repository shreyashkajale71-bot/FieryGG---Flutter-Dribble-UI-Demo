import 'package:fiery_gg/ui/splash.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'FieryGG - Flutter Dribble UI Demo ',
      home: SplashScreen(),
    );
  }
}
