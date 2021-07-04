import '../models/change_request_model.dart';

import '../../domain/entities/change_request_list_response.dart';

import '../../domain/entities/change_request_response.dart';

import 'change_request_remote_data_source.dart';
import 'change_request_rest_api_client.dart';
import 'package:meta/meta.dart';
import 'package:logging/logging.dart';

class ChangeRequestRemoteDataSourceImpl implements ChangeRequestRemoteDataSource {
  final logger = Logger("ChangeRequestRemoteDataSourceImpl");
  final ChangeRequestRestApiClient changeRequestRestApiClient;

  ChangeRequestRemoteDataSourceImpl({@required this.changeRequestRestApiClient})
      : assert(changeRequestRestApiClient != null);

  @override
  Future<ChangeRequestResponse> createChangeRequest(ChangeRequestModel model) async {
    ChangeRequestResponse response = ChangeRequestResponse();
    try {
      var paramData = model.toJson();
      paramData.keys
          .where((k) => paramData[k] == null) // filter keys
          .toList() // create a copy to avoid concurrent modifications
          .forEach(paramData.remove); // remove selected keys
      Map<String, Map<String, dynamic>> param = Map<String, Map<String, dynamic>>();
      param['change_request'] = paramData;
      ChangeRequestModel data = await changeRequestRestApiClient.createChangeRequest(param);
      if (data != null) {
        response.fromModel(data);
      }
    } catch (error, stacktrace) {
      logger.severe("Exception occured in createChangeRequest $error $stacktrace", error,
          stacktrace);
      response.exception = Exception(error.toString());
    }

    return response;
  }

  @override
  Future<Exception> deleteChangeRequest(int id) async {
    Exception response;
    try {
      await changeRequestRestApiClient.deleteChangeRequest(id);
    } catch (error, stacktrace) {
      logger.severe("Exception occured in deleteChangeRequest $error $stacktrace", error,
          stacktrace);
      response = Exception(error.toString());
    }

    return response;
  }

  @override
  Future<ChangeRequestListResponse> listJobChangeRequests(int jobId) async {
    ChangeRequestListResponse response = ChangeRequestListResponse();
    try {
      List<ChangeRequestModel> data = await changeRequestRestApiClient.listJobChangeRequests(jobId);
      if (data != null) {
        response.fromModel(data);
      }
    } catch (error, stacktrace) {
      logger.severe("Exception occured in listJobChangeRequests $error $stacktrace", error,
          stacktrace);
      response.exception = Exception(error.toString());
    }

    return response;
  }

  @override
  Future<ChangeRequestListResponse> listTraderChangeRequests(int traderId) async {
    ChangeRequestListResponse response = ChangeRequestListResponse();
    try {
      List<ChangeRequestModel> data = await changeRequestRestApiClient.listTraderChangeRequests(traderId);
      if (data != null) {
        response.fromModel(data);
      }
    } catch (error, stacktrace) {
      logger.severe("Exception occured in listTraderChangeRequests $error $stacktrace", error,
          stacktrace);
      response.exception = Exception(error.toString());
    }
    return response;
  }

  @override
  Future<ChangeRequestResponse> showChangeRequest(int id) async {
    ChangeRequestResponse response = ChangeRequestResponse();
    try {
      ChangeRequestModel data = await changeRequestRestApiClient.showChangeRequest(id);
      if (data != null) {
        response.fromModel(data);
      }
    } catch (error, stacktrace) {
      logger.severe("Exception occured in listTraderChangeRequests $error $stacktrace", error,
          stacktrace);
      response.exception = Exception(error.toString());
    }

    return response;
  }

  @override
  Future<ChangeRequestResponse> updateChangeRequest(ChangeRequestModel model) async {
    ChangeRequestResponse response = ChangeRequestResponse();
    try {
      var paramData = model.toJson();
      paramData.keys
          .where((k) => paramData[k] == null) // filter keys
          .toList() // create a copy to avoid concurrent modifications
          .forEach(paramData.remove); // remove selected keys
      Map<String, Map<String, dynamic>> param = Map<String, Map<String, dynamic>>();
      param['change_request'] = paramData;
      ChangeRequestModel data = await changeRequestRestApiClient.updateChangeRequest(model.id, param);
      if (data != null) {
        response.fromModel(data);
      }
    } catch (error, stacktrace) {
      logger.severe("Exception occured in updateChangeRequest $error $stacktrace", error,
          stacktrace);
      response.exception = Exception(error.toString());
    }

    return response;
  }

}
