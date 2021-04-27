import 'dart:io';
import '../models/location_model.dart';

abstract class LocationRemoteDataSource {
  Future<List<LocationModel>> listLocations();

  Future<List<LocationModel>> listJobLocations(int job_id);

  Future<LocationModel> createLocation(LocationModel job);

  Future<LocationModel> showLocation(int id);

  Future<LocationModel> updateLocation(LocationModel job);

  Future<void> deleteLocation(int id);
}