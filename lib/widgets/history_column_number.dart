
import 'package:flutter/material.dart';
import 'package:reto_adivina_el_numero/models/game_result.dart';

class HistoryColumn extends StatelessWidget {
  final List<GameResult> history;

  const HistoryColumn({
    super.key,
    required this.history,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white30),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                const SizedBox(height: 6),

                const Text(
                  'Historial',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 6),

                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: history.length,
                    itemBuilder: (context, index) {
                      final result = history[index];

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Text(
                          result.guess.toString(),
                          style: TextStyle(
                            fontSize: 14,
                            color: result.won ? Colors.green : Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}