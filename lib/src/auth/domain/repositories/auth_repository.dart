import '../../data/models/auth_local_model.dart';

abstract class AuthenticationRepository {
  Future<void> unAuthenticated();

  //Future<bool> isAuthenticated();

  //Future<String> getUser();

  Future<AuthLocalModel> requestUserAuthorization();

  Future<AuthLocalModel> refreshUserAuthorization(String token);
}