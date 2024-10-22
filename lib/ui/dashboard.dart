import 'package:fiery_gg/ui/models/tabs.dart';
import 'package:fiery_gg/ui/widgets/demo_tab.dart';
import 'package:fiery_gg/ui/widgets/game_tab.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fiery_gg/ui/resources/colors.dart';
import 'package:fiery_gg/ui/resources/config.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Dashboard extends StatefulWidget {
  final LayoutConfig config;

  const Dashboard({
    super.key,
    required this.config,
  });

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with SingleTickerProviderStateMixin {
  int _selectedTab = 0;
  late AnimationController _controller;
  late Animation<double> _animation;
  final List<TabItem> _tabItems = [
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

  final ScrollController _horizontalScrollController = ScrollController();
  Offset _startPosition = Offset.zero;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _horizontalScrollController.dispose();
    super.dispose();
  }

  void _onTabSelected(int index) {
    setState(() {
      _selectedTab = index;
    });
    _controller.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isLandscape = constraints.maxWidth > constraints.maxHeight;
            return Stack(
              children: [
                _buildBackground(),
                _buildHeader(),
                _buildSidebar(isLandscape),
                _buildMainContent(isLandscape, context),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildBackground() {
    return Positioned.fill(
      child: Container(color: AppColors.backgroundMain),
    );
  }

  Widget _buildHeader() {
    return Positioned(
      left: 0,
      top: 0,
      right: 0,
      height: widget.config.headerHeight,
      child: Container(
        color: AppColors.backgroundMain,
        child: Row(
          children: [
            // Logo
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Image.asset(
                'assets/images/logo.png',
                height: 45,
              ),
            ),
            const SizedBox(width: 16),
            // Các nút điều hướng
            _buildNavButton('Home', icon: FontAwesomeIcons.house),
            _buildNavButton('Leaderboard',
                isActive: true, icon: FontAwesomeIcons.trophy),
            _buildNavButton('Clan', icon: FontAwesomeIcons.shield),
            const Spacer(),
            // Nút Games
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Games'),
            ),
            const Spacer(),
            Container(
              decoration: BoxDecoration(
                color: AppColors.backgroundWidget.withOpacity(0.8),
                border: Border.all(color: AppColors.container, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          FontAwesomeIcons.coins,
                          color: Colors.amber,
                          size: 14,
                        ),
                        SizedBox(width: 6),
                        Text(
                          '1,561',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    decoration: BoxDecoration(
                      color: AppColors.green2.withOpacity(0.8),
                      border: Border.all(color: AppColors.green2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      '+ Deposit',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 7),
            // Avatar
            CircleAvatar(
              radius: 16,
              backgroundColor: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.primary,
                    width: 2,
                  ),
                ),
                child: ClipOval(
                  child: Image.asset('assets/images/avt.png'),
                ),
              ),
            ),
            const SizedBox(width: 7),
            GestureDetector(
              onTap: () {},
              child: Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  color: AppColors.backgroundWidget.withOpacity(0.8),
                  border: Border.all(color: AppColors.container, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Stack(
                    children: [
                      const Icon(
                        Icons.notifications,
                        color: AppColors.active,
                        size: 18,
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          width: 7,
                          height: 7,
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 7),
            GestureDetector(
              onTap: () {},
              child: Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  color: AppColors.backgroundWidget.withOpacity(0.8),
                  border: Border.all(color: AppColors.container, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Icon(
                    FontAwesomeIcons.powerOff,
                    color: AppColors.unactive,
                    size: 18,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 5),
          ],
        ),
      ),
    );
  }

  Widget _buildNavButton(String text, {bool isActive = false, IconData? icon}) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, right: 2, left: 2),
      child: TextButton.icon(
        onPressed: () {},
        style: TextButton.styleFrom(
          foregroundColor: isActive ? AppColors.primary : AppColors.unactive,
        ),
        icon: Icon(icon, size: 15),
        label: Text(
          text,
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: isActive ? AppColors.active : AppColors.unactive),
        ),
      ),
    );
  }

  Widget _buildSidebar(bool isLandscape) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      left: 0,
      top: isLandscape ? widget.config.headerHeight : null,
      bottom: 0,
      width: isLandscape ? widget.config.sidebarWidth : null,
      height: isLandscape ? null : widget.config.sidebarHeight,
      right: isLandscape ? null : 0,
      child: Container(
        color: AppColors.backgroundMain,
        child: isLandscape
            ? Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: _sidebarItems(isLandscape),
                        ),
                      ),
                    ),
                  ),
                  if (MediaQuery.of(context).size.height > 300)
                    _buildSocialIcons(),
                ],
              )
            : LayoutBuilder(
                builder: (context, constraints) {
                  final itemWidth = constraints.maxWidth / 5;
                  return MouseRegion(
                    onEnter: (_) => _startPosition = Offset.zero,
                    child: Listener(
                      onPointerDown: (event) => _startPosition = event.position,
                      onPointerMove: (event) {
                        if (event.kind == PointerDeviceKind.mouse &&
                            event.buttons == kPrimaryButton) {
                          final delta = _startPosition - event.position;
                          _horizontalScrollController.position.moveTo(
                            _horizontalScrollController.offset + delta.dx,
                            curve: Curves.linear,
                            duration: Duration.zero,
                          );
                          _startPosition = event.position;
                        }
                      },
                      child: SingleChildScrollView(
                        controller: _horizontalScrollController,
                        scrollDirection: Axis.horizontal,
                        child: SizedBox(
                          width: itemWidth * _sidebarItems(isLandscape).length,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: _sidebarItems(isLandscape),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }

  List<Widget> _sidebarItems(bool isLandscape) {
    return List.generate(_tabItems.length, (index) {
      final item = _tabItems[index];
      return _buildSidebarItem(
        icon: item.icon,
        title: item.title,
        isActive: index == _selectedTab,
        onTap: () => _onTabSelected(index),
        isLandscape: isLandscape,
      );
    });
  }

  Widget _buildSidebarItem({
    required IconData icon,
    required String title,
    required bool isLandscape,
    bool isActive = false,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: isLandscape ? 10 : 0),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: isActive
                ? AppColors.primary.withOpacity(0.8)
                : Colors.transparent,
            border: isActive
                ? Border.all(
                    color: AppColors.primary,
                    width: 2,
                  )
                : null,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isActive ? Colors.white : AppColors.unactive,
                size: isActive ? 20 : 18,
              ),
              const SizedBox(height: 4),
              if (!isActive)
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.unactive,
                    fontSize: 10,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMainContent(bool isLandscape, BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      left: isLandscape
          ? widget.config.contentLeftPadding
          : widget.config.contentPadding,
      top: widget.config.contentTopPadding,
      right: widget.config.contentPadding,
      bottom: isLandscape ? 0 : widget.config.sidebarHeight,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.borderWidget, width: 1),
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(widget.config.borderRadius),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.backgroundWidget,
                  border: const Border(
                    right: BorderSide(color: AppColors.borderWidget, width: 1),
                  ),
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(widget.config.borderRadius),
                  ),
                ),
                child: FadeTransition(
                  opacity: _animation,
                  child: _tabItems[_selectedTab].content,
                ),
              ),
            ),
            if (isLandscape && MediaQuery.of(context).size.width > 700)
              const SizedBox(
                width: 300,
                child: Center(
                  child: Text(
                    'Online Chats',
                    style: TextStyle(
                      color: AppColors.unactive,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialIcons() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildSocialIcon(FontAwesomeIcons.telegram, () async {
            final Uri url = Uri.parse('https://t.me/0898019210');
            if (await canLaunchUrl(url)) {
              await launchUrl(url);
            }
          }),
          _buildSocialIcon(FontAwesomeIcons.github, () async {
            final Uri url = Uri.parse('https://github.com/TilarnaExdilika');
            if (await canLaunchUrl(url)) {
              await launchUrl(url);
            }
          }),
          _buildSocialIcon(FontAwesomeIcons.facebook, () async {
            final Uri url = Uri.parse('https://www.facebook.com/IShino.Avery/');
            if (await canLaunchUrl(url)) {
              await launchUrl(url);
            }
          }),
        ],
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon, VoidCallback onPressed) {
    return IconButton(
      icon: Icon(
        icon,
        color: AppColors.unactive,
        size: 18,
      ),
      onPressed: onPressed,
    );
  }
}
