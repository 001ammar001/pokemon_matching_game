part of 'timer_bloc.dart';

enum TimerEnum { pending, running, finished }

class TimerState {
  final int duration;
  final TimerEnum state;
  final bool isGameTimer;

  TimerState({
    this.duration = 0,
    this.state = TimerEnum.pending,
    this.isGameTimer = false,
  });

  TimerState copyWith({int? duration, TimerEnum? state, bool? isGameTimer}) {
    return TimerState(
      duration: duration ?? this.duration,
      state: state ?? this.state,
      isGameTimer: isGameTimer ?? this.isGameTimer,
    );
  }
}
