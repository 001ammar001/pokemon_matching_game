part of 'game_bloc.dart';

enum GameStateEnum { loading, revailingAll, running, finished }

final class GameState {
  final GameStateEnum state;
  final List<String> images;
  final Set<int> awnserd;
  final int leftSelected;
  final int rightSelected;
  final int moves;

  GameState({
    required this.state,
    required this.images,
    required this.awnserd,
    required this.moves,
    this.leftSelected = -1,
    this.rightSelected = -1,
  });

  factory GameState.initial() {
    return GameState(
      state: GameStateEnum.loading,
      images: [],
      awnserd: {},
      moves: 0,
    );
  }

  GameState copyWith({
    GameStateEnum? state,
    List<String>? images,
    Set<int>? awnserd,
    int? moves,
    int? leftSelected,
    int? rightSelected,
  }) {
    return GameState(
      state: state ?? this.state,
      images: images ?? this.images,
      awnserd: awnserd ?? this.awnserd,
      moves: moves ?? this.moves,
      leftSelected: leftSelected ?? this.leftSelected,
      rightSelected: rightSelected ?? this.rightSelected,
    );
  }

  bool get isWinState => awnserd.length == images.length;

  bool currentlySelected(index) {
    return (leftSelected == index) || (rightSelected == index);
  }

  bool visible(int index) {
    return state == GameStateEnum.revailingAll ||
        currentlySelected(index) ||
        awnserd.contains(index);
  }
}
