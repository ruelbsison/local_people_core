import 'dart:async';

//import 'package:local_people_core/src/domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
//import '../../../core/enum/auth_status.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../data/models/auth_local_model.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository _authenticationRepository;
  
  AuthenticationBloc({
    @required AuthenticationRepository authenticationRepository,
  })  : assert(authenticationRepository != null),
        _authenticationRepository = authenticationRepository,
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
      final isAuthenticated = await _authenticationRepository.isAuthenticated();

      if (isAuthenticated) {
        final name = await _authenticationRepository.getUser();
        yield Authenticated(name);
      } else {
        yield Unauthenticated();
      }
    } catch (_) {
      yield Unauthenticated();
    }
  }

  Stream<AuthenticationState> _mapAuthenticateUserState() async* {
    AuthLocalModel authLocalModel = await _authenticationRepository.requestUserAuthorization();
    if (authLocalModel != null)
      yield Authenticated(authLocalModel.userFullName);
    else
      yield AuthenticationError();
  }

  Stream<AuthenticationState> _mapReAuthenticateUserState() async* {
    AuthLocalModel authLocalModel = await _authenticationRepository.requestUserAuthorization();
    if (authLocalModel != null)
      yield Authenticated(authLocalModel.userFullName);
    else
      yield AuthenticationError();
  }

  Stream<AuthenticationState> _mapUnAuthenticateUserState() async* {
    _authenticationRepository.unAuthenticated();
    yield Unauthenticated();
  }
}
