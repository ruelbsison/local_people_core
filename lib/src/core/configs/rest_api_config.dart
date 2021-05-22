import 'package:meta/meta.dart';
import 'package:dio/dio.dart';

class RestAPIConfig {
  String get baseURL => 'http://7596eca62aa9.ngrok.io/api/v1/'; //'http://192.168.1.5:3001/api/v1/'; //'http://localhost:3001/api/v1/';

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

  static Dio getDioOptions() {
    final dio = Dio();   // Provide a dio instance
    //dio.options.headers["Authorization"] = "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6Ii0zMndiMC15aEQ1U2FyM01CTm82QyJ9.eyJpc3MiOiJodHRwczovL2NvbWJpbmVkb3RhaS5ldS5hdXRoMC5jb20vIiwic3ViIjoiVFNPY0MxaWZjdWdRejZOYXNjc29iZ3YxeVkxUXR0TFlAY2xpZW50cyIsImF1ZCI6Imh0dHBzOi8vbG9jYWxwZW9wbGUtYXBpIiwiaWF0IjoxNjE5NzcwMTc3LCJleHAiOjE2MTk4NTY1NzcsImF6cCI6IlRTT2NDMWlmY3VnUXo2TmFzY3NvYmd2MXlZMVF0dExZIiwiZ3R5IjoiY2xpZW50LWNyZWRlbnRpYWxzIn0.lk1We2ISICepnLwYMWZd-rA3e05A6cr_jd2LyTiZTzBIQWT82LJyEYArRKW_AsGxWnGBusjZQD_4_8IZIBBaGI09y5l1GNt6tkQWNsfE2F2ujSuIiuw9w8_jPquNHp_j1o6gG6AQmtEUffQ-C9xOaHYu4VM7Hc-AX09h5YXk1CtTgAj87IRjyC6yAvkTc6I59lRUGj5osJybvHUlX8oqh5uFz2uwrSh4E7621-eCYZB_sO5FNxHSZq-hlUuigIwkWO6G3EP8vl3ZUntve6doNjE8xgSiwBPwHZnsydfyfQmyquk613E-d-Aaw37KAw-Zs9Gc7G6y754Rq-AwyTi7YQ";
    //dio.options.headers["contentType"] = "application/json";

    return dio;
  }

}