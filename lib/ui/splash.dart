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
    _setupAnimations();
    _controller.addStatusListener(_animationStatusListener);
    _controller.forward();
  }

  void _setupAnimations() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3500),
    );
    _fadeInAnimation = _createAnimation(0.0, 1.0, 0.0, 0.5, Curves.easeIn);
    _fadeOutAnimation = _createAnimation(1.0, 0.0, 0.5, 1.0, Curves.easeOut);
  }

  Animation<double> _createAnimation(double begin, double end,
      double startInterval, double endInterval, Curve curve) {
    return Tween<double>(begin: begin, end: end).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(startInterval, endInterval, curve: curve),
      ),
    );
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
          builder: (context, child) => _buildAnimatedContent(),
        ),
      ),
    );
  }

  Widget _buildAnimatedContent() {
    return Opacity(
      opacity: _fadeOutAnimation.value == 1
          ? _fadeInAnimation.value
          : _fadeOutAnimation.value,
      child: _showingContacts ? _buildContacts() : _buildTitle(),
    );
  }

  Widget _buildTitle() {
    return const Text(
      SplashConfig.title,
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
        _buildLogo(),
        const SizedBox(height: 20),
        if (_isLargeScreen()) _buildContactDetails(),
      ],
    );
  }

  Widget _buildLogo() {
    return Image.asset(
      SplashConfig.logoPath,
      height: SplashConfig.logoHeight,
      fit: BoxFit.contain,
    );
  }

  bool _isLargeScreen() => MediaQuery.of(context).size.height > 700;

  Widget _buildContactDetails() {
    return Container(
      constraints: const BoxConstraints(maxWidth: 800),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildSocialLinks()),
            const SizedBox(width: 40),
            Expanded(child: _buildUiCredit()),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialLinks() {
    return Column(
      children: SplashConfig.socialLinks
          .map((link) => _buildSocialLink(link.icon, link.text))
          .toList(),
    );
  }

  Widget _buildUiCredit() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildUiCreditText(),
        const SizedBox(height: 10),
        _buildUiCreditImage(),
      ],
    );
  }

  Widget _buildUiCreditText() {
    return const Row(
      children: [
        Text(
          SplashConfig.uiCredit,
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        Text(
          ' ${SplashConfig.uiCreditName}',
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildUiCreditImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(2),
      child: Image.asset(
        SplashConfig.uiCreditImagePath,
        width: 300,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _buildSocialLink(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
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
      ),
    );
  }
}
