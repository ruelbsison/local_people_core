import '../../domain/entities/updates.dart';
import '../models/updates_model.dart';
import '../../domain/entities/updates_list_response.dart';

import '../../domain/entities/updates_response.dart';
import '../../domain/repositories/updates_repository.dart';
import '../datasources/updates_remote_data_source.dart';
import 'package:meta/meta.dart';
import 'package:logging/logging.dart';
import 'package:local_people_core/core.dart';

class UpdatesRepositoryImpl extends UpdatesRepository {
  final logger = Logger("UpdatesRepositoryImpl");
  final NetworkInfo networkInfo;
  final UpdatesRemoteDataSource updatesRemoteDataSource;

  UpdatesRepositoryImpl({
    @required this.networkInfo,
    @required this.updatesRemoteDataSource
  }) : assert(networkInfo != null), assert(updatesRemoteDataSource != null);

  @override
  Future<UpdatesResponse> createUpdates(Updates Updates) async {
    UpdatesResponse response = UpdatesResponse();
    if (await networkInfo.isConnected) {
      try {
        UpdatesModel model = UpdatesResponse.fromUpdates(Updates);
        response = await updatesRemoteDataSource.createUpdates(model);
        if (response.exception != null) {
          logger.severe("Exception occured in createUpdates", response.exception);
        }
      } catch (error, stacktrace) {
        logger.severe("Exception occured in createUpdates", error, stacktrace);
        response.exception = Exception(error.toString());
      }
    } else {
      response.exception = InternetConnectionException();
    }

    return response;
  }

  @override
  Future<Exception> deleteUpdates(int id) async {
    Exception exception;
    if (await networkInfo.isConnected) {
      try {
        await updatesRemoteDataSource.deleteUpdates(id);
      } catch (error, stacktrace) {
        logger.severe("Exception occured in deleteUpdates", error, stacktrace);
        exception = Exception(error.toString());
      }
    } else {
      exception = InternetConnectionException();
    }

    return exception;
  }

  @override
  Future<UpdatesListResponse> listJobUpdatess(int job_id) async {
    UpdatesListResponse response = UpdatesListResponse();
    if (await networkInfo.isConnected) {
      try {
        response = await updatesRemoteDataSource.listJobUpdatess(job_id);
        if (response.exception != null) {
          logger.severe("Exception occured in listJobUpdatess", response.exception);
        }
      } catch (error, stacktrace) {
        logger.severe("Exception occured in listJobUpdatess", error, stacktrace);
        response.exception = Exception(error.toString());
      }
    } else {
      response.exception = InternetConnectionException();
    }

    return response;
  }

  @override
  Future<UpdatesResponse> showUpdates(int id) async {
    UpdatesResponse response = UpdatesResponse();
    if (await networkInfo.isConnected) {
      try {
        response = await updatesRemoteDataSource.showUpdates(id);
        if (response.exception != null) {
          logger.severe("Exception occured in showUpdates", response.exception);
        }
      } catch (error, stacktrace) {
        logger.severe("Exception occured in showUpdates", error, stacktrace);
        response.exception = Exception(error.toString());
      }
    } else {
      response.exception = InternetConnectionException();
    }

    return response;
  }

  @override
  Future<UpdatesResponse> updateUpdates(Updates Updates) async {
    UpdatesResponse response = UpdatesResponse();
    if (await networkInfo.isConnected) {
      try {
        UpdatesModel model = UpdatesResponse.fromUpdates(Updates);
        response = await updatesRemoteDataSource.updateUpdates(model);
        if (response.exception != null) {
          logger.severe("Exception occured in updateUpdates", response.exception);
        }
      } catch (error, stacktrace) {
        logger.severe("Exception occured in updateUpdates", error, stacktrace);
        response.exception = Exception(error.toString());
      }
    } else {
      response.exception = InternetConnectionException();
    }

    return response;
  }

}