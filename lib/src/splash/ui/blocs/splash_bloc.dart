import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc()
      :  super(SplashStateNotStarted());

  @override
  SplashState get initialState => SplashStateNotStarted();

  @override
  Stream<SplashState> mapEventToState(
      SplashEvent event,
      ) async* {
    if (event is SplashStateNotStarted) {
      //yield SplashStateNotStarted();
    }
    if (event is SplashEventStarted) {
      //yield SplashStateStarted();
    }
    if (event is SplashStateCompleted) {
      yield SplashStateCompleted();
    }
  }
}

/*import '../../core/bloc/bloc_event_state.dart';
import 'splash_event.dart';
import 'splash_state.dart';


class SplashBloc extends BlocEventStateBase<SplashEvent, SplashState> {

  SplashBloc()
      : super(
    initialState: SplashState.notStarted(),
  );

  @override
  Stream<SplashState> eventHandler(SplashEvent event, SplashState currentState) async* {
    if (!currentState.isStarted && event.type == SplashEventType.start){
      yield SplashState.started();
    }

    if (!currentState.isStarted && event.type == SplashEventType.complete){
      yield SplashState.completed();
    }

  }
}*/