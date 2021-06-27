import 'package:flutter/widgets.dart';
import 'package:local_people_core/jobs.dart';
import 'package:local_people_core/quote.dart';

class PlaceBidRequest {
  final Job job;
  final int traderId;

  PlaceBidRequest({
    @required this.job,
    @required this.traderId,
  });
}

class PlaceBidResponse {
  Quote quote;
  PlaceBidResponse({
    this.quote,
  });
}