import 'package:fiery_gg/ui/dashboard.dart';
import 'package:fiery_gg/ui/resources/colors.dart';
import 'package:fiery_gg/ui/resources/config.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
      duration: const Duration(milliseconds: 3500),
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
      backgroundColor: AppColors.backgroundMain,
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
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildContacts() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/images/logo.gif',
          height: 300,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    _buildSocialLink(
                        FontAwesomeIcons.github, 'TilarnaExdilika'),
                    const SizedBox(height: 10),
                    _buildSocialLink(FontAwesomeIcons.discord, '_tilarna'),
                    const SizedBox(height: 10),
                    _buildSocialLink(
                        FontAwesomeIcons.facebookMessenger, 'IShino.Avery'),
                  ],
                ),
              ),
              const SizedBox(width: 40),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Text(
                          'UI by',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          ' Sok Studio',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(2),
                      child: Image.asset(
                        'assets/images/dribble_author.png',
                        width: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSocialLink(IconData icon, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        FaIcon(
          icon,
          size: 24,
          color: Colors.white,
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
