class Player {
  final String id;
  final String name, level;

  Player({
    required this.id,
    required this.name,
    required this.level,
  });

  factory Player.fromJson(Map<String, dynamic> jsonData) {
    return Player(
      id: jsonData['id'],
      name: jsonData['player_nome'],
      level: jsonData['player_level'],
    );
  }
}
