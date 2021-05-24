import '../models/updates_model.dart';

import '../../domain/entities/updates_list_response.dart';

import '../../domain/entities/updates_response.dart';

import 'updates_remote_data_source.dart';
import 'updates_rest_api_client.dart';
import 'package:meta/meta.dart';
import 'package:logging/logging.dart';

class UpdatesRemoteDataSourceImpl implements UpdatesRemoteDataSource {
  final logger = Logger("UpdatesRemoteDataSourceImpl");
  final UpdatesRestApiClient updatesRestApiClient;

  UpdatesRemoteDataSourceImpl({@required this.updatesRestApiClient})
      : assert(updatesRestApiClient != null);

  @override
  Future<UpdatesResponse> createUpdates(UpdatesModel model) async {
    UpdatesResponse response = UpdatesResponse();
    try {
      var paramData = model.toJson();
      paramData.keys
          .where((k) => paramData[k] == null) // filter keys
          .toList() // create a copy to avoid concurrent modifications
          .forEach(paramData.remove); // remove selected keys
      Map<String, Map<String, dynamic>> param = Map<String, Map<String, dynamic>>();
      param['update'] = paramData;
      UpdatesModel data = await updatesRestApiClient.createUpdates(param);
      if (data != null) {
        response.fromModel(data);
      }
    } catch (error, stacktrace) {
      logger.severe("Exception occured in createUpdates $error $stacktrace", error,
          stacktrace);
      response.exception = Exception(error.toString());
    }

    return response;
  }

  @override
  Future<Exception> deleteUpdates(int id) async {
    Exception response;
    try {
      await updatesRestApiClient.deleteUpdates(id);
    } catch (error, stacktrace) {
      logger.severe("Exception occured in deleteUpdates $error $stacktrace", error,
          stacktrace);
      response = Exception(error.toString());
    }

    return response;
  }

  @override
  Future<UpdatesListResponse> listJobUpdatess(int jobId) async {
    UpdatesListResponse response = UpdatesListResponse();
    try {
      List<UpdatesModel> data = await updatesRestApiClient.listJobUpdatess(jobId);
      if (data != null) {
        response.fromModel(data);
      }
    } catch (error, stacktrace) {
      logger.severe("Exception occured in listJobUpdatess $error $stacktrace", error,
          stacktrace);
      response.exception = Exception(error.toString());
    }

    return response;
  }

  @override
  Future<UpdatesResponse> showUpdates(int id) async {
    UpdatesResponse response = UpdatesResponse();
    try {
      UpdatesModel data = await updatesRestApiClient.showUpdates(id);
      if (data != null) {
        response.fromModel(data);
      }
    } catch (error, stacktrace) {
      logger.severe("Exception occured in listTraderUpdatess $error $stacktrace", error,
          stacktrace);
      response.exception = Exception(error.toString());
    }

    return response;
  }

  @override
  Future<UpdatesResponse> updateUpdates(UpdatesModel model) async {
    UpdatesResponse response = UpdatesResponse();
    try {
      var paramData = model.toJson();
      paramData.keys
          .where((k) => paramData[k] == null) // filter keys
          .toList() // create a copy to avoid concurrent modifications
          .forEach(paramData.remove); // remove selected keys
      Map<String, Map<String, dynamic>> param = Map<String, Map<String, dynamic>>();
      param['Updates'] = paramData;
      UpdatesModel data = await updatesRestApiClient.updateUpdates(model.id, param);
      if (data != null) {
        response.fromModel(data);
      }
    } catch (error, stacktrace) {
      logger.severe("Exception occured in updateUpdates $error $stacktrace", error,
          stacktrace);
      response.exception = Exception(error.toString());
    }

    return response;
  }

}
