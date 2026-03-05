enum DifficultyLevel { easy, medium, advanced, extreme }

class GameDifficulty {
  final DifficultyLevel level;
  final int min;
  final int max;
  final int attempts;
  final String label;

  const GameDifficulty._(this.level, this.min, this.max, this.attempts, this.label);

  static const easy = GameDifficulty._(DifficultyLevel.easy, 1, 10, 5, 'Fácil');
  static const medium = GameDifficulty._(DifficultyLevel.medium, 1, 20, 8, 'Medio');
  static const advanced = GameDifficulty._(DifficultyLevel.advanced, 1, 100, 15, 'Avanzado');
  static const extreme = GameDifficulty._(DifficultyLevel.extreme, 1, 1000, 25, 'Extremo');

  static const List<GameDifficulty> values = [easy, medium, advanced, extreme];

  factory GameDifficulty.fromLevel(DifficultyLevel level) {
    return values.firstWhere((d) => d.level == level);
  }
}