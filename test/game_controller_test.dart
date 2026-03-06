import 'package:flutter_test/flutter_test.dart';
import 'package:reto_adivina_el_numero/models/game_difficulty.dart';
import 'package:reto_adivina_el_numero/viewmodels/game_viewmodel.dart';


void main() {
  group('GameViewModel Tests', () {

    test('should initialize game correctly', () {
      final viewModel = GameViewModel();

      expect(viewModel.gameOver, false);
      expect(viewModel.won, false);
      expect(viewModel.attemptsLeft, viewModel.difficulty.attempts);
      expect(viewModel.greater.isEmpty, true);
      expect(viewModel.lower.isEmpty, true);
    });

    test('secret number should be inside difficulty range', () {
      final viewModel = GameViewModel();

      expect(
        viewModel.secret,
        inInclusiveRange(
          viewModel.difficulty.min,
          viewModel.difficulty.max,
        ),
      );
    });

    test('should return error if input is not a number', () {
      final viewModel = GameViewModel();

      final result = viewModel.guess("abc");

      expect(result, 'Ingresa un número válido.');
    });

    test('should return error if number is out of range', () {
      final viewModel = GameViewModel();

      final result = viewModel.guess("10000");

      expect(
        result,
        'Número fuera del rango (${viewModel.difficulty.min}-${viewModel.difficulty.max}).',
      );
    });

    test('should win when guess equals secret number', () {
      final viewModel = GameViewModel();

      final secret = viewModel.secret;

      viewModel.guess(secret.toString());

      expect(viewModel.won, true);
      expect(viewModel.gameOver, true);
      expect(viewModel.history.isNotEmpty, true);
      expect(viewModel.history.first.won, true);
    });

    test('should register greater guess', () {
      final viewModel = GameViewModel();

      final guess = viewModel.secret - 1;

      if (guess >= viewModel.difficulty.min) {
        viewModel.guess(guess.toString());

        expect(viewModel.greater.contains(guess), true);
      }
    });

    test('should register lower guess', () {
      final viewModel = GameViewModel();

      final guess = viewModel.secret + 1;

      if (guess <= viewModel.difficulty.max) {
        viewModel.guess(guess.toString());

        expect(viewModel.lower.contains(guess), true);
      }
    });

    test('should lose when attempts reach zero', () {
      final viewModel = GameViewModel();

      final wrongGuess = viewModel.secret + 1;

      for (int i = 0; i < viewModel.difficulty.attempts; i++) {
        viewModel.guess(wrongGuess.toString());
      }

      expect(viewModel.gameOver, true);
      expect(viewModel.won, false);
      expect(viewModel.history.isNotEmpty, true);
      expect(viewModel.history.first.won, false);
    });

    test('changing difficulty should restart game', () {
      final viewModel = GameViewModel();

      viewModel.changeDifficulty(GameDifficulty.medium);

      expect(viewModel.difficulty, GameDifficulty.medium);
      expect(viewModel.gameOver, false);
      expect(viewModel.won, false);
      expect(viewModel.attemptsLeft, GameDifficulty.medium.attempts);
    });

  });
}