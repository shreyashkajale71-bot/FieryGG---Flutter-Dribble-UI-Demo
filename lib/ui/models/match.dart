class Match {
  final String game;
  final String gameIconPath;
  final bool isLive;
  final String league;
  final String team1;
  final String team2;
  final String score1;
  final String score2;
  final String time1;
  final String time2;
  final String duration;
  final String odds1;
  final String odds2;

  Match({
    required this.game,
    required this.gameIconPath,
    required this.isLive,
    required this.league,
    required this.team1,
    required this.team2,
    required this.score1,
    required this.score2,
    required this.time1,
    required this.time2,
    required this.duration,
    required this.odds1,
    required this.odds2,
  });
}

final List<Match> topMatches = [
  Match(
    game: 'FIFA 23',
    gameIconPath:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/a/aa/FIFA_logo_without_slogan.svg/768px-FIFA_logo_without_slogan.svg.png',
    isLive: true,
    league: 'International • Euroleague',
    team1: 'BC Olympiakos • Alba Berlin',
    team2: 'Alba Berlin • BC Olympiakos',
    score1: '3 - 0',
    score2: '6 - 0',
    time1: '15:00',
    time2: '15:26',
    duration: '26\'',
    odds1: '2.51',
    odds2: '0.71',
  ),
  Match(
    game: 'Valorant',
    gameIconPath:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/f/fc/Valorant_logo_-_pink_color_version.svg/816px-Valorant_logo_-_pink_color_version.svg.png',
    isLive: false,
    league: 'VCT Championship 2024',
    team1: 'GENG • G2',
    team2: 'PRX • FNC',
    score1: '',
    score2: '',
    time1: '13:15',
    time2: '11 Sep',
    duration: '11 Sep',
    odds1: '2.51',
    odds2: '0.71',
  ),
  Match(
    game: 'League of Legends',
    gameIconPath:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d8/League_of_Legends_2019_vector.svg/900px-League_of_Legends_2019_vector.svg.png',
    isLive: true,
    league: 'LCK Summer Split',
    team1: 'T1 • Gen.G',
    team2: 'FPX • G2',
    score1: '2 - 1',
    score2: '1 - 2',
    time1: '14:30',
    time2: '16:15',
    duration: '105\'',
    odds1: '1.95',
    odds2: '1.85',
  ),
  Match(
    game: 'Dota 2',
    gameIconPath:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c2/Dota_logo.svg/306px-Dota_logo.svg.png?20230404224843',
    isLive: false,
    league: 'The International 2024',
    team1: 'Team Secret • OG',
    team2: 'Tundra • Liquid',
    score1: '',
    score2: '',
    time1: '18:00',
    time2: '15 Sep',
    duration: '15 Sep',
    odds1: '2.10',
    odds2: '1.70',
  ),
  Match(
    game: 'CS:GO',
    gameIconPath:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ9likwy0YxDsKDbZkrDm7-ePM-n9exnbwsIA&s',
    isLive: true,
    league: 'ESL Pro League Season 18',
    team1: 'Natus Vincere • Astralis',
    team2: 'G2 • Faze',
    score1: '14 - 12',
    score2: '12 - 14',
    time1: '17:45',
    time2: '18:30',
    duration: '45\'',
    odds1: '1.65',
    odds2: '2.20',
  ),
  Match(
    game: 'Rocket League',
    gameIconPath:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c3/Rocket_League_logo.svg/768px-Rocket_League_logo.svg.png?20200925050043',
    isLive: false,
    league: 'RLCS 2024 World Championship',
    team1: 'NRG • NRG',
    team2: 'Team Vitality • Vitality',
    score1: '',
    score2: '',
    time1: '20:00',
    time2: '18 Sep',
    duration: '18 Sep',
    odds1: '1.90',
    odds2: '1.90',
  ),
];
