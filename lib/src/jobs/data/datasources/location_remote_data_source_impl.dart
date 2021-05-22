import 'package:dio/dio.dart';
import 'package:local_people_core/src/jobs/domain/entities/location_list_response.dart';
import 'package:local_people_core/src/jobs/domain/entities/location_response.dart';
import 'package:meta/meta.dart';
import 'package:logging/logging.dart';
import '../models/location_model.dart';
import 'location_rest_api_client.dart';
import 'location_remote_data_source.dart';
import '../../../../core.dart';

class LocationRemoteDataSourceImpl implements LocationRemoteDataSource {
  final logger = Logger("LocationRemoteDataSourceImpl");
  final LocationRestApiClient locationRestApiClient;

  LocationRemoteDataSourceImpl({@required this.locationRestApiClient})
      : assert(locationRestApiClient != null);

  @override
  Future<LocationResponse> createLocation(LocationModel location) async {
    LocationResponse reponse = LocationResponse();

    try {
      LocationModel data = await locationRestApiClient.createLocation(location);
      if (data != null) {
        reponse.fromModel(data);
      }
    } catch (error, stacktrace) {
      logger.severe(
          "Exception occured in createLocation $error $stacktrace", error, stacktrace);
      reponse.exception = Exception(error.toString());
    }

    return reponse;
  }

  @override
  Future<Exception> deleteLocation(int id) async {
    Exception reponse;

    try {
      await locationRestApiClient.deleteLocation(id);
    } catch (error, stacktrace) {
      logger.severe(
          "Exception occured in createLocation $error $stacktrace", error, stacktrace);
      reponse = Exception(error.toString());
    }

    return reponse;
  }

  @override
  Future<LocationListResponse> listJobLocations(int job_id) async {
    LocationListResponse reponse = LocationListResponse();

    try {
      List<LocationModel> data = await locationRestApiClient.listJobLocations(job_id);
      if (data != null) {
        reponse.fromModel(data);
      }
    } catch (error, stacktrace) {
      logger.severe(
          "Exception occured in listJobLocations $error $stacktrace", error, stacktrace);
      reponse.exception = Exception(error.toString());
    }

    return reponse;
  }

  @override
  Future<LocationResponse> showLocation(int id) async {
    LocationResponse reponse = LocationResponse();

    try {
      LocationModel data = await locationRestApiClient.showLocation(id);
      if (data != null) {
        reponse.fromModel(data);
      }
    } catch (error, stacktrace) {
      logger.severe(
          "Exception occured in showLocation $error $stacktrace", error, stacktrace);
      reponse.exception = Exception(error.toString());
    }

    return reponse;
  }

  @override
  Future<LocationResponse> updateLocation(LocationModel location) async {
    LocationResponse reponse = LocationResponse();

    try {
      LocationModel data = await locationRestApiClient.updateLocation(location.id, location);
      if (data != null) {
        reponse.fromModel(data);
      }
    } catch (error, stacktrace) {
      logger.severe(
          "Exception occured in updateLocation $error $stacktrace", error, stacktrace);
      reponse.exception = Exception(error.toString());
    }

    return reponse;
  }

  @override
  Future<LocationListResponse> listClientLocations(int client_id) async {
    LocationListResponse reponse = LocationListResponse();

    try {
      List<LocationModel> data = await locationRestApiClient.listClientLocations(client_id);
      if (data != null) {
        reponse.fromModel(data);
      }
    } catch (error, stacktrace) {
      logger.severe(
          "Exception occured in listClientLocations $error $stacktrace", error, stacktrace);
      reponse.exception = Exception(error.toString());
    }

    return reponse;
  }

  @override
  Future<LocationListResponse> listTraderLocations(int trader_id) async {
    LocationListResponse reponse = LocationListResponse();

    try {
      List<LocationModel> data = await locationRestApiClient.listTraderLocations(trader_id);
      if (data != null) {
        reponse.fromModel(data);
      }
    } catch (error, stacktrace) {
      logger.severe(
          "Exception occured in listTraderLocations $error $stacktrace", error, stacktrace);
      reponse.exception = Exception(error.toString());
    }

    return reponse;
  }

  

}