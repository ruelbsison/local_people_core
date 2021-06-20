
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
        jobId: model.job_id,
        clientId: model.client_id,
        traderId: model.trader_id,
        lat: model.latitude,
        long: model.longitude,
      );

      locations.add(location);
    }
  }
}

