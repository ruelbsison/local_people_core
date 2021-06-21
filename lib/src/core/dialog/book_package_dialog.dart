import 'package:flutter/widgets.dart';
import 'package:local_people_core/jobs.dart';

class BookPackageRequest {
  final Package package;
  final String traderName;

  BookPackageRequest({
    @required this.package,
    @required this.traderName,
  });
}

class BookPackageResponse {
  Booking booking;
  BookPackageResponse({
    this.booking,
  });
}