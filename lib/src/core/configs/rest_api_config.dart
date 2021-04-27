import 'package:meta/meta.dart';

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

}