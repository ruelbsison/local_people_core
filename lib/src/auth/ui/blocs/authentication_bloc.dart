import 'dart:async';

import '../../domain/repositories/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../data/models/auth_local_model.dart';
import '../../data/datasources/auth_local_data_source.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthLocalDataSource authLocalDataSource;
  final AuthenticationRepository authenticationRepository;
  
  AuthenticationBloc({
    @required this.authLocalDataSource,
    @required this.authenticationRepository,
  })  : assert(authLocalDataSource != null), assert(authenticationRepository != null),
        super(Uninitialized()) {
    //_userSubscription = _authenticationRepository.user.listen(
    //  (user) => add(AuthenticationUserChanged(user)),
    //);
  }

  
  @override
  AuthenticationState get initialState => Uninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is AuthenticateUser) {
      yield* _mapAuthenticateUserState();
    } else if (event is ReAuthenticateUser) {
      yield* _mapReAuthenticateUserState();
    } else if (event is UnAuthenticateUser) {
      yield* _mapUnAuthenticateUserState();
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState() async* {
    try {
      final isAuthenticated = await authLocalDataSource.hasAuth();

      if (isAuthenticated) {
        final expired = await authLocalDataSource.didAuthExpired();
        if (expired == true)
          yield ReAuthenticate();
        else
          yield Authenticated();
      } else {
        yield Unauthenticated();
      }
    } catch (_) {
      yield Unauthenticated();
    }
  }

  Stream<AuthenticationState> _mapAuthenticateUserState() async* {
    AuthLocalModel authLocalModel = await authenticationRepository
        .requestUserAuthorization();
    if (authLocalModel != null) {
      await authLocalDataSource.saveAuth(authLocalModel);
      yield Authenticated(); //authLocalModel.userFullName);
    } else {
      yield AuthenticationError();
    }
  }

  Stream<AuthenticationState> _mapReAuthenticateUserState() async* {
    String token = await authLocalDataSource.getToken();
    AuthLocalModel authLocalModel = await authenticationRepository.refreshUserAuthorization(token);
    if (authLocalModel != null) {
      await authLocalDataSource.saveAuth(authLocalModel);
      yield Authenticated(); //authLocalModel.userFullName);
    } else {
      yield AuthenticationError();
    }
  }

  Stream<AuthenticationState> _mapUnAuthenticateUserState() async* {
    await authenticationRepository.unAuthenticated();
    yield Unauthenticated();
  }
}
