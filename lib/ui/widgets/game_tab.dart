import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class GameTab extends StatefulWidget {
  const GameTab({super.key});

  @override
  State<GameTab> createState() => _GameTabState();
}

class _GameTabState extends State<GameTab> {
  final ScrollController _scrollController = ScrollController();
  Offset _startPosition = Offset.zero;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return constraints.maxWidth < 650
              ? _buildLayout(isScrollable: true)
              : _buildLayout(isScrollable: false);
        },
      ),
    );
  }

  Widget _buildLayout({required bool isScrollable}) {
    final gameCards = _buildGameCards(isScrollable: isScrollable);

    if (isScrollable) {
      return Column(
        children: [
          SizedBox(
            height: 250,
            child: MouseRegion(
              onEnter: (_) => _startPosition = Offset.zero,
              child: Listener(
                onPointerDown: (event) => _startPosition = event.position,
                onPointerMove: (event) {
                  if (event.kind == PointerDeviceKind.mouse &&
                      event.buttons == kPrimaryButton) {
                    final delta = _startPosition - event.position;
                    _scrollController.position.moveTo(
                      _scrollController.offset + delta.dx,
                      curve: Curves.linear,
                      duration: Duration.zero,
                    );
                    _startPosition = event.position;
                  }
                },
                child: ListView.builder(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  itemCount: gameCards.length,
                  itemBuilder: (context, index) => gameCards[index],
                ),
              ),
            ),
          ),
        ],
      );
    }

    return Column(
      children: [
        Container(
          height: 250,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
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
          ),
        ),
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
      margin: const EdgeInsets.all(4),
      width: width,
      height: 250,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: begin,
          end: end,
          colors: gradientColors,
        ),
        borderRadius: BorderRadius.circular(10),
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
