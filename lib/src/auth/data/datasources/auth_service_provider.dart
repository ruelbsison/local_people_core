import 'package:meta/meta.dart';
//import 'package:oauth2/oauth2.dart' as oauth2;
//import 'package:oauth2/src/authorization_code_grant.dart';
import '../models/auth_session_model.dart';
import '../models/auth_profile_model.dart';
import '../../../core/configs/auth_config.dart';
//import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import '../models/auth_service_uri.dart';

abstract class AuthenticationServiceProvider {
  Future<AuthorizationServiceUri> getAuthUrl();

  Future<AuthSessionModel> refreshAuthToken(String refreshToken);

  Future<AuthProfileModel> getAuthProfile(String accessToken);
}

class AuthenticationServiceProviderImpl implements AuthenticationServiceProvider {
  final AuthorizationConfig authorizationConfig;

  AuthenticationServiceProviderImpl({
    @required this.authorizationConfig
  }) ;

  @override
  Future<AuthorizationServiceUri> getAuthUrl() async {
    // If we don't have OAuth2 credentials yet, we need to get the resource owner
    // to authorize us. We're assuming here that we're a command-line application.
    // AuthorizationCodeGrant grant = oauth2.AuthorizationCodeGrant(
    //     authorizationConfig.authClientId,
    //     Uri.parse(authorizationConfig.authorizationEndpoint),
    //     Uri.parse(authorizationConfig.tokenEndpoint),
    //     secret: authorizationConfig.authSecret);

    // A URL on the authorization server (authorizationEndpoint with some additional
    // query parameters). Scopes and state can optionally be passed into this method.
    // var authorizationUrl = grant.getAuthorizationUrl(
    //     Uri.parse(authorizationConfig.authRedirectURI),
    //     scopes: authorizationConfig.authScopes,
    // );

    // return AuthorizationServiceUri (
    //   authorizationUrl.toString(),
    //   authorizationConfig.authRedirectURI,
    // );
    // Redirect the resource owner to the authorization URL. Once the resource
    // owner has authorized, they'll be redirected to `redirectUrl` with an
    // authorization code. The `redirect` should cause the browser to redirect to
    // another URL which should also have a listener.
    //
    // `redirect` and `listen` are not shown implemented here.
    //await redirect(authorizationUrl);
    //var responseUrl = await listen(redirectUrl);

    // Once the user is redirected to `redirectUrl`, pass the query parameters to
    // the AuthorizationCodeGrant. It will validate them and extract the
    // authorization code to create a new Client.
    //return await grant.handleAuthorizationResponse(responseUrl.queryParameters);
    //final FlutterWebviewPlugin webviewPlugin = new FlutterWebviewPlugin();
    //webviewPlugin.launch(authorizationUrl.toString() /*, clearCache: true, clearCookies: true*/);
    //webviewPlugin.close();
  }

  @override
  Future<AuthSessionModel> refreshAuthToken(String refreshToken) {
    // TODO: implement refreshAuthToken
    throw UnimplementedError();
  }

  @override
  Future<AuthProfileModel> getAuthProfile(String accessToken) {
    // TODO: implement getAuthProfile
    throw UnimplementedError();
  }

}