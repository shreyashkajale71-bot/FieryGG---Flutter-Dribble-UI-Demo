import 'package:fiery_gg/ui/models/match.dart';
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
  final ScrollController _horizontalScrollController = ScrollController();
  final ScrollController _verticalScrollController = ScrollController();
  final ScrollController _matchesScrollController = ScrollController();
  Offset _startPosition = Offset.zero;

  @override
  void dispose() {
    _horizontalScrollController.dispose();
    _verticalScrollController.dispose();
    _matchesScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          controller: _verticalScrollController,
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
        _buildTopMatches(),
      ],
    );
  }

  Widget _buildTopMatches() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
          child: Row(
            children: [
              const Icon(
                FontAwesomeIcons.gamepad,
                color: AppColors.unactive,
                size: 16,
              ),
              const SizedBox(width: 12),
              const Text(
                'Top Matches',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.active),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {},
                child: Container(
                  height: 30,
                  width: 80,
                  decoration: BoxDecoration(
                    color: AppColors.container.withOpacity(0.9),
                    border: Border.all(color: AppColors.container, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text(
                      'See All',
                      style: TextStyle(color: AppColors.active, fontSize: 12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: AppColors.container.withOpacity(0.9),
                    border: Border.all(color: AppColors.container, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.arrow_left,
                      color: AppColors.active,
                      size: 18,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.9),
                    border: Border.all(color: AppColors.primary, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.arrow_right,
                      color: AppColors.active,
                      size: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 180,
          child: _buildMatchesList(),
        ),
      ],
    );
  }

  Widget _buildMatchesList() {
    return MouseRegion(
      onEnter: (_) => _startPosition = Offset.zero,
      child: Listener(
        onPointerDown: (event) => _startPosition = event.position,
        onPointerMove: (event) {
          if (event.kind == PointerDeviceKind.mouse &&
              event.buttons == kPrimaryButton) {
            final delta = _startPosition - event.position;
            _matchesScrollController.position.moveTo(
              _matchesScrollController.offset + delta.dx,
              curve: Curves.linear,
              duration: Duration.zero,
            );
            _startPosition = event.position;
          }
        },
        child: ListView.builder(
          controller: _matchesScrollController,
          scrollDirection: Axis.horizontal,
          itemCount: topMatches.length,
          itemBuilder: (context, index) => _buildMatchCard(topMatches[index]),
        ),
      ),
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

  Widget _buildCardLayout(List<Widget> gameCards) {
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
        child: ListView.builder(
          controller: _horizontalScrollController,
          scrollDirection: Axis.horizontal,
          itemCount: gameCards.length,
          itemBuilder: (context, index) => gameCards[index],
        ),
      ),
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
        gradient: LinearGradient(
          begin: begin,
          end: end,
          colors: gradientColors,
        ),
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
}
