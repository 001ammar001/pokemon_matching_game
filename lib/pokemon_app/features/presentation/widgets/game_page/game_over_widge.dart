import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_projects/pokemon_app/features/presentation/managers/game_bloc/game_bloc.dart';

class GameOverWidget extends StatelessWidget {
  const GameOverWidget({
    super.key,
    required this.cardCount,
  });
  final int cardCount;

  @override
  Widget build(BuildContext context) {
    bool isWin = context.select((GameBloc bloc) => bloc.state.isWinState);
    int moves = context.select((GameBloc bloc) => bloc.state.moves);

    print("BUILDING OVER");

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          isWin ? "You Win" : "Game Over",
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: isWin ? Colors.green : Colors.red,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          "Moves Done So far: $moves",
          style: const TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 10),
        TextButton(
          onPressed: () {
            context.read<GameBloc>().add(
                  ShuffleCardsEvent(count: cardCount),
                );
          },
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            "Play Again",
            style: TextStyle(
              color: Colors.white,
              fontSize: 35,
            ),
          ),
        )
      ],
    );
  }
}
