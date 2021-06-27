import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:local_people_core/auth.dart';
import 'package:local_people_core/profile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio_http_cache/dio_http_cache.dart';

class RestClientInterceptor {
  final AuthLocalDataSource authLocalDataSource;
  final String baseURL;
  final int maxAgeInSec;
  Dio dio = Dio();
  Options _cacheOptions = buildCacheOptions(Duration(minutes: 30));

  RestClientInterceptor({
    @required this.authLocalDataSource,
    @required this.baseURL,
    this.maxAgeInSec = 3600, // 1 hour
  }) : assert(authLocalDataSource != null),
        assert(baseURL != null){
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
      String token = await authLocalDataSource.getAccessToken();
      //String token = 'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6IjZ5Sl81RW9zYWpkVzh1SFJSTVktZyJ9.eyJpc3MiOiJodHRwczovL2xvY2FsLXBlb3BsZS5ldS5hdXRoMC5jb20vIiwic3ViIjoiTGZScVM3V052Wk5GQXl4T1ZpeHBQTEFkNFlTYjdsREJAY2xpZW50cyIsImF1ZCI6Imh0dHBzOi8vbG9jYWxwZW9wbGUtYXBpIiwiaWF0IjoxNjIyODA3OTIzLCJleHAiOjE2MjI4OTQzMjMsImF6cCI6IkxmUnFTN1dOdlpORkF5eE9WaXhwUExBZDRZU2I3bERCIiwiZ3R5IjoiY2xpZW50LWNyZWRlbnRpYWxzIn0.CVcRgoB3szVk8HquD587MoDNtffneqdvVOYfTCAb7Ekpd8BGptKhvG4KDe2bto1RwuhFrdQ7X6qona_jnETTVurte9_bdc5wC7EHhbG0B6QUfcyVQqGuEoz_Z3TFNaOvNCn4_t-sDThbuUYZe6HYlPHL1lPIYI_DDX0n6b0IZyebuOEF8B8clYOKvf7rEshSHCvc8K3xx7vSIIzvTegsUW4AVmxLvaGMwCgAU5iYcZcAcnF170QVYCZnnAADZGtREQV58vUSp1kHZcpzsr--kPyyOxq1mUJHGKhvFXXq68t0kkhyaI6LCzHqsVrRwMX3vMc7eBciuiMItzAIH5IVpQ';
      var customHeaders = {
        'Authorization': 'Bearer ' + token,
        "Cache-Control": "public, max-age=" + maxAgeInSec.toString(),
        //"Cache-Control": "public, only-if-cached, max-stale=" + (900).toString(), // 315mins (60 * 60 * 24 * 1).toString(),
      };

      options.headers.addAll(customHeaders);
      return options;
    }));

    dio.interceptors.add(InterceptorsWrapper(onError: (DioError error) async {
      if ( error.response == null)
        return;
      int _errorCode = error.response.statusCode;
      if (error.type == DioErrorType.RESPONSE) {
        print("Received invalid status code: ${error.response.statusCode} : ${error.response.statusMessage}");
        if (_errorCode == 404 && (error.request.path.startsWith('/client') == true
            || error.request.path.startsWith('/trader') == true )) {
          //context.read<ProfileBloc>().add(ProfileCreateEvent());
        }
      }
    }));

    //dio.interceptors.add(DioCacheManager(CacheConfig(baseUrl: Uri.parse(url))));
    dio.interceptors.add(DioCacheManager(CacheConfig(baseUrl: baseURL)).interceptor);
  }
}
