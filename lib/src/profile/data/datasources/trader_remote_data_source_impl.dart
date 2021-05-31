import '../models/trader_model.dart';
import '../../domain/entities/trader_list_response.dart';
import '../../domain/entities/trader_response.dart';
import 'package:meta/meta.dart';
import 'package:dio/dio.dart';
import 'package:logging/logging.dart';

import '../../../../core.dart';
import 'trader_rest_api_client.dart';
import 'trader_remote_data_source.dart';

class TraderRemoteDataSourceImpl implements TraderRemoteDataSource {
  final logger = Logger("TraderRemoteDataSourceImpl");
  final TraderRestApiClient traderRestApiClient;

  TraderRemoteDataSourceImpl({@required this.traderRestApiClient})
      : assert(traderRestApiClient != null);

  @override
  Future<TraderResponse> createTrader(TraderModel model) async {
    TraderResponse response = TraderResponse();

    try {
      var paramData = model.toJson();
      paramData.keys
          .where((k) => paramData[k] == null) // filter keys
          .toList() // create a copy to avoid concurrent modifications
          .forEach(paramData.remove); // remove selected keys
      Map<String, Map<String, dynamic>> param = Map<String, Map<String, dynamic>>();
      param['trader'] = paramData;
      TraderModel data =
      await traderRestApiClient.createTrader(param);
      if (data != null) {
        response.fromModel(data);
      }
    } catch (error, stacktrace) {
      logger.severe("Exception occured in createTrader $error $stacktrace",
          error, stacktrace);
      response.exception = ServerException.withError(error: error);
    }

    return response;
  }

  @override
  Future<ServerException> deleteTrader(int id) async {
    ServerException exception;

    try {
      await traderRestApiClient.deleteTrader(id);
    } catch (error, stacktrace) {
      logger.severe("Exception occured in deleteTrader $error $stacktrace",
          error, stacktrace);
      exception = ServerException.withError(error: error);
    }

    return exception;
  }

  @override
  Future<TraderResponse> findTraderWithEmail(String email_address) async {
    TraderResponse response = TraderResponse();

    try {
      TraderModel data =
      await traderRestApiClient.findTraderWithEmail(Uri.encodeQueryComponent(email_address));
      if (data != null) {
        response.fromModel(data);
      }
    } catch (error, stacktrace) {
      logger.severe(
          "Exception occured in findTraderWithEmail $error $stacktrace",
          error,
          stacktrace);
      response.exception = ServerException.withError(error: error);
    }

    return response;
  }

  @override
  Future<TraderListResponse> listTraders() async {
    TraderListResponse response = TraderListResponse();

    try {
      List<TraderModel> data = await traderRestApiClient.listTraders();
      if (data != null) {
        response.fromModel(data);
      }
    } catch (error, stacktrace) {
      logger.severe("Exception occured in listTraders $error $stacktrace",
          error, stacktrace);
      response.exception = ServerException.withError(error: error);
    }

    return response;
  }

  @override
  Future<TraderResponse> showTrader(int id) async {
    TraderResponse response = TraderResponse();

    try {
      TraderModel data = await traderRestApiClient.showTrader(id);
      if (data != null) {
        response.fromModel(data);
      }
    } catch (error, stacktrace) {
      logger.severe("Exception occured in showTrader $error $stacktrace", error,
          stacktrace);
      response.exception = ServerException.withError(error: error);
    }

    return response;
  }

  @override
  Future<TraderResponse> updateTrader(TraderModel model) async {
    TraderResponse response = TraderResponse();

    try {
      var paramData = model.toJson();
      paramData.keys
          .where((k) => paramData[k] == null) // filter keys
          .toList() // create a copy to avoid concurrent modifications
          .forEach(paramData.remove); // remove selected keys
      Map<String, Map<String, dynamic>> param = Map<String, Map<String, dynamic>>();
      param['trader'] = paramData;
      TraderModel data =
      await traderRestApiClient.updateTrader(model.id, param);
      if (data != null) {
        response.fromModel(data);
      }
    } catch (error, stacktrace) {
      logger.severe("Exception occured in updateTrader $error $stacktrace",
          error, stacktrace);
      response.exception = ServerException.withError(error: error);
    }

    return response;
  }

  @override
  Future<TraderListResponse> listTopRatedTraders() async {
    TraderListResponse response = TraderListResponse();

    try {
      List<TraderModel> data = await traderRestApiClient.listTopRatedTraders();
      if (data != null) {
        response.fromModel(data);
      }
    } catch (error, stacktrace) {
      logger.severe("Exception occured in listTopRatedTraders $error $stacktrace",
          error, stacktrace);
      response.exception = ServerException.withError(error: error);
    }

    return response;
  }
}
