import '../models/location_model.dart';
import '../../domain/entities/location_response.dart';
import '../../domain/entities/location_list_response.dart';

abstract class LocationRemoteDataSource {
  Future<LocationListResponse> listJobLocations(int job_id);

  Future<LocationListResponse> listClientLocations(int client_id);

  Future<LocationListResponse> listTraderLocations(int trader_id);

  Future<LocationResponse> createLocation(LocationModel location);

  Future<LocationResponse> showLocation(int id);

  Future<LocationResponse> updateLocation(LocationModel location);

  Future<Exception> deleteLocation(int id);
}