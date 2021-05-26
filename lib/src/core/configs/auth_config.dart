//import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
//import 'package:flutter_appauth/flutter_appauth.dart';

const String AUTH0_CLIENT_DOMAIN = 'local-people-client.eu.auth0.com';
const String AUTH0_CLIENT_CLIENT_ID = '320GqfRM747tQd6WJV7BxngjJtmWxVzS';
const String AUTH0_CLIENT_SECRET = '7rGOwiCMYOLbNZJO-n0bNiYdR7LRiM3_i0nmEjLrzGmN5hRlx6tzaXpKFv1JV8mT';
const String AUTH0_CLIENT_REDIRECT_URI = 'combineai.localpeople.client://login-callback';

//const String AUTH0_CLIENT_DOMAIN_IOS = 'local-people-client.eu.auth0.com';
const String AUTH0_CLIENT_CLIENT_ID_IOS = '8yte3Q9v2T6e8S5zUSSX6RBFZbKkTYP1';
const String AUTH0_CLIENT_SECRET_IOS = 'ljM3d2wdDMZmh6_fywydC64moG9XAEf01ClN_Sq_1y74Ru5teKmSxKlsqM6Mue6_';
const String AUTH0_CLIENT_REDIRECT_URI_IOS = 'combineai.localpeople.client://login-callback';

const String AUTH0_DOMAIN_PROD = 'local-people.eu.auth0.com';
const String AUTH0_DOMAIN_DEV = 'dev-pgi9e-14.eu.auth0.com';
const String AUTH0_CLIENT_CLIENT_ID_DEV = 'wFVbmSPRNiU4cvfoZa8j11BvoJ17zvRm';
const String AUTH0_CLIENT_CLIENT_ID_PROD = 'PJokfElKh44ct2AFkJ0XxVquHvt5ftw1';
//const String AUTH0_CLIENT_SECRET = 'aAtHBXH6KdZ3OZHKXDQsNMoYpNF36V420t3hQ67maI3bVGzdc9ELTmlMUgbLNyFY';
const String AUTH0_TRADER_CLIENT_ID_DEV = 'V9cNgmtlDesECyFrfip4FuR1SmcAQDQ4';
const String AUTH0_TRADER_CLIENT_ID_PROD = 'nW82vRTOq7v2YXDQppUdZ50GeUDu93in';
const String AUTH0_TRADER_SECRET = 'JxxFeSjUyf-nh7kgOIrlpWTW15_d3z7V7II9NITykdsBSBZNbowAhQAdbU6vo-Ym';
// https://combineai.localpeople:/login-callback
// https://combineai.localpeople-test:/login-callback
// https://combineai.localpeople-qa:/login-callback
const String AUTH0_CLIENT_REDIRECT_URI_DEV = 'combineai.localpeople.client-dev://login-callback';
const String AUTH0_TRADER_REDIRECT_URI_DEV = 'combineai.localpeople.trader-dev://login-callback';
const String AUTH0_CLIENT_REDIRECT_URI_PROD = 'combineai.localpeople.client://login-callback';
const String AUTH0_TRADER_REDIRECT_URI_PROD = 'combineai.localpeople.trader://login-callback';
const String AUTH0_CLIENT_TOKEN_KEY = 'client_token';
const String AUTH0_TRADER_TOKEN_KEY = 'trader_token';
final List<String> _scopes = <String>[
'openid','profile','offline_access','name','given_name','family_name','nickname','email','email_verified','picture','created_at','identities','phone','address'
];

class AuthorizationConfig {
  AuthorizationConfig({
    @required this.authDomain,
    @required this.authClientId,
    @required this.authSecret,
    @required this.authRedirectURI,
    //@required this.authTokenKey,
    @required this.authDebugTag,
    @required this.authUserBaseKey,
  }) :  authUserIdKey = 'user_id_$authUserBaseKey',
        authUserNameKey = 'user_name_$authUserBaseKey',
        authUserEmailKey = 'user_email_$authUserBaseKey',
        authUserPhotoKey = 'user_proto_$authUserBaseKey',
        authUserTokenKey = 'user_token_$authUserBaseKey',
        authUserTokenDateKey = 'user_token_data_$authUserBaseKey',
        authIssuer = 'https://$authDomain',
        authDiscoveryUrl = 'https://$authDomain/.well-known/openid-configuration',
        authorizationEndpoint = 'https://$authDomain/authorize',
        tokenEndpoint = 'https://$authDomain/oauth/token';

  final List<String> authScopes = <String>[
    'openid','profile','offline_access','name', 'email'
  ];

  final String authDomain;
  final String authClientId;
  final String authSecret;
  final String authRedirectURI;
  //final String authTokenKey;
  final bool authDebugTag;
  final String authUserBaseKey;
  final String authUserIdKey;
  final String authUserNameKey;
  final String authUserPhotoKey;
  final String authUserEmailKey;
  final String authUserTokenKey;
  final String authUserTokenDateKey;
  final String authIssuer;
  final String authDiscoveryUrl;
  //preferEphemeralSession
  //final String _discoveryUrl =
  //       'https://dev-pgi9e-14.eu.auth0.com/.well-known/openid-configuration';

  //final AuthorizationServiceConfiguration authServiceConfiguration;
  final String authorizationEndpoint;
  final String tokenEndpoint;

  static AuthorizationConfig prodClientAuthorizationConfig() {
    return AuthorizationConfig(
        authDomain: AUTH0_CLIENT_DOMAIN,
        authClientId: AUTH0_CLIENT_CLIENT_ID,
        authSecret: AUTH0_CLIENT_SECRET,
        authRedirectURI: AUTH0_CLIENT_REDIRECT_URI,
        //authTokenKey: AUTH0_CLIENT_TOKEN_KEY,
        authDebugTag: false,
        authUserBaseKey: 'client',
    );
  }

  static AuthorizationConfig prodIOSClientAuthorizationConfig() {
    return AuthorizationConfig(
      authDomain: AUTH0_CLIENT_DOMAIN,
      authClientId: AUTH0_CLIENT_CLIENT_ID_IOS,
      authSecret: AUTH0_CLIENT_SECRET_IOS,
      authRedirectURI: AUTH0_CLIENT_REDIRECT_URI_IOS,
      //authTokenKey: AUTH0_CLIENT_TOKEN_KEY,
      authDebugTag: false,
      authUserBaseKey: 'client',
    );
  }

  static AuthorizationConfig prodTraderAuthorizationConfig() {
    return AuthorizationConfig(
        authDomain: AUTH0_DOMAIN_PROD,
        authClientId: AUTH0_TRADER_CLIENT_ID_PROD,
        authSecret: AUTH0_TRADER_SECRET,
        authRedirectURI: AUTH0_TRADER_REDIRECT_URI_PROD,
        //authTokenKey: AUTH0_TRADER_TOKEN_KEY,
        authDebugTag: false,
        authUserBaseKey: 'trader',
    );
  }

  static AuthorizationConfig prodIOSTraderAuthorizationConfig() {
    return AuthorizationConfig(
      authDomain: AUTH0_DOMAIN_PROD,
      authClientId: AUTH0_TRADER_CLIENT_ID_PROD,
      authSecret: AUTH0_TRADER_SECRET,
      authRedirectURI: AUTH0_TRADER_REDIRECT_URI_PROD,
      //authTokenKey: AUTH0_TRADER_TOKEN_KEY,
      authDebugTag: false,
      authUserBaseKey: 'trader',
    );
  }

  static AuthorizationConfig devClientAuthorizationConfig() {
    return AuthorizationConfig(
        authDomain: AUTH0_DOMAIN_DEV,
        authClientId: AUTH0_CLIENT_CLIENT_ID_DEV,
        authRedirectURI: AUTH0_CLIENT_REDIRECT_URI_DEV,
        //authTokenKey: AUTH0_CLIENT_TOKEN_KEY,
        authDebugTag: true,
        authUserBaseKey: 'client',
    );
  }

  static AuthorizationConfig devTraderAuthorizationConfig() {
    return AuthorizationConfig(
        authDomain: AUTH0_DOMAIN_DEV,
        authClientId: AUTH0_TRADER_CLIENT_ID_DEV,
        authRedirectURI: AUTH0_TRADER_REDIRECT_URI_DEV,
        //authTokenKey: AUTH0_TRADER_TOKEN_KEY,
        authDebugTag: true,
        authUserBaseKey: 'trader',
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
