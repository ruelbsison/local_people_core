import 'package:meta/meta.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_data_source.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthLocalDataSource authLocalDataSource;


  AuthenticationRepositoryImpl({
    @required this.authLocalDataSource
  }) : assert(authLocalDataSource != null);

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

}