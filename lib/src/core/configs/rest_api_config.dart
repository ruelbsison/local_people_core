import 'package:meta/meta.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';

class RestAPIConfig {
  String get baseURL => 'https://staging.localpeople.app/api/v1';
  // 'http://r-sison.ngrok.io/api/v1';
  //// 'http://192.168.254.133:3001/api/v1/';
  // 'https://staging.localpeople.app/api/v1';
  // 'http://192.168.254.133:3001/api/v1/';
  //'http://r-sison.ngrok.io/api/v1';
  // ./ngrok http -region=us -hostname=r-sison.ngrok.io 3001
  // 'http://192.168.1.5:3001/api/v1/';
  // 'http://localhost:3001/api/v1/';


  static const String client = '/clients';

  static const String clientWithId = '/clients/{id}';

  static const String clientWithEmail = '/client_by_email?email={email}';

  static const String trader = '/traders';

  static const String traderTopRated = '/traders/top_rated';

  static const String traderWithId = '/traders/{id}';

  static const String traderWithEmail = '/trader_by_email?email={email}';

  static const String job = '/jobs';

  static const String jobWithId = '/jobs/{id}';

  static const String jobClient = '/clients/{id}/jobs';

  static const String jobTrader = '/trader/{id}/jobs';

  static const String tag = '/tags';

  static const String tagWithId = '/tags/{id}';

  static const String jobTags = '/jobs/{id}/tags';

  static const String location = '/locations';

  static const String locationWithId = '/locations/{id}';

  static const String jobLocations = '/jobs/{id}/location';

  static const String clientLocations = '/clients/{id}/location';

  static const String traderLocations = '/traders/{id}/location';

  static const String quote = '/quotes';

  static const String quoteWithId = '/quotes/{id}';

  static const String quoteWithTraderId = '/traders/{id}/quotes';

  static const String quoteWithJobId = '/jobs/{id}/quotes';

  static const String quoteRequest = '/quote_requests';

  static const String quoteRequestWithId = '/quote_requests/{id}';

  static const String quoteRequestWithTraderId = '/traders/{id}/quote_requests';

  static const String quoteRequestWithJobId = '/jobs/{id}/quote_requests';

  static const String message = '/messages';

  static const String messageWithId = '/messages/{id}';

  static const String messageWithClientId = '/clients/{id}/messages';

  static const String messageWithTraderId = '/traders/{id}/messages';

  static const String messageWithJobId = '/jobs/{id}/messages';

  static const String booking = '/bookings';

  static const String bookingWithId = '/bookings/{id}';

  static const String bookingWithTraderId = '/traders/{id}/bookings';

  static const String bookingWithJobId = '/jobs/{id}/bookings';

  static const String changeRequest = '/change_requests';

  static const String changeRequestWithId = '/change_requests/{id}';

  static const String changeRequestWithTraderId = '/traders/{id}/change_requests';

  static const String changeRequestWithJobId = '/jobs/{id}/change_requests';

  static const String package = '/packages';

  static const String packageWithId = '/packages/{id}';

  static const String packageWithTraderId = '/traders/{id}/packages';

  static const String packageWithJobId = '/jobs/{id}/packages';

  static const String updates = '/updates';

  static const String updatesWithId = '/updates/{id}';

  static const String updatesWithJobId = '/jobs/{id}/updates';

  static const String requirement = '/requirements';

  static const String requirementWithId = '/requirements/{id}';

  static const String requirementWithJobId = '/jobs/{id}/requirements';

  static const String requirementWithPackageId = '/packages/{id}/requirements';

  static const String qualification = '/qualifications';

  static const String qualificationWithId = '/qualifications/{id}';

  static const String qualificationWithTraderId = '/traders/{id}/qualifications';

  static Dio getDioOptions() {

    Options _cacheOptions = buildCacheOptions(Duration(minutes: 30));
    final dio = Dio();   // Provide a dio instance
    //dio.options.headers["Authorization"] = 'Bearer ' + "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6IjZ5Sl81RW9zYWpkVzh1SFJSTVktZyJ9.eyJpc3MiOiJodHRwczovL2xvY2FsLXBlb3BsZS5ldS5hdXRoMC5jb20vIiwic3ViIjoiZ29vZ2xlLW9hdXRoMnwxMTQ5OTc5MTg3NDkxMTY3OTEzMzMiLCJhdWQiOlsiaHR0cHM6Ly9sb2NhbHBlb3BsZS1hcGkiLCJodHRwczovL2xvY2FsLXBlb3BsZS5ldS5hdXRoMC5jb20vdXNlcmluZm8iXSwiaWF0IjoxNjIyOTk0MTc4LCJleHAiOjE2MjMwODA1NzgsImF6cCI6IlBKb2tmRWxLaDQ0Y3QyQUZrSjBYeFZxdUh2dDVmdHcxIiwic2NvcGUiOiJvcGVuaWQgcHJvZmlsZSBlbWFpbCJ9.YmvKhcKlHQqHEj9b535zDnkWiXPX69BynnLqLdd-2sNTFxrPMHh6N-lHoO1FWBhGzzpqrVmpPSWJ4gimmml-Nad3sQcwjXTRRTmat1RD7opp6lCV2SvlV4264-THeIwHg847FOTWZBDZ0oHIs6GZeVxoQB_FjEhhwBTfkEXPOhC6YgLhzWaTR-AjRfa_e3O55A4ObcRpN00LrYxZG4EhRkC-BKlVEmYeFmusTfD72VI-obKSxXmMUNqwmUlQdj5IOUU8ugo6I4ERieOOuMYSj3PcGPK7-QFv7s2VQpeMbgtjoDLehpS6YetgHMIHb0zJUypun00X6wOW01wNmfogdg";
    //dio.options.headers["contentType"] = "application/json";
    //dio.options. = _cacheOptions;
    return dio;
  }

}