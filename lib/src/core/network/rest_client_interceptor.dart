import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:local_people_core/auth.dart';

class RestClientInterceptor {
  final AuthLocalDataSource authLocalDataSource;
  Dio dio = Dio();

  RestClientInterceptor({
    @required this.authLocalDataSource,
  }) : assert(authLocalDataSource != null) {
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
      String token = await authLocalDataSource.getAccessToken();
      //String token = 'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6IjZ5Sl81RW9zYWpkVzh1SFJSTVktZyJ9.eyJpc3MiOiJodHRwczovL2xvY2FsLXBlb3BsZS5ldS5hdXRoMC5jb20vIiwic3ViIjoiTGZScVM3V052Wk5GQXl4T1ZpeHBQTEFkNFlTYjdsREJAY2xpZW50cyIsImF1ZCI6Imh0dHBzOi8vbG9jYWxwZW9wbGUtYXBpIiwiaWF0IjoxNjIyODA3OTIzLCJleHAiOjE2MjI4OTQzMjMsImF6cCI6IkxmUnFTN1dOdlpORkF5eE9WaXhwUExBZDRZU2I3bERCIiwiZ3R5IjoiY2xpZW50LWNyZWRlbnRpYWxzIn0.CVcRgoB3szVk8HquD587MoDNtffneqdvVOYfTCAb7Ekpd8BGptKhvG4KDe2bto1RwuhFrdQ7X6qona_jnETTVurte9_bdc5wC7EHhbG0B6QUfcyVQqGuEoz_Z3TFNaOvNCn4_t-sDThbuUYZe6HYlPHL1lPIYI_DDX0n6b0IZyebuOEF8B8clYOKvf7rEshSHCvc8K3xx7vSIIzvTegsUW4AVmxLvaGMwCgAU5iYcZcAcnF170QVYCZnnAADZGtREQV58vUSp1kHZcpzsr--kPyyOxq1mUJHGKhvFXXq68t0kkhyaI6LCzHqsVrRwMX3vMc7eBciuiMItzAIH5IVpQ';
      var customHeaders = {
        //'Authorization': token,
        'Authorization': 'Bearer ' + token,
        // other headers
      };
      options.headers.addAll(customHeaders);
      return options;
    }));
  }
}
