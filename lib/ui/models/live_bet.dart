class LiveBet {
  final String game;
  final String user;
  final String time;
  final String wager;
  final String multiplier;
  final String payout;

  LiveBet({
    required this.game,
    required this.user,
    required this.time,
    required this.wager,
    required this.multiplier,
    required this.payout,
  });
}

final List<LiveBet> liveBetData = [
  LiveBet(
    game: 'Jackpot',
    user: 'Albert Flores',
    time: '3/26/2023, 08:47 AM',
    wager: '32.00',
    multiplier: '1.00x',
    payout: '160.00',
  ),
  LiveBet(
    game: 'Roulette',
    user: 'Jane Cooper',
    time: '3/26/2023, 09:12 AM',
    wager: '50.00',
    multiplier: '2.00x',
    payout: '100.00',
  ),
  LiveBet(
    game: 'Crash',
    user: 'Esther Howard',
    time: '3/26/2023, 10:30 AM',
    wager: '25.00',
    multiplier: '3.50x',
    payout: '87.50',
  ),
];
