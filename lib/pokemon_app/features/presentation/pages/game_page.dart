import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_projects/pokemon_app/core/navigation/gate_animation_navigation.dart';
import 'package:mini_projects/pokemon_app/core/widgets/background_widget.dart';
import 'package:mini_projects/pokemon_app/features/domain/repository/pokemon_images_repository.dart';
import 'package:mini_projects/pokemon_app/features/domain/repository/timer_repository.dart';
import 'package:mini_projects/pokemon_app/features/presentation/managers/game_bloc/game_bloc.dart';
import 'package:mini_projects/pokemon_app/features/presentation/managers/timer_bloc/timer_bloc.dart';
import 'package:mini_projects/pokemon_app/features/presentation/widgets/game_page/game_over_widge.dart';
import 'package:mini_projects/pokemon_app/features/presentation/widgets/game_page/quiz_card.dart';

class GameScreen extends StatelessWidget {
  final int height;
  final int width;
  final int gameTimer;

  const GameScreen({
    super.key,
    required this.height,
    required this.width,
    required this.gameTimer,
  });

  static Route route({
    required int height,
    required int width,
    required int gameTimer,
    required BuildContext context,
  }) {
    return GateNavigationAnimation.createRoute(
      context: context,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<TimerBloc>(
              create: (context) => TimerBloc(gameTimer: GameTimer())),
          BlocProvider(
            create: (context) => GameBloc(
              pokemonImagesRepository: PokemonImagesRepository(),
            )..add(
                ShuffleCardsEvent(count: width * height),
              ),
          ),
        ],
        child: GameScreen(height: height, width: width, gameTimer: gameTimer),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<TimerBloc, TimerState>(
          listenWhen: (previous, current) =>
              current.state == TimerEnum.finished,
          listener: (context, state) {
            if (state.isGameTimer) {
              context.read<GameBloc>().add(GameOverEvent());
            } else {
              context.read<TimerBloc>().add(
                    StartTimerEvent(time: gameTimer, gameTimer: true),
                  );
            }
          },
        ),
        BlocListener<GameBloc, GameState>(
          listenWhen: (previous, current) {
            return current.state == GameStateEnum.revailingAll;
          },
          listener: (context, state) {
            context.read<TimerBloc>().add(
                  StartTimerEvent(time: 3, gameTimer: false),
                );
          },
        ),
        BlocListener<GameBloc, GameState>(
          listenWhen: (previous, current) {
            return current.state == GameStateEnum.finished;
          },
          listener: (context, state) {
            context.read<TimerBloc>().add(
                  StopTimerEvent(),
                );
          },
        ),
      ],
      child: BackgroundImageWidget(
        child: Scaffold(
          appBar: AppBar(
            title: BlocBuilder<TimerBloc, TimerState>(
              builder: (context, state) {
                return Text(
                  // since we mutliplay by 10 we need to divade by 10
                  "Remaining Time: ${(state.duration / 10).floor()}:${state.duration % 10}",
                );
              },
            ),
          ),
          body: Center(
            child: BlocBuilder<GameBloc, GameState>(
              buildWhen: (previous, current) => previous.state != current.state,
              builder: (context, state) {
                return _getChildByState(state);
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _getChildByState(GameState gameState) {
    if (gameState.state == GameStateEnum.loading) {
      return const CircularProgressIndicator();
    }

    if (gameState.state == GameStateEnum.finished) {
      return GameOverWidget(cardCount: width * height);
    }

    return Column(
      children: List.generate(
        height,
        (i) {
          return Expanded(
            child: Row(
              children: List.generate(
                width,
                (j) {
                  return QuizCard(
                    index: i * width + j,
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
