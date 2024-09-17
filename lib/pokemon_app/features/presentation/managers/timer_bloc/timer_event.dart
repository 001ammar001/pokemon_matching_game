part of 'timer_bloc.dart';

sealed class TimerEvent {}

class StartTimerEvent extends TimerEvent {
  final int time;
  final bool gameTimer;

  StartTimerEvent({required this.time, required this.gameTimer});
}

class TimerTickedEvent extends TimerEvent {
  final int time;

  TimerTickedEvent({required this.time});
}

class StopTimerEvent extends TimerEvent {}
