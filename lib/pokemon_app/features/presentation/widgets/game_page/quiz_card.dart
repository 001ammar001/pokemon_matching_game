import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_projects/pokemon_app/features/presentation/managers/game_bloc/game_bloc.dart';

class QuizCard extends StatelessWidget {
  const QuizCard({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(
      buildWhen: (previous, current) {
        //ignore rebuild if alread awnsered
        if (current.awnserd.contains(index)) {
          return false;
        }

        //force rebuild on state change
        if (current.state != previous.state) {
          return true;
        }

        //rebuild if we select it in the current state
        if (current.currentlySelected(index) &&
            !previous.currentlySelected(index)) {
          return true;
        }

        // rebuild all after validating previous result and
        // returning current right to (-1) and previous get the old value
        if (previous.rightSelected != -1) {
          return true;
        }

        return false;
      },
      builder: (context, state) {
        final visible = state.visible(index);
        return Expanded(
          child: GestureDetector(
            onTap: () {
              if (!visible) {
                context.read<GameBloc>().add(
                      SelectCardEvent(selectedIndex: index),
                    );
              }
            },
            child: AnimatedContainer(
              margin: const EdgeInsets.all(4),
              padding: const EdgeInsets.all(4),
              duration: Durations.extralong1,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 1,
                ),
                image: DecorationImage(
                  image: AssetImage(
                    visible
                        ? "assets/images/pokemonImages/${state.images[index]}"
                        : "assets/images/pokemonImages/pokeball.png",
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
