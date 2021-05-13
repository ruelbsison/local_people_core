import 'package:local_people_core/src/profile/data/models/trader_model.dart';
import 'package:local_people_core/src/profile/domain/entities/trader_list_response.dart';
import 'package:local_people_core/src/profile/domain/entities/trader_response.dart';
import 'package:meta/meta.dart';
import 'package:logging/logging.dart';

import '../../../../core.dart';
import 'trader_rest_api_client.dart';
import 'trader_remote_data_source.dart';

class TraderRemoteDataSourceImpl implements TraderRemoteDataSource {
  final logger = Logger("TraderRemoteDataSourceImpl");
  final String baseUrl;
  TraderRestApiClient traderRestApiClient;

  TraderRemoteDataSourceImpl({@required this.baseUrl})
      : assert(baseUrl != null) {
    traderRestApiClient =
        TraderRestApiClient(RestAPIConfig.getDioOptions(), baseUrl: baseUrl);
  }

  @override
  Future<TraderResponse> createTrader(TraderModel Trader) async {
    TraderResponse response;

    try {
      TraderModel data =
      await traderRestApiClient.createTrader(Trader.id, Trader);
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
    TraderResponse response;

    try {
      TraderModel data =
      await traderRestApiClient.findTraderWithEmail(email_address);
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
    TraderListResponse response;

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
    TraderResponse response;

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
  Future<TraderResponse> updateTrader(TraderModel Trader) async {
    TraderResponse response;

    try {
      TraderModel data =
      await traderRestApiClient.updateTrader(Trader.id, Trader);
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
}
