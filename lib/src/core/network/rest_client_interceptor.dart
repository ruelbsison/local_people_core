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
      String token = await authLocalDataSource.getToken();
      var customHeaders = {
        'bearer': token,
        // other headers
      };
      options.headers.addAll(customHeaders);
      return options;
    }));
  }
}
