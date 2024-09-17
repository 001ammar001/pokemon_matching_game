part of 'game_bloc.dart';

sealed class GameEvents {}

class ShuffleCardsEvent extends GameEvents {
  final int count;

  ShuffleCardsEvent({required this.count});
}

class SelectCardEvent extends GameEvents {
  final int selectedIndex;

  SelectCardEvent({required this.selectedIndex});
}

class GameOverEvent extends GameEvents {}
