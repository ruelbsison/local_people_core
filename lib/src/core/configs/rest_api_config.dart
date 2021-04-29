import 'package:meta/meta.dart';
import 'package:dio/dio.dart';

class RestAPIConfig {
  String get baseURL => 'http://localhost:3001/api/v1/';

  static const String client = '/clients';

  static const String clientWithId = '/clients/{id}';

  static const String trader = '/traders';

  static const String traderWithId = '/traders/{id}';

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


  static Dio getDioOptions() {
    final dio = Dio();   // Provide a dio instance
    dio.options.headers["Authorization"] = "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6Ii0zMndiMC15aEQ1U2FyM01CTm82QyJ9.eyJpc3MiOiJodHRwczovL2NvbWJpbmVkb3RhaS5ldS5hdXRoMC5jb20vIiwic3ViIjoiVFNPY0MxaWZjdWdRejZOYXNjc29iZ3YxeVkxUXR0TFlAY2xpZW50cyIsImF1ZCI6Imh0dHBzOi8vbG9jYWxwZW9wbGUtYXBpIiwiaWF0IjoxNjE5NjAxMjI3LCJleHAiOjE2MTk2ODc2MjcsImF6cCI6IlRTT2NDMWlmY3VnUXo2TmFzY3NvYmd2MXlZMVF0dExZIiwiZ3R5IjoiY2xpZW50LWNyZWRlbnRpYWxzIn0.manzGsWV0Pvm2qqgArEZGEJG3R9IQOf8rVxMTtX_3CE82X15UYsElMtA2k9k4VoydPx4tG1gj8trA0EDVFW9mCbztndSfhbe0BE0-7CLWOfkb3dXYEYMEQ5KJOaeXhkxqINqcSteCYqu4ez6a7cLxs4_Z-jAwifYiF2f1v-y_lGjQazURvoWr7Rguwr43iLkbbIUIrl8IZP4ZiBN4PHukaYh272XZGt2HK1JFBL7KKTUoR_D_l5_uMJkQ-I50uL6v2OL7nw_buS5zS6I2XgNyIB1i5BpbuhF7r5qrZWozLW1-1-ziWldwh4iFiLlfMXLkgpJj-1cM8TdbPas9FMlRg";
    dio.options.headers["contentType"] = "application/json";

    return dio;
  }

}