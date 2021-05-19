class AuthorizationServiceUri {
  AuthorizationServiceUri(
      this.authorizationUrl,
      this.redirectUrl,
      ) : assert(redirectUrl != null && authorizationUrl != null,
  'Must specify both the authorization and token endpoints');

  final String authorizationUrl;

  final String redirectUrl;
}