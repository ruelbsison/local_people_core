part of 'splash_bloc.dart';

@immutable
abstract class SplashState {}

class SplashStateNotStarted extends SplashState {}

class SplashStateStarted extends SplashState {}

class SplashStateCompleted extends SplashState {}

/*import '../../core/bloc/bloc_event_state.dart';
import 'package:meta/meta.dart';

class SplashState extends BlocState {
  SplashState({
    @required this.isStarted,
    this.isCompleted: false,
  });

  final bool isStarted;
  final bool isCompleted;

  factory SplashState.notStarted() {
    return SplashState(
      isStarted: false,
    );
  }

  factory SplashState.completed() {
    return SplashState(
      isStarted: true,
      isCompleted: true,
    );
  }

  factory SplashState.started() {
    return SplashState(
      isStarted: true
    );
  }
}*/

