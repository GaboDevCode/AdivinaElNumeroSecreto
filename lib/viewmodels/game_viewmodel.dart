import 'dart:math';
import 'package:flutter/material.dart';
import '../models/game_difficulty.dart';
import '../models/game_result.dart';

class GameViewModel extends ChangeNotifier {
  GameDifficulty _difficulty = GameDifficulty.easy;

  late int _secret;
  late int attemptsLeft;

  bool gameOver = false;
  bool won = false;

  final List<int> greater = [];
  final List<int> lower = [];
  final List<GameResult> history = [];

  GameDifficulty get difficulty => _difficulty;
  int get secret => _secret;

  GameViewModel() {
    startNewGame();
  }

  void startNewGame() {
    final min = _difficulty.min;
    final max = _difficulty.max;

    final rng = Random();
    _secret = rng.nextInt(max - min + 1) + min;
    attemptsLeft = _difficulty.attempts;

    gameOver = false;
    won = false;

    greater.clear();
    lower.clear();

    notifyListeners();
  }

  void changeDifficulty(GameDifficulty newDifficulty) {
    _difficulty = newDifficulty;
    startNewGame();
  }

  String? guess(String input) {
    if (gameOver) {
      return 'El juego ha terminado. Inicia uno nuevo.';
    }

    final parsed = int.tryParse(input);

    if (parsed == null) {
      return 'Ingresa un número válido.';
    }

    if (parsed < _difficulty.min || parsed > _difficulty.max) {
      return 'Número fuera del rango (${_difficulty.min}-${_difficulty.max}).';
    }

    // Procesar el intento
    if (parsed == _secret) {
      won = true;
      gameOver = true;

      history.insert(
        0,
        GameResult(
          when: DateTime.now(),
          won: true,
          guess: _secret,
          difficultyLabel: _difficulty.label,
        ),
      );
      greater.clear();
      lower.clear();
      notifyListeners();
      return null;
    }

    if (parsed < _secret) {
     
      greater.insert(0, parsed);
    } else {
 
      lower.insert(0, parsed);
    }

    attemptsLeft--;

    if (attemptsLeft <= 0) {
      gameOver = true;
      won = false;

      history.insert(
        0,
        GameResult(
          when: DateTime.now(),
          won: false,
          guess: parsed,
          difficultyLabel: _difficulty.label,
        ),
      );
    }

    notifyListeners();
    return null;
  }
}
