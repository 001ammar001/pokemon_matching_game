import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_projects/pokemon_app/features/domain/repository/timer_repository.dart';

part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  final GameTimer gameTimer;

  StreamSubscription? _streamSubscription;

  TimerBloc({required this.gameTimer}) : super(TimerState()) {
    on<StartTimerEvent>(_streamSubscriptionRequested);
    on<StopTimerEvent>(_stopTimerEvent);
    on<TimerTickedEvent>(_timerTicked);
  }

  _streamSubscriptionRequested(
    StartTimerEvent event,
    Emitter emit,
  ) {
    emit(
      state.copyWith(state: TimerEnum.running, isGameTimer: event.gameTimer),
    );

    _streamSubscription?.cancel();
    _streamSubscription = gameTimer.tick(event.time * 10).listen(
      (data) {
        add(TimerTickedEvent(time: data));
      },
    );
  }

  _timerTicked(
    TimerTickedEvent event,
    Emitter emit,
  ) {
    emit(
      event.time > 0
          ? state.copyWith(duration: event.time)
          : state.copyWith(duration: 0, state: TimerEnum.finished),
    );
  }

  _stopTimerEvent(StopTimerEvent event, Emitter emit) {
    _streamSubscription?.cancel();
    emit(state.copyWith(state: TimerEnum.pending));
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
