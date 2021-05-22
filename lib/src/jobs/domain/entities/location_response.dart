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
      lat: model.latitude.toDouble(),
      long: model.longitude.toDouble(),
      jobId: model.job_id,
      );
  }
}