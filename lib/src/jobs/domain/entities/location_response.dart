import 'location.dart';
import '../../data/models/location_model.dart';

class LocationResponse {
  Exception exception;
  Location location;

  void fromModel(LocationModel model) {
    location = Location(
      id: model.id,
      name: model.name,
      address: model.address,
      jobId: model.job_id,
      clientId: model.client_id,
      traderId: model.trader_id,
      );
  }
}