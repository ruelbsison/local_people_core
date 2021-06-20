import '../../domain/entities/location.dart';
import '../models/location_model.dart';
import '../../domain/entities/location_list_response.dart';

import '../../domain/entities/location_response.dart';

import '../../domain/repositories/location_repository.dart';
import '../datasources/location_remote_data_source.dart';
import 'package:meta/meta.dart';
import 'package:logging/logging.dart';
import 'package:local_people_core/core.dart';

class LocationRepositoryImpl implements LocationRepository {
  final logger = Logger("LocationRepositoryImpl");
  final NetworkInfo networkInfo;
  final LocationRemoteDataSource locationRemoteDataSource;

  LocationRepositoryImpl(
      {@required this.networkInfo, @required this.locationRemoteDataSource})
      : assert(networkInfo != null),
        assert(locationRemoteDataSource != null);

  @override
  Future<LocationResponse> createLocation(Location location) async {
    LocationResponse response = LocationResponse();
    if (await networkInfo.isConnected) {
      try {
        LocationModel model = LocationModel.fromLocation(location);
        response = await locationRemoteDataSource.createLocation(model);
        if (response != null && response.exception != null) {
          logger.severe(
              "Exception occured in createLocation", response.exception);
        }
      } catch (error, stacktrace) {
        logger.severe("Exception occured in createLocation", error, stacktrace);
        response.exception = Exception(error.toString());
      }
    } else {
      response.exception = InternetConnectionException();
    }

    return response;
  }

  @override
  Future<Exception> deleteLocation(int id) async {
    Exception response;
    if (await networkInfo.isConnected) {
      try {
        await locationRemoteDataSource.deleteLocation(id);
      } catch (error, stacktrace) {
        logger.severe("Exception occured in deleteLocation", error, stacktrace);
        response = Exception(error.toString());
      }
    } else {
      response = InternetConnectionException();
    }

    return response;
  }

  @override
  Future<LocationResponse> listJobLocations(int job_id) async {
    LocationResponse response = LocationResponse();
    if (await networkInfo.isConnected) {
      try {
        response = await locationRemoteDataSource.listJobLocations(job_id);
        if (response != null && response.exception != null) {
          logger.severe(
              "Exception occured in listJobLocations", response.exception);
        }
      } catch (error, stacktrace) {
        logger.severe(
            "Exception occured in listJobLocations", error, stacktrace);
        response.exception = Exception(error.toString());
      }
    } else {
      response.exception = InternetConnectionException();
    }

    return response;
  }

  @override
  Future<LocationListResponse> listTraderLocations(int trader_id) async {
    LocationListResponse response = LocationListResponse();
    if (await networkInfo.isConnected) {
      try {
        response =
            await locationRemoteDataSource.listTraderLocations(trader_id);
        if (response != null && response.exception != null) {
          logger.severe(
              "Exception occured in listTraderLocations", response.exception);
        }
      } catch (error, stacktrace) {
        logger.severe(
            "Exception occured in listTraderLocations", error, stacktrace);
        response.exception = Exception(error.toString());
      }
    } else {
      response.exception = InternetConnectionException();
    }

    return response;
  }

  @override
  Future<LocationResponse> showLocation(int id) async {
    LocationResponse response = LocationResponse();
    if (await networkInfo.isConnected) {
      try {
        response = await locationRemoteDataSource.showLocation(id);
        if (response != null && response.exception != null) {
          logger.severe(
              "Exception occured in showLocation", response.exception);
        }
      } catch (error, stacktrace) {
        logger.severe("Exception occured in showLocation", error, stacktrace);
        response.exception = Exception(error.toString());
      }
    } else {
      response.exception = InternetConnectionException();
    }

    return response;
  }

  @override
  Future<LocationResponse> updateLocation(Location location) async {
    LocationResponse response = LocationResponse();
    if (await networkInfo.isConnected) {
      try {
        LocationModel model = LocationModel.fromLocation(location);
        response = await locationRemoteDataSource.updateLocation(model);
        if (response != null && response.exception != null) {
          logger.severe(
              "Exception occured in updateLocation", response.exception);
        }
      } catch (error, stacktrace) {
        logger.severe("Exception occured in updateLocation", error, stacktrace);
        response.exception = Exception(error.toString());
      }
    } else {
      response.exception = InternetConnectionException();
    }

    return response;
  }

  @override
  Future<LocationListResponse> listClientLocations(int client_id) async {
    LocationListResponse response = LocationListResponse();
    if (await networkInfo.isConnected) {
      try {
        response =
            await locationRemoteDataSource.listClientLocations(client_id);
        if (response != null && response.exception != null) {
          logger.severe(
              "Exception occured in listClientLocations", response.exception);
        }
      } catch (error, stacktrace) {
        logger.severe(
            "Exception occured in listClientLocations", error, stacktrace);
        response.exception = Exception(error.toString());
      }
    } else {
      response.exception = InternetConnectionException();
    }

    return response;
  }
}
