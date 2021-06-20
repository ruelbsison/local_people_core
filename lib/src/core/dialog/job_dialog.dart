import 'package:flutter/widgets.dart';
//import 'package:local_people_core/core.dart';
import 'package:local_people_core/jobs.dart';

class JobAwardRequest {
  final int traderId;
  final String packageName;

  JobAwardRequest({
    @required this.traderId,
    @required this.packageName,
  });
}

class PackageCreateResponse {
  Package package;

  PackageCreateResponse({
    this.package,
  });
}