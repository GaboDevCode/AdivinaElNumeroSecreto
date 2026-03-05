
enum DifficultyLevel { easy, medium, advanced, extreme }


class GameModelDifficulty {
  final DifficultyLevel level;
  final int min;
  final int max;
  final int attempts;
  final String label;

  const GameModelDifficulty._(this.level, this.min, this.max, this.attempts, this.label);

  static const easy = GameModelDifficulty._(DifficultyLevel.easy, 1, 10, 5, 'Fácil');
  static const medium = GameModelDifficulty._(DifficultyLevel.medium, 1, 20, 8, 'Medio');
  static const advanced = GameModelDifficulty._(DifficultyLevel.advanced, 1, 100, 15, 'Avanzado');
  static const extreme = GameModelDifficulty._(DifficultyLevel.extreme, 1, 1000, 25, 'Extremo');

  static List<GameModelDifficulty> values = [easy, medium, advanced, extreme];

  factory GameModelDifficulty.fromLevel(DifficultyLevel level) {
    return values.firstWhere((d) => d.level == level);
  }
}