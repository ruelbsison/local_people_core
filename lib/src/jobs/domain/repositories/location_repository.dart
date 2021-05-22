
import '../entities/location.dart';
import '../entities/location_response.dart';
import '../entities/location_list_response.dart';

abstract class LocationRepository {
  Future<LocationListResponse> listClientLocations(int client_id);

  Future<LocationListResponse> listTraderLocations(int trader_id);

  Future<LocationListResponse> listJobLocations(int job_id);

  Future<LocationResponse> createLocation(Location location);

  Future<LocationResponse> showLocation(int id);

  Future<LocationResponse> updateLocation(Location location);

  Future<Exception> deleteLocation(int id);
}