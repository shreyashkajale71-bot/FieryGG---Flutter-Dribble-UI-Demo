import 'package:fiery_gg/ui/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Color(0xFF171925),
    systemNavigationBarColor: Color(0xFF171925),
  ));
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'FieryGG - Flutter Dribble UI Demo ',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
