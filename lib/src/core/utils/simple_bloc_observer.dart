import 'package:bloc/bloc.dart';

class SimpleBlocObserver extends BlocObserver {

  @override
  void onEvent(Bloc bloc, Object event) {
    print(event);
    super.onEvent(bloc, event);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print(error);
    super.onError(bloc, error, stackTrace);
  }

  // void onError(Cubit cubit, Object error, StackTrace stackTrace) {
  //   print(error);
  //   super.onError(cubit, error, stackTrace);
  // }

  @override
  void onChange(BlocBase bloc, Change change) {
    print(change);
    super.onChange(bloc, change);
  }

  @override
  void onClose(BlocBase bloc) {
    print(bloc);
    super.onClose(bloc);
  } // @override

  // @override
  // void onChange(Cubit cubit, Change change) {
  //   print(change);
  //   super.onChange(cubit, change);
  // }


  @override
  void onTransition(Bloc bloc, Transition transition) {
    print(transition);
    super.onTransition(bloc, transition);
  }

  @override
  void onCreate(BlocBase bloc) {
    print(bloc);
    super.onCreate(bloc);
  }
}
