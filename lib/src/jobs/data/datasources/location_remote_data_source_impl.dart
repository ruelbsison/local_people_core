import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:logging/logging.dart';
import '../models/location_model.dart';
import 'location_rest_api_client.dart';
import 'location_remote_data_source.dart';
import '../../../../core.dart';

class LocationRemoteDataSourceImpl implements LocationRemoteDataSource {
  final logger = Logger("TraderRemoteDataSourceImpl");
  final String baseUrl;
  LocationRestApiClient locationRestApiClient;

  LocationRemoteDataSourceImpl(
      @required this.baseUrl
      )  : assert(baseUrl != null) {
    locationRestApiClient = LocationRestApiClient(RestAPIConfig.getDioOptions(),
        baseUrl: baseUrl);
  }

  @override
  Future<List<LocationModel>> listLocations() async {
    List<LocationModel> result;
    try {
      result = await locationRestApiClient.listLocations();
    } catch (error, stacktrace) {
      logger.severe("Exception occured in listLocations", error, stacktrace);
      throw ServerException.withError(error: error);
    }

    return result;
  }

  @override
  Future<List<LocationModel>> listJobLocations(int job_id) async {
    List<LocationModel> data;
    try {
      data = await locationRestApiClient.listJobLocations(job_id);
    } catch (error, stacktrace) {
      logger.severe("Exception occured in listJobLocations", error, stacktrace);
      throw ServerException.withError(error: error);
    }

    return data;
  }

  @override
  Future<LocationModel> createLocation(LocationModel location) async {
    LocationModel ressult;
    try {
      ressult = await locationRestApiClient.createLocation(location);
    } catch (error, stacktrace) {
      logger.severe("Exception occured in createLocation", error, stacktrace);
      throw ServerException.withError(error: error);
    }

    return ressult;
  }

  @override
  Future<void> deleteLocation(int id) async {
    try {
      await locationRestApiClient.deleteLocation(id);
    } catch (error, stacktrace) {
      logger.severe("Exception occured in deleteLocation", error, stacktrace);
      throw ServerException.withError(error: error);
    }
  }

  @override
  Future<LocationModel> showLocation(int id) async {
    LocationModel ressult;
    try {
      ressult = await locationRestApiClient.showLocation(id);
    } catch (error, stacktrace) {
      logger.severe("Exception occured in showLocation", error, stacktrace);
      throw ServerException.withError(error: error);
    }

    return ressult;
  }

  @override
  Future<LocationModel> updateLocation(LocationModel job) async {
    LocationModel ressult;
    try {
      ressult = await locationRestApiClient.updateLocation(job.id, job);
    } catch (error, stacktrace) {
      logger.severe("Exception occured in updateLocation", error, stacktrace);
      throw ServerException.withError(error: error);
    }

    return ressult;
  }

}