import 'dart:async';
import '../models/auth_session_model.dart';
import '../models/auth_profile_model.dart';

class CreateSessionFailure implements Exception {}
class RefreshSessionFailure implements Exception {}
class GetUserDetailsFailure implements Exception {}

abstract class AuthenticationDataSource {
  Future<AuthSessionModel> createSession();

  Future<AuthSessionModel> refreshSession(String refreshToken);

  Future<AuthProfileModel> getSessionProfile(String accessToken);
}
