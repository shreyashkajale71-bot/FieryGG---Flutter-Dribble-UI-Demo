import 'package:flutter/material.dart';
import 'package:fiery_gg/ui/resources/colors.dart';
import 'package:fiery_gg/ui/resources/config.dart';

class Dashboard extends StatelessWidget {
  final LayoutConfig config;

  const Dashboard({
    super.key,
    required this.config,
  });

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
      height: config.headerHeight,
      child: Container(color: AppColors.backgroundMain),
    );
  }

  Widget _buildSidebar(bool isLandscape) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      left: 0,
      top: isLandscape ? config.headerHeight : null,
      bottom: 0,
      width: isLandscape ? config.sidebarWidth : null,
      height: isLandscape ? null : config.sidebarHeight,
      right: isLandscape ? null : 0,
      child: Container(
        color: AppColors.backgroundMain,
        child: isLandscape
            ? SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: _sidebarItems(),
                  ),
                ),
              )
            : LayoutBuilder(
                builder: (context, constraints) {
                  final itemWidth = constraints.maxWidth / 5;
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      width: itemWidth * _sidebarItems().length,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: _sidebarItems(),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }

  List<Widget> _sidebarItems() {
    return [
      _buildSidebarItem(Icons.dashboard, 'Game', isActive: true),
      _buildSidebarItem(Icons.settings_suggest, 'Jackpot'),
      _buildSidebarItem(Icons.person, 'Roulette'),
      _buildSidebarItem(Icons.bar_chart, 'Slots'),
      _buildSidebarItem(Icons.diamond, 'Coinflip'),
      _buildSidebarItem(Icons.rocket_launch, 'Cases'),
      _buildSidebarItem(Icons.casino, 'Crash'),
    ];
  }

  Widget _buildSidebarItem(IconData icon, String title,
      {bool isActive = false}) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 18,
            color: isActive ? Colors.white : AppColors.unactive,
          ),
          if (!isActive) ...[
            const SizedBox(height: 2),
            Text(
              title,
              style: const TextStyle(
                color: AppColors.unactive,
                fontSize: 10,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMainContent(bool isLandscape, BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      left: isLandscape ? config.contentLeftPadding : config.contentPadding,
      top: config.contentTopPadding,
      right: config.contentPadding,
      bottom: isLandscape ? 0 : config.sidebarHeight,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.backgroundWidget,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(config.borderRadius),
          ),
        ),
        child: const Center(
          child: Text(
            'Nội dung chính',
            style: TextStyle(
              color: AppColors.unactive,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
