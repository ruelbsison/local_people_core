part of 'splash_bloc.dart';

@immutable
abstract class SplashEvent {}

class SplashEventStarted extends SplashEvent {}

class SplashEventCompleted extends SplashEvent {}

/*mport '../../core/bloc/bloc_event_state.dart';

class SplashEvent extends BlocEvent {

  final SplashEventType type;

  SplashEvent({
    this.type: SplashEventType.start,
  }) : assert(type != null);
}

enum SplashEventType {
  start,
  complete,
}*/
