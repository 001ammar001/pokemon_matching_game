import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_projects/pokemon_app/features/domain/repository/pokemon_images_repository.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvents, GameState> {
  final PokemonImagesRepository pokemonImagesRepository;
  GameBloc({
    required this.pokemonImagesRepository,
  }) : super(GameState.initial()) {
    on<ShuffleCardsEvent>(_shuffleCard);
    on<SelectCardEvent>(_selectCard);
    on<GameOverEvent>(_gameOver);
  }

  _shuffleCard(ShuffleCardsEvent event, Emitter emit) async {
    // remove every thing even from previous games
    emit(GameState.initial());
    final images = pokemonImagesRepository.getImages(event.count);
    emit(state.copyWith(state: GameStateEnum.revailingAll, images: images));
    await Future.delayed(const Duration(seconds: 3));
    emit(state.copyWith(state: GameStateEnum.running));
  }

  _selectCard(SelectCardEvent event, Emitter emit) async {
    // prevent spam clicking
    if (state.rightSelected != -1) {
      return;
    }

    if (state.leftSelected == -1) {
      emit(
        state.copyWith(
          leftSelected: event.selectedIndex,
          moves: state.moves + 1,
        ),
      );
    } else {
      emit(
        state.copyWith(
          rightSelected: event.selectedIndex,
          moves: state.moves + 1,
        ),
      );

      await Future.delayed(const Duration(milliseconds: 750));

      emit(_getSelectionResult());

      if (state.isWinState) {
        await Future.delayed(const Duration(milliseconds: 1500));
        add(GameOverEvent());
      }
    }
  }

  _gameOver(GameOverEvent event, Emitter emit) async {
    emit(state.copyWith(state: GameStateEnum.finished));
  }

  _getSelectionResult() {
    if (state.images[state.leftSelected] == state.images[state.rightSelected]) {
      if (state.images.length == state.awnserd.length + 2) {
        add(GameOverEvent());
      }

      return state.copyWith(
        awnserd: {...state.awnserd, state.leftSelected, state.rightSelected},
        leftSelected: -1,
        rightSelected: -1,
      );
    }

    return state.copyWith(
      leftSelected: -1,
      rightSelected: -1,
    );
  }
}
