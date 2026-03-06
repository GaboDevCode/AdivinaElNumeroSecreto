import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reto_adivina_el_numero/widgets/dual_column_number_Input.dart';
import 'package:reto_adivina_el_numero/widgets/history_column_number.dart';
import '../viewmodels/game_viewmodel.dart';
import '../models/game_difficulty.dart';

class GameView extends StatefulWidget {
const GameView({super.key});
  @override
  _GameViewState createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  final TextEditingController _controller = TextEditingController();

  void _submitGuess(BuildContext context) {
    final viewModel = context.read<GameViewModel>();
    final input = _controller.text;
    final error = viewModel.guess(input);

    if (error != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(error)));
    } else {
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E2F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2A2A3E),
        centerTitle: true,
        title: const Text(
          'Adivina el Número',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          children: [
            // Fila superior: input + intentos
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),
                SizedBox(
                  width: 130,
                  height: 60,
                  child: TextField(
                    controller: _controller,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: Colors.white, fontSize: 13),
                    decoration: InputDecoration(
                      hintText: 'Numbers',
                      hintStyle: const TextStyle(
                        color: Colors.white38,
                        fontSize: 13,
                      ),
                      filled: true,
                      fillColor: const Color(0xFF2A2A3E),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.white30),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.white30),
                      ),
                    ),
                    onSubmitted: (_) => _submitGuess(context),
                  ),
                ),
                const SizedBox(width: 20),
                Column(
                  children: [
                    const Text(
                      'Intentos',
                      style: TextStyle(color: Colors.white, fontSize: 13),
                    ),
                    Selector<GameViewModel, int>(
                      selector: (_, vm) => vm.attemptsLeft,
                      builder: (_, attemptsLeft, _) {
                        return Text(
                          '$attemptsLeft',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const Spacer(),
              ],
            ),

            
            Expanded(
              child: Center(
                child: SizedBox(
                  width: 400,
                  height: 300,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Columna "Mayor que"
                      Flexible(
                        fit: FlexFit.loose,
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 140),
                          child: Consumer<GameViewModel>(
                            builder: (context, vm, _) => DualColumnNumberInput(
                              title: 'Mayor que',
                              items: vm.greater,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),

                      // Columna "Menor que"
                      Flexible(
                        fit: FlexFit.loose,
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 140),
                          child: Consumer<GameViewModel>(
                            builder: (context, vm, _) => DualColumnNumberInput(
                              title: 'Menor que',
                              items: vm.lower,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),

                      // Columna "Historial"
                      Flexible(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 140),
                          child: Consumer<GameViewModel>(
                            builder: (context, vm, _) =>
                                HistoryColumn(history: vm.history),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Selector de dificultad
            Padding(
              padding: const EdgeInsets.only(bottom: 250),
              child: Selector<GameViewModel, GameDifficulty>(
                selector: (_, vm) => vm.difficulty,
                builder: (_, difficulty, _) {
                  double sliderValue = GameDifficulty.values
                      .indexOf(difficulty)
                      .toDouble();

                  return Column(
                    children: [
                      Text(
                        difficulty.label,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      Slider(
                        value: sliderValue,
                        min: 0,
                        max: (GameDifficulty.values.length - 1).toDouble(),
                        divisions: GameDifficulty.values.length - 1,
                        onChanged: (value) {
                          final newDifficulty =
                              GameDifficulty.values[value.round()];
                          context.read<GameViewModel>().changeDifficulty(
                            newDifficulty,
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

}
