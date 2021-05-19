import 'package:local_people_core/auth.dart';
import 'package:meta/meta.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_data_source.dart';
import '../datasources/auth_data_source.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthLocalDataSource authLocalDataSource;
  final AuthenticationDataSource authenticationDataSource;

  AuthenticationRepositoryImpl({
    @required this.authLocalDataSource,
    @required this.authenticationDataSource
  }) : assert(authLocalDataSource != null), assert(authenticationDataSource != null);

  @override
  Future<bool> isAuthenticated() async {
    bool hasAuth = await authLocalDataSource.hasAuth();
    if (hasAuth == false) return false;

    bool didExpired = await authLocalDataSource.didAuthExpired();
    if (didExpired == true) return false;

    return true;
  }

  @override
  Future<void> unAuthenticated() async {
    await authLocalDataSource.deleteAuth();
  }

  @override
  Future<String> getUser() async {
    String name = await authLocalDataSource.getUserName();

    return name;
  }

  @override
  Future<AuthLocalModel> refreshUserAuthorization() async {
    AuthLocalModel authLocal;
    try {
      AuthLocalModel auth  = await authLocalDataSource.getAuth();
      AuthSessionModel session = await authenticationDataSource.refreshSession(auth.token);
      AuthProfileModel profile = await authenticationDataSource.getSessionProfile(session.accessToken);

      authLocal = AuthLocalModel(
        userId: auth.userId,
        userEmail: profile.email,
        userFullName: profile.name,
        userPhoto: profile.photo,
        token: session.refreshToken,
        tokenExpirationDate: session.expiredAt,
      );
      authLocalDataSource.saveAuth(authLocal);
    } on RefreshSessionFailure catch(f, s) {

    }

    return authLocal;
  }

  @override
  Future<AuthLocalModel> requestUserAuthorization() async {
    AuthLocalModel authLocal;
    try {
      AuthSessionModel session = await authenticationDataSource.createSession();
      AuthProfileModel profile = await authenticationDataSource.getSessionProfile(session.accessToken);

      authLocal = AuthLocalModel(
        userId: 0,
        userEmail: profile.email,
        userFullName: profile.name,
        userPhoto: profile.photo,
        token: session.refreshToken,
        tokenExpirationDate: session.expiredAt,
      );
      authLocalDataSource.saveAuth(authLocal);
    } on CreateSessionFailure catch(f, s) {

    }

    return authLocal;
  }

}