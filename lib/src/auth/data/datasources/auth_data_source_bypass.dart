import 'dart:async';
import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_appauth/flutter_appAuth.dart';

import '../../../core/enum/auth_status.dart';
import '../../../core/configs/auth_config.dart';
import '../models/auth_session_model.dart';
import '../models/auth_profile_model.dart';

import 'auth_data_source.dart';

class AuthenticationDataSourceByPass extends AuthenticationDataSource {

  final AuthorizationConfig authorizationConfig;
  final StreamController<AuthenticationStatus> _controller;
  final FlutterAppAuth _appAuth;

  AuthenticationDataSourceByPass({
    @required this.authorizationConfig
  })  : _controller = StreamController<AuthenticationStatus>(),
        _appAuth = FlutterAppAuth();

  /*@override
  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }*/

  @override
  Future<AuthSessionModel> createSession() async {
    try {
      _controller.add(AuthenticationStatus.authenticated);

      return AuthSessionModel.defaultAuth();

      //return refreshSession(tokenResponse.refreshToken);
    } on Exception catch (e, s) {
      // debugPrint('login error: $e - stack: $s');
      _controller.add(AuthenticationStatus.unauthenticated);

      throw CreateSessionFailure();
      // throw CreateSessionFailure('CreateSessionFailure: $e - stack: $s');
    }
  }

  @override
  Future<AuthSessionModel> refreshSession(String refreshToken) async {
    try {
      _controller.add(AuthenticationStatus.authenticated);

      return AuthSessionModel.defaultAuth();
    } on Exception catch (e, s) {
      //debugPrint('error on refresh token: $e - stack: $s');
      throw RefreshSessionFailure();
    }
  }

  @override
  Future<AuthProfileModel> geSessionProfile(String idToken) async {
    return AuthProfileModel.clientDefault();
  }

  void dispose() => _controller.close();
}
