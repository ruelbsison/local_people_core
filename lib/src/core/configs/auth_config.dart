//import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:flutter_appauth/flutter_appauth.dart';

const String AUTH0_DOMAIN_DEV = 'dev-pgi9e-14.eu.auth0.com'; // http://combinedotai.eu.auth0.com/
const String AUTH0_CLIENT_CLIENT_ID_DEV = 'wFVbmSPRNiU4cvfoZa8j11BvoJ17zvRm'; // 80IzP0wmeQVlxzd5NHBNHKPgw3u8JV8Q
// JiuRH46HtPqAsSmuDC6F4Tkw4z_3hGkmubKMhCZ-pS19Sfvmsd0LtbXqPBhVmd6V
const String AUTH0_TRADER_CLIENT_ID_DEV = 'V9cNgmtlDesECyFrfip4FuR1SmcAQDQ4'; // F8QjgeMSDjPHU07Pf2floSuCWqQPCxf9
// TTulYTi19jOvgJkQFR2cDHv8ntEN9w4duZtP9QT7Z_xpgi-Hmls9pq5v_Uffetsu
// https://combineai.localpeople:/login-callback
// https://combineai.localpeople-test:/login-callback
// https://combineai.localpeople-qa:/login-callback
const String AUTH0_CLIENT_REDIRECT_URI_DEV = 'combineai.localpeople.client://login-callback';
const String AUTH0_TRADER_REDIRECT_URI_DEV = 'combineai.localpeople.trader://login-callback';
const String AUTH0_CLIENT_TOKEN_KEY = 'client_token';
const String AUTH0_PROVIDER_TOKEN_KEY = 'trader_token';
final List<String> _scopes = <String>[
'openid','profile','offline_access','name','given_name','family_name','nickname','email','email_verified','picture','created_at','identities','phone','address'
];

class AuthorizationConfig {
  AuthorizationConfig({
    @required this.authDomain,
    @required this.authClientId,
    @required this.authRedirectURI,
    @required this.authTokenKey,
    @required this.authDebugTag,
    @required this.authUserBaseKey,
  }) :  authUserIdKey = 'user_id_$authUserBaseKey',
        authUserNameKey = 'user_name_$authUserBaseKey',
        authUserEmailKey = 'user_email_$authUserBaseKey',
        authUserTokenKey = 'user_token_$authUserBaseKey',
        authUserTokenDateKey = 'user_token_data_$authUserBaseKey',
        authIssuer = 'https://$authDomain',
        authDiscoveryUrl = 'https://$authDomain/.well-known/openid-configuration',
        authServiceConfiguration = AuthorizationServiceConfiguration(
          'https://$authDomain/authorize',
          'https://$authDomain/token'
        );

  final List<String> authScopes = <String>[
    'openid','profile','offline_access','name', 'email'
  ];

  final String authDomain;
  final String authClientId;
  final String authRedirectURI;
  final String authTokenKey;
  final bool authDebugTag;
  final String authUserBaseKey;
  final String authUserIdKey;
  final String authUserNameKey;
  final String authUserEmailKey;
  final String authUserTokenKey;
  final String authUserTokenDateKey;
  final String authIssuer;
  final String authDiscoveryUrl;
  //preferEphemeralSession
  //final String _discoveryUrl =
  //       'https://dev-pgi9e-14.eu.auth0.com/.well-known/openid-configuration';
  final AuthorizationServiceConfiguration authServiceConfiguration;

  static AuthorizationConfig testClientAuthorizationConfig() {
    return AuthorizationConfig(
        authDomain: AUTH0_DOMAIN_DEV,
        authClientId: AUTH0_CLIENT_CLIENT_ID_DEV,
        authRedirectURI: AUTH0_CLIENT_REDIRECT_URI_DEV,
        authTokenKey: AUTH0_CLIENT_TOKEN_KEY,
        authDebugTag: true
    );
  }

  static AuthorizationConfig testTraderAuthorizationConfig() {
    return AuthorizationConfig(
        authDomain: AUTH0_DOMAIN_DEV,
        authClientId: AUTH0_TRADER_CLIENT_ID_DEV,
        authRedirectURI: AUTH0_TRADER_REDIRECT_URI_DEV,
        authTokenKey: AUTH0_PROVIDER_TOKEN_KEY,
        authDebugTag: true,
        authUserBaseKey: 'trader',
    );
  }

  static AuthorizationConfig devClientAuthorizationConfig() {
    return AuthorizationConfig(
        authDomain: AUTH0_DOMAIN_DEV,
        authClientId: AUTH0_CLIENT_CLIENT_ID_DEV,
        authRedirectURI: AUTH0_CLIENT_REDIRECT_URI_DEV,
        authTokenKey: AUTH0_CLIENT_TOKEN_KEY,
        authDebugTag: true,
        authUserBaseKey: 'client',
    );
  }

  static AuthorizationConfig devTraderAuthorizationConfig() {
    return AuthorizationConfig(
        authDomain: AUTH0_DOMAIN_DEV,
        authClientId: AUTH0_TRADER_CLIENT_ID_DEV,
        authRedirectURI: AUTH0_TRADER_REDIRECT_URI_DEV,
        authTokenKey: AUTH0_PROVIDER_TOKEN_KEY,
        authDebugTag: true
    );
  }

}

/*class AuthorizationConfig extends InheritedWidget {
  AuthorizationConfig({
    @required this.auth0Domain,
    @required this.auth0ClientId,
    @required this.auth0RedirectURI,
    @required this.debugTag,
    @required Widget child,
  }) : auth0erviceConfiguration = AuthorizationServiceConfiguration(
      'https://$auth0Domain/authorize',
      'https://$auth0Domain/token'), super(child: child);

  final String auth0Domain; // 'dev-pgi9e-14.eu.auth0.com'
  final String auth0ClientId; // 'aJXtcTC3NfxaHOgtZSpqZyTD5M7oQkDK'
  // https://combineai.localpeople:/login-callback
  // https://combineai.localpeople-test/login-callback
  // https://combineai.localpeople-qa:/login-callback
  final String auth0RedirectURI; // 'com.auth0.flutterdemo://login-callback'

  final bool debugTag;
  final AuthorizationServiceConfiguration auth0erviceConfiguration;

  static AuthorizationConfig of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType();
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }
}*/
