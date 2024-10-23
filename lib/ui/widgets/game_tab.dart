import 'package:fiery_gg/ui/models/live_bet.dart';
import 'package:fiery_gg/ui/models/match.dart';
import 'package:fiery_gg/ui/models/slots.dart';
import 'package:fiery_gg/ui/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GameTab extends StatefulWidget {
  const GameTab({super.key});

  @override
  State<GameTab> createState() => _GameTabState();
}

class _GameTabState extends State<GameTab> {
  final Map<String, ScrollController> _scrollControllers = {
    'horizontal': ScrollController(),
    'vertical': ScrollController(),
    'matches': ScrollController(),
    'slots': ScrollController(),
  };
  Offset _startPosition = Offset.zero;

  @override
  void dispose() {
    for (var controller in _scrollControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          controller: _scrollControllers['vertical'],
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: _buildLayout(isScrollable: constraints.maxWidth < 650),
          ),
        ),
      ),
    );
  }

  Widget _buildLayout({required bool isScrollable}) {
    final gameCards = _buildGameCards(isScrollable: isScrollable);

    return Column(
      children: [
        SizedBox(
          height: 250,
          child: isScrollable
              ? _buildCardLayout(gameCards)
              : Align(
                  alignment: Alignment.centerLeft,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1400),
                    child: _buildGridLayout(gameCards),
                  ),
                ),
        ),
        const SizedBox(height: 10),
        _buildTopSection(
          title: 'Top Matches',
          icon: FontAwesomeIcons.gamepad,
          content: _buildMatchesList(),
        ),
        const SizedBox(height: 20),
        _buildTopSection(
          title: 'Top Slots',
          icon: FontAwesomeIcons.dice,
          content: _buildSlotsList(),
        ),
        const SizedBox(height: 20),
        _buildLiveBet(),
      ],
    );
  }

  Widget _buildTopSection({
    required String title,
    required IconData icon,
    required Widget content,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
          child: Row(
            children: [
              Icon(icon, color: AppColors.unactive, size: 16),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.active,
                ),
              ),
              const Spacer(),
              _buildButton('See All', width: 80),
              const SizedBox(width: 10),
              _buildButton(
                '',
                width: 30,
                icon: Icons.arrow_left,
                color: AppColors.container,
              ),
              const SizedBox(width: 10),
              _buildButton(
                '',
                width: 30,
                icon: Icons.arrow_right,
                color: AppColors.primary,
              ),
            ],
          ),
        ),
        SizedBox(height: 180, child: content),
      ],
    );
  }

  Widget _buildButton(String text,
      {double width = 80, IconData? icon, Color color = AppColors.container}) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 30,
        width: width,
        decoration: BoxDecoration(
          color: color.withOpacity(0.9),
          border: Border.all(color: color, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: icon != null
              ? Icon(icon, color: AppColors.active, size: 18)
              : Text(
                  text,
                  style: const TextStyle(color: AppColors.active, fontSize: 12),
                ),
        ),
      ),
    );
  }

  Widget _buildScrollableList({
    required ScrollController controller,
    required int itemCount,
    required Widget Function(BuildContext, int) itemBuilder,
  }) {
    return MouseRegion(
      onEnter: (_) => _startPosition = Offset.zero,
      child: Listener(
        onPointerDown: (event) => _startPosition = event.position,
        onPointerMove: (event) {
          if (event.kind == PointerDeviceKind.mouse &&
              event.buttons == kPrimaryButton) {
            final delta = _startPosition - event.position;
            controller.position.moveTo(
              controller.offset + delta.dx,
              curve: Curves.linear,
              duration: Duration.zero,
            );
            _startPosition = event.position;
          }
        },
        child: ListView.builder(
          controller: controller,
          scrollDirection: Axis.horizontal,
          itemCount: itemCount,
          itemBuilder: itemBuilder,
        ),
      ),
    );
  }

  Widget _buildMatchesList() {
    return _buildScrollableList(
      controller: _scrollControllers['matches']!,
      itemCount: topMatches.length,
      itemBuilder: (context, index) => _buildMatchCard(topMatches[index]),
    );
  }

  Widget _buildSlotsList() {
    return _buildScrollableList(
      controller: _scrollControllers['slots']!,
      itemCount: topSlots.length,
      itemBuilder: (context, index) => _buildSlotCard(topSlots[index]),
    );
  }

  Widget _buildMatchCard(Match match) {
    return Container(
      width: 250,
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        color: AppColors.container,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.network(match.gameIconPath, width: 24, height: 24),
                    const SizedBox(width: 8),
                    Text(match.game,
                        style: const TextStyle(color: Colors.white)),
                  ],
                ),
                if (match.isLive)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.live,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text('Live',
                        style: TextStyle(color: Colors.white, fontSize: 12)),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(match.league,
                style: const TextStyle(
                    color: AppColors.unactive,
                    fontSize: 12,
                    fontWeight: FontWeight.w600)),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(match.score1.isEmpty ? '- -' : match.score1,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                    Text(match.score2.isEmpty ? '- -' : match.score2,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(width: 10),
                Container(
                  color: AppColors.primary,
                  height: 40,
                  width: 1,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        match.team1,
                        style: const TextStyle(color: Colors.white),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Text(
                        match.team2,
                        style: const TextStyle(color: Colors.white),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(match.time1,
                        style: const TextStyle(
                            color: AppColors.unactive,
                            fontWeight: FontWeight.w600)),
                    Text(match.time2,
                        style: const TextStyle(
                            color: AppColors.unactive,
                            fontWeight: FontWeight.w600)),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 12.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundMain.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('X1',
                            style: TextStyle(
                                color: AppColors.unactive,
                                fontWeight: FontWeight.w600)),
                        const SizedBox(width: 8),
                        Text(match.odds1,
                            style: const TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundMain.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('X2',
                            style: TextStyle(
                                color: AppColors.unactive,
                                fontWeight: FontWeight.w600)),
                        const SizedBox(width: 8),
                        Text(match.odds2,
                            style: const TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSlotCard(Slot slot) {
    return Container(
      width: 150,
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              slot.imageUrl,
              fit: BoxFit.cover,
              width: 150,
              height: 180,
            ),
          ),
          Positioned.fill(
            child: MouseRegion(
              child: _buildHoverOverlay(slot),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHoverOverlay(Slot slot) {
    return StatefulBuilder(
      builder: (context, setState) {
        return MouseRegion(
          onEnter: (_) => setState(() => slot.isHovered = true),
          onExit: (_) => setState(() => slot.isHovered = false),
          child: AnimatedOpacity(
            opacity: slot.isHovered ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 200),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(20),
                      backgroundColor: AppColors.primary,
                    ),
                    child: const Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 4),
                      minimumSize: const Size(80, 30),
                    ),
                    child: const Text(
                      'Demo',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCardLayout(List<Widget> gameCards) {
    return _buildScrollableList(
      controller: _scrollControllers['horizontal']!,
      itemCount: gameCards.length,
      itemBuilder: (context, index) => gameCards[index],
    );
  }

  Widget _buildGridLayout(List<Widget> gameCards) {
    return Row(
      children: [
        Expanded(flex: 2, child: gameCards[0]),
        Expanded(
          flex: 3,
          child: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(child: gameCards[1]),
                    Expanded(flex: 2, child: gameCards[2]),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(flex: 2, child: gameCards[3]),
                    Expanded(child: gameCards[4]),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(flex: 2, child: gameCards[5]),
      ],
    );
  }

  List<Widget> _buildGameCards({required bool isScrollable}) {
    return _gameColors.entries.map((entry) {
      return _buildGameCard(
        entry.key,
        entry.value,
        width: isScrollable ? 150 : null,
        begin:
            entry.key == 'game_tab' ? Alignment.bottomLeft : Alignment.topLeft,
        end: entry.key == 'game_tab'
            ? Alignment.topRight
            : Alignment.bottomRight,
      );
    }).toList();
  }

  Widget _buildGameCard(String title, List<Color> gradientColors,
      {AlignmentGeometry begin = Alignment.topLeft,
      AlignmentGeometry end = Alignment.bottomRight,
      double? width}) {
    return Container(
      margin: const EdgeInsets.all(6),
      width: width,
      height: 250,
      decoration: BoxDecoration(
        gradient:
            LinearGradient(begin: begin, end: end, colors: gradientColors),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Customize',
              style: TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  static const Map<String, List<Color>> _gameColors = {
    'PvP Game': [Color(0xFF3B82F6), Color(0xFF1E3A8A)],
    'Roulette': [Color(0xFF991B1B), Color(0xFFDC2626)],
    'Jackpot': [Color(0xFF6B21A8), Color(0xFFA855F7)],
    'Crash': [Color(0xFF065F46), Color(0xFF10B981)],
    'Cases': [Color(0xFF0F766E), Color(0xFF14B8A6)],
    'Slots': [Color(0xFFEA580C), Color(0xFFFB923C)],
  };

  Widget _buildLiveBet() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLiveBetTabs(),
        const SizedBox(height: 10),
        LayoutBuilder(
          builder: (context, constraints) {
            return _buildLiveBetTable(constraints.maxWidth);
          },
        ),
      ],
    );
  }

  Widget _buildLiveBetTabs() {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTabButton('Live Bet', isActive: true),
          _buildTabButton('Lucky Wins'),
          _buildTabButton('Whale wins'),
        ],
      ),
    );
  }

  Widget _buildTabButton(String text, {bool isActive = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isActive ? AppColors.container : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isActive ? Colors.white : AppColors.unactive,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildLiveBetTable(double width) {
    final bool showGame = width > 600;
    final bool showTime = width > 500;
    final bool showWagerAndMultiplier = width > 400;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _buildTableHeader(
            showGame: showGame,
            showTime: showTime,
            showWagerAndMultiplier: showWagerAndMultiplier,
          ),
          ...liveBetData.map((bet) => _buildTableRow(
                game: bet.game,
                user: bet.user,
                time: bet.time,
                wager: bet.wager,
                multiplier: bet.multiplier,
                payout: bet.payout,
                showGame: showGame,
                showTime: showTime,
                showWagerAndMultiplier: showWagerAndMultiplier,
              )),
        ],
      ),
    );
  }

  Widget _buildTableHeader({
    required bool showGame,
    required bool showTime,
    required bool showWagerAndMultiplier,
  }) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          if (showGame) _buildHeaderCell('Game', flex: 3),
          _buildHeaderCell('User', flex: 2),
          if (showTime) _buildHeaderCell('Time', flex: 2),
          if (showWagerAndMultiplier) ...[
            _buildHeaderCell('Wager', flex: 2),
            _buildHeaderCell('Multiplier', flex: 1),
          ],
          _buildHeaderCell('Payout', flex: 2, alignRight: true),
        ],
      ),
    );
  }

  Widget _buildHeaderCell(String text,
      {int flex = 1, bool alignRight = false}) {
    return Expanded(
      flex: flex,
      child: Align(
        alignment: alignRight ? Alignment.centerRight : Alignment.centerLeft,
        child: Text(
          text,
          style: const TextStyle(
            color: AppColors.unactive,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildTableRow({
    required String game,
    required String user,
    required String time,
    required String wager,
    required String multiplier,
    required String payout,
    required bool showGame,
    required bool showTime,
    required bool showWagerAndMultiplier,
  }) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          if (showGame) _buildTableCell(game, flex: 3, icon: Icons.casino),
          _buildTableCell(user, flex: 2, isUser: true),
          if (showTime) _buildTableCell(time, flex: 2),
          if (showWagerAndMultiplier) ...[
            _buildTableCell(wager, flex: 2, isCurrency: true),
            _buildTableCell(multiplier, flex: 1, color: AppColors.primary),
          ],
          _buildTableCell(payout, flex: 2, isCurrency: true, alignRight: true),
        ],
      ),
    );
  }

  Widget _buildTableCell(
    String text, {
    int flex = 1,
    IconData? icon,
    bool isUser = false,
    bool isCurrency = false,
    Color color = Colors.white,
    bool alignRight = false,
  }) {
    return Expanded(
      flex: flex,
      child: Row(
        mainAxisAlignment:
            alignRight ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (icon != null) Icon(icon, color: AppColors.unactive, size: 16),
          if (isUser)
            const CircleAvatar(
                radius: 12,
                backgroundImage: AssetImage('assets/images/avt.png')),
          if (icon != null || isUser) const SizedBox(width: 8),
          Flexible(
            child: Text(
              isCurrency ? '\$$text' : text,
              style: TextStyle(color: color, fontSize: 12),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
