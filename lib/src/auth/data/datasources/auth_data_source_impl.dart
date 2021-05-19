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

class AuthenticationDataSourceImpl extends AuthenticationDataSource {

  final AuthorizationConfig authorizationConfig;
  final StreamController<AuthenticationStatus> _controller;
  final FlutterAppAuth _appAuth;

  AuthenticationDataSourceImpl({
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
      // use the discovery endpoint to find the configuration
      final AuthorizationResponse authResponse = await _appAuth.authorize(
        AuthorizationRequest(
          authorizationConfig.authClientId,
          authorizationConfig.authRedirectURI,
          discoveryUrl: authorizationConfig.authDiscoveryUrl,
          scopes: authorizationConfig.authScopes,
        ),
      );

      if (authResponse == null) {
        throw Exception('Failed to get authorization');
      }

      final TokenResponse tokenResponse = await _appAuth.token(
        TokenRequest(
          authorizationConfig.authClientId,
          authorizationConfig.authRedirectURI,
          authorizationCode: authResponse.authorizationCode,
          discoveryUrl: authorizationConfig.authDiscoveryUrl,
          codeVerifier: authResponse.codeVerifier,
          scopes: authorizationConfig.authScopes,
        ),
      );

      /*final AuthorizationTokenResponse tokenResponse =
      await _appAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(
            authorizationConfig.authClientId,
            authorizationConfig.authRedirectURI,
            issuer: authorizationConfig.authDomain,
            scopes: authorizationConfig.authScopes,
            //promptValues: ['login']
        ),
      );*/

      if (tokenResponse == null) {
        throw Exception('Failed token code exchange');
      }

      //final Map<String, Object> idToken = parseIdToken(tokenResponse.idToken);
      //final Map<String, Object> profile = await getUserDetails(tokenResponse.accessToken);

      // name = idToken['name'];
      // picture = profile['picture'];

      _controller.add(AuthenticationStatus.authenticated);

      return AuthSessionModel(
        tokenId: tokenResponse.idToken,
        refreshToken: tokenResponse.refreshToken,
        accessToken: tokenResponse.accessToken,
        expiredAt: tokenResponse.accessTokenExpirationDateTime,
      );

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
      /*final TokenResponse tokenResponse = await _appAuth.token(TokenRequest(
        authorizationConfig.authClientId,
        authorizationConfig.authRedirectURI,
        issuer: authorizationConfig.authIssuer,
        refreshToken: refreshToken,
      ));*/

      final TokenResponse tokenResponse = await _appAuth.token(
        TokenRequest(
            authorizationConfig.authClientId,
            authorizationConfig.authRedirectURI,
            //authorizationCode: authResponse.authorizationCode,
            discoveryUrl: authorizationConfig.authDiscoveryUrl,
            //codeVerifier: authResponse.codeVerifier,
            refreshToken: refreshToken,
            scopes: authorizationConfig.authScopes
        ),
      );

      if (tokenResponse == null) {
        throw RefreshSessionFailure();
      }

      //final Map<String, Object> idToken = parseIdToken(tokenResponse.idToken);
      //final Map<String, Object> profile = await getUserDetails(tokenResponse.accessToken);

      // name = idToken['name'];
      // picture = profile['picture'];

      _controller.add(AuthenticationStatus.authenticated);

      return AuthSessionModel(
        tokenId: tokenResponse.idToken,
        refreshToken: tokenResponse.refreshToken,
        accessToken: tokenResponse.accessToken,
        expiredAt: tokenResponse.accessTokenExpirationDateTime,
      );
    } on Exception catch (e, s) {
      //debugPrint('error on refresh token: $e - stack: $s');
      throw RefreshSessionFailure();
    }
  }

  @override
  Future<AuthProfileModel> getSessionProfile(String accessToken) async {
    //final Map<String, Object> profile = parseIdToken(idToken);
    final Map<String, Object> profile = await getUserDetails(accessToken);

    return AuthProfileModel(
      name: profile['name'],
      email: profile['email'],
      email_verified: profile['email_verified'],
      photo: profile['picture'],
    );
  }

  Map<String, Object> parseIdToken(String idToken) {
    final List<String> parts = idToken.split('.');
    if (parts.length < 3) return Map<String, Object>();

    return jsonDecode(
        utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))));
  }

  @override
  Future<Map<String, Object>> getUserDetails(String accessToken) async {
    String url = authorizationConfig.authIssuer + '/userinfo';
    final http.Response response = await http.get(
      url,
      headers: <String, String>{'Authorization': 'Bearer $accessToken'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw GetUserDetailsFailure();
    }
  }

  void dispose() => _controller.close();
}
