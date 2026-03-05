class GameResult {
  final DateTime when;
  final bool won;
  final int secret;
  final String difficultyLabel;

  GameResult({
    required this.when,
    required this.won,
    required this.secret,
    required this.difficultyLabel,
  });
}
