import '../../domain/entities/change_request.dart';
import '../models/change_request_model.dart';
import '../../domain/entities/change_request_list_response.dart';

import '../../domain/entities/change_request_response.dart';
import '../../domain/repositories/change_request_repository.dart';
import '../datasources/change_request_remote_data_source.dart';
import 'package:meta/meta.dart';
import 'package:logging/logging.dart';
import 'package:local_people_core/core.dart';

class ChangeRequestRepositoryImpl extends ChangeRequestRepository {
  final logger = Logger("ChangeRequestRepositoryImpl");
  final NetworkInfo networkInfo;
  final ChangeRequestRemoteDataSource changeRequestRemoteDataSource;

  ChangeRequestRepositoryImpl({
    @required this.networkInfo,
    @required this.changeRequestRemoteDataSource
  }) : assert(networkInfo != null), assert(changeRequestRemoteDataSource != null);

  @override
  Future<ChangeRequestResponse> createChangeRequest(ChangeRequest ChangeRequest) async {
    ChangeRequestResponse response = ChangeRequestResponse();
    if (await networkInfo.isConnected) {
      try {
        ChangeRequestModel model = ChangeRequestResponse.fromChangeRequest(ChangeRequest);
        response = await changeRequestRemoteDataSource.createChangeRequest(model);
        if (response.exception != null) {
          logger.severe("Exception occured in createChangeRequest", response.exception);
        }
      } catch (error, stacktrace) {
        logger.severe("Exception occured in createChangeRequest", error, stacktrace);
        response.exception = Exception(error.toString());
      }
    } else {
      response.exception = InternetConnectionException();
    }

    return response;
  }

  @override
  Future<Exception> deleteChangeRequest(int id) async {
    Exception exception;
    if (await networkInfo.isConnected) {
      try {
        await changeRequestRemoteDataSource.deleteChangeRequest(id);
      } catch (error, stacktrace) {
        logger.severe("Exception occured in deleteChangeRequest", error, stacktrace);
        exception = Exception(error.toString());
      }
    } else {
      exception = InternetConnectionException();
    }

    return exception;
  }

  @override
  Future<ChangeRequestListResponse> listJobChangeRequests(int job_id) async {
    ChangeRequestListResponse response = ChangeRequestListResponse();
    if (await networkInfo.isConnected) {
      try {
        response = await changeRequestRemoteDataSource.listJobChangeRequests(job_id);
        if (response.exception != null) {
          logger.severe("Exception occured in listJobChangeRequests", response.exception);
        }
      } catch (error, stacktrace) {
        logger.severe("Exception occured in listJobChangeRequests", error, stacktrace);
        response.exception = Exception(error.toString());
      }
    } else {
      response.exception = InternetConnectionException();
    }

    return response;
  }

  @override
  Future<ChangeRequestListResponse> listTraderChangeRequests(int trader_id) async {
    ChangeRequestListResponse response = ChangeRequestListResponse();
    if (await networkInfo.isConnected) {
      try {
        response = await changeRequestRemoteDataSource.listTraderChangeRequests(trader_id);
        if (response.exception != null) {
          logger.severe("Exception occured in listTraderChangeRequests", response.exception);
        }
      } catch (error, stacktrace) {
        logger.severe("Exception occured in listTraderChangeRequests", error, stacktrace);
        response.exception = Exception(error.toString());
      }
    } else {
      response.exception = InternetConnectionException();
    }

    return response;
  }

  @override
  Future<ChangeRequestResponse> showChangeRequest(int id) async {
    ChangeRequestResponse response = ChangeRequestResponse();
    if (await networkInfo.isConnected) {
      try {
        response = await changeRequestRemoteDataSource.showChangeRequest(id);
        if (response.exception != null) {
          logger.severe("Exception occured in showChangeRequest", response.exception);
        }
      } catch (error, stacktrace) {
        logger.severe("Exception occured in showChangeRequest", error, stacktrace);
        response.exception = Exception(error.toString());
      }
    } else {
      response.exception = InternetConnectionException();
    }

    return response;
  }

  @override
  Future<ChangeRequestResponse> updateChangeRequest(ChangeRequest ChangeRequest) async {
    ChangeRequestResponse response = ChangeRequestResponse();
    if (await networkInfo.isConnected) {
      try {
        ChangeRequestModel model = ChangeRequestResponse.fromChangeRequest(ChangeRequest);
        response = await changeRequestRemoteDataSource.updateChangeRequest(model);
        if (response.exception != null) {
          logger.severe("Exception occured in updateChangeRequest", response.exception);
        }
      } catch (error, stacktrace) {
        logger.severe("Exception occured in updateChangeRequest", error, stacktrace);
        response.exception = Exception(error.toString());
      }
    } else {
      response.exception = InternetConnectionException();
    }

    return response;
  }

}