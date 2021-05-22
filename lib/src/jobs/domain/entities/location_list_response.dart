
import '../../data/models/location_model.dart';
import 'location.dart';

class LocationListResponse {
  Exception exception;
  List<Location> locations;

  void fromModel(List<LocationModel> list) {
    locations = List<Location>();

    var listIter = list.iterator;
    while(listIter.moveNext() ) {
      LocationModel model = listIter.current;
      Location location = Location(
        id: model.id,
        name: model.name,
        address: model.address,
        lat: model.latitude.toDouble(),
        long: model.longitude.toDouble(),
        jobId: model.job_id,
      );

      locations.add(location);
    }
  }
}

