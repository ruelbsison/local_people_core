import 'package:local_people_core/src/quote/data/models/quote_request_model.dart';

import 'package:local_people_core/src/quote/domain/entities/quote_request_list_response.dart';

import 'package:local_people_core/src/quote/domain/entities/quote_request_response.dart';

import 'quote_request_remote_data_source.dart';
import 'quote_request_rest_api_client.dart';
import 'package:meta/meta.dart';
import 'package:logging/logging.dart';

class QuoteRequestRemoteDataSourceImpl implements QuoteRequestRemoteDataSource {
  final logger = Logger("QuoteRequestRemoteDataSourceImpl");
  QuoteRequestRestApiClient quoteRequestRestApiClient;

  QuoteRequestRemoteDataSourceImpl({@required this.quoteRequestRestApiClient})
      : assert(quoteRequestRestApiClient != null);

  @override
  Future<QuoteRequestResponse> createQuoteRequest(QuoteRequestModel model) async {
    QuoteRequestResponse response = QuoteRequestResponse();
    try {
      var paramData = model.toJson();
      paramData.keys
          .where((k) => paramData[k] == null) // filter keys
          .toList() // create a copy to avoid concurrent modifications
          .forEach(paramData.remove); // remove selected keys
      Map<String, Map<String, dynamic>> param = Map<String, Map<String, dynamic>>();
      param['quote_request'] = paramData;
      QuoteRequestModel data = await quoteRequestRestApiClient.createQuoteRequest(param);
      if (data != null) {
        response.fromModel(data);
      }
    } catch (error, stacktrace) {
      logger.severe("Exception occured in createQuoteRequest $error $stacktrace", error,
          stacktrace);
      response.exception = Exception(error.toString());
    }

    return response;
  }

  @override
  Future<Exception> deleteQuoteRequest(int id) async {
    Exception response;
    try {
      await quoteRequestRestApiClient.deleteQuoteRequest(id);
    } catch (error, stacktrace) {
      logger.severe("Exception occured in createQuoteRequest $error $stacktrace", error,
          stacktrace);
      response = Exception(error.toString());
    }

    return response;
  }

  @override
  Future<QuoteRequestListResponse> listJobQuoteRequests(int job_id) async {
    QuoteRequestListResponse response = QuoteRequestListResponse();
    try {
      List<QuoteRequestModel> data = await quoteRequestRestApiClient.listJobQuoteRequests(job_id);
      if (data != null) {
        response.fromModel(data);
      }
    } catch (error, stacktrace) {
      logger.severe("Exception occured in listJobQuoteRequests $error $stacktrace", error,
          stacktrace);
      response.exception = Exception(error.toString());
    }

    return response;
  }

  @override
  Future<QuoteRequestListResponse> listTraderQuoteRequests(int trader_id) async {
    QuoteRequestListResponse response = QuoteRequestListResponse();
    try {
      List<QuoteRequestModel> data = await quoteRequestRestApiClient.listTraderQuoteRequests(trader_id);
      if (data != null) {
        response.fromModel(data);
      }
    } catch (error, stacktrace) {
      logger.severe("Exception occured in listTraderQuoteRequests $error $stacktrace", error,
          stacktrace);
      response.exception = Exception(error.toString());
    }

    return response;
  }

  @override
  Future<QuoteRequestResponse> showQuoteRequest(int id) async {
    QuoteRequestResponse response = QuoteRequestResponse();
    try {
      QuoteRequestModel data = await quoteRequestRestApiClient.showQuoteRequest(id);
      if (data != null) {
        response.fromModel(data);
      }
    } catch (error, stacktrace) {
      logger.severe("Exception occured in showQuoteRequest $error $stacktrace", error,
          stacktrace);
      response.exception = Exception(error.toString());
    }

    return response;
  }

  @override
  Future<QuoteRequestResponse> updateQuoteRequest(QuoteRequestModel model) async {
    QuoteRequestResponse response = QuoteRequestResponse();
    try {
      var paramData = model.toJson();
      paramData.keys
          .where((k) => paramData[k] == null) // filter keys
          .toList() // create a copy to avoid concurrent modifications
          .forEach(paramData.remove); // remove selected keys
      Map<String, Map<String, dynamic>> param = Map<String, Map<String, dynamic>>();
      param['quote_request'] = paramData;
      QuoteRequestModel data = await quoteRequestRestApiClient.updateQuoteRequest(model.id, param);
      if (data != null) {
        response.fromModel(data);
      }
    } catch (error, stacktrace) {
      logger.severe("Exception occured in updateQuoteRequest $error $stacktrace", error,
          stacktrace);
      response.exception = Exception(error.toString());
    }

    return response;
  }

}