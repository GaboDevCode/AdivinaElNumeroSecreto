class GameResult {
  final DateTime when;
  final bool won;
  final int guess;
  final String difficultyLabel;

  GameResult({
    required this.when,
    required this.won,
    required this.guess,
    required this.difficultyLabel,
  });
}
