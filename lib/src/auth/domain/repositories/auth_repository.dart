
abstract class AuthenticationRepository {
  Future<void> unAuthenticated();

  Future<bool> isAuthenticated();

  Future<String> getUser();
}