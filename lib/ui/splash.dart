import 'package:fiery_gg/ui/dashboard.dart';
import 'package:fiery_gg/ui/resources/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeInAnimation;
  late Animation<double> _fadeOutAnimation;
  bool _showingContacts = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );
    _fadeOutAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
      ),
    );
    _controller.addStatusListener(_animationStatusListener);
    _controller.forward();
  }

  void _animationStatusListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      if (!_showingContacts) {
        setState(() {
          _showingContacts = true;
        });
        _controller.reset();
        _controller.forward();
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (context) => Dashboard(
                    config: LayoutConfig(),
                  )),
        );
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Opacity(
              opacity: _fadeOutAnimation.value == 1
                  ? _fadeInAnimation.value
                  : _fadeOutAnimation.value,
              child: _showingContacts ? _buildContacts() : _buildTitle(),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return const Text(
      'by Tilarna',
      style: TextStyle(
        color: Colors.black,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildContacts() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildSocialLink(
            'assets/images/github.svg', 'github.com/TilarnaExdilika'),
        const SizedBox(height: 10),
        _buildSocialLink('assets/images/discord.svg', '_tilarna'),
        const SizedBox(height: 10),
        _buildSocialLink('assets/images/messenger.svg', 'IShino.Avery'),
      ],
    );
  }

  Widget _buildSocialLink(String iconPath, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          iconPath,
          width: 24,
          height: 24,
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
