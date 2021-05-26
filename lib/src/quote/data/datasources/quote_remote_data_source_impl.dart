import 'package:local_people_core/src/quote/data/models/quote_model.dart';

import 'package:local_people_core/src/quote/domain/entities/quote_list_response.dart';

import 'package:local_people_core/src/quote/domain/entities/quote_response.dart';

import 'quote_remote_data_source.dart';
import 'quote_rest_api_client.dart';
import 'package:meta/meta.dart';
import 'package:logging/logging.dart';

class QuoteRemoteDataSourceImpl implements QuoteRemoteDataSource {
  final logger = Logger("TraderRemoteDataSourceImpl");
  final QuoteRestApiClient quoteRestApiClient;

  QuoteRemoteDataSourceImpl({@required this.quoteRestApiClient})
      : assert(quoteRestApiClient != null);

  @override
  Future<QuoteResponse> createQuote(QuoteModel model) async {
    QuoteResponse response = QuoteResponse();
    try {
      var paramData = model.toJson();
      paramData.keys
          .where((k) => paramData[k] == null) // filter keys
          .toList() // create a copy to avoid concurrent modifications
          .forEach(paramData.remove); // remove selected keys
      Map<String, Map<String, dynamic>> param = Map<String, Map<String, dynamic>>();
      param['quote'] = paramData;
      QuoteModel data = await quoteRestApiClient.createQuote(param);
      if (data != null) {
        response.fromModel(data);
      }
    } catch (error, stacktrace) {
      logger.severe("Exception occured in createQuote $error $stacktrace", error,
          stacktrace);
      response.exception = Exception(error.toString());
    }

    return response;
  }

  @override
  Future<Exception> deleteQuote(int id) async {
    Exception response;
    try {
      await quoteRestApiClient.deleteQuote(id);
    } catch (error, stacktrace) {
      logger.severe("Exception occured in deleteQuote $error $stacktrace", error,
          stacktrace);
      response = Exception(error.toString());
    }

    return response;
  }

  @override
  Future<QuoteListResponse> listJobQuotes(int job_id) async {
    QuoteListResponse response = QuoteListResponse();
    try {
      List<QuoteModel> data = await quoteRestApiClient.listJobQuotes(job_id);
      if (data != null) {
        response.fromModel(data);
      }
    } catch (error, stacktrace) {
      logger.severe("Exception occured in listJobQuotes $error $stacktrace", error,
          stacktrace);
      response.exception = Exception(error.toString());
    }

    return response;
  }

  @override
  Future<QuoteListResponse> listTraderQuotes(int trader_id) async {
    QuoteListResponse response = QuoteListResponse();
    try {
      List<QuoteModel> data = await quoteRestApiClient.listTraderQuotes(trader_id);
      if (data != null) {
        response.fromModel(data);
      }
    } catch (error, stacktrace) {
      logger.severe("Exception occured in listTraderQuotes $error $stacktrace", error,
          stacktrace);
      response.exception = Exception(error.toString());
    }
    return response;
  }

  @override
  Future<QuoteResponse> showQuote(int id) async {
    QuoteResponse response = QuoteResponse();
    try {
      QuoteModel data = await quoteRestApiClient.showQuote(id);
      if (data != null) {
        response.fromModel(data);
      }
    } catch (error, stacktrace) {
      logger.severe("Exception occured in listTraderQuotes $error $stacktrace", error,
          stacktrace);
      response.exception = Exception(error.toString());
    }

    return response;
  }

  @override
  Future<QuoteResponse> updateQuote(QuoteModel model) async {
    QuoteResponse response = QuoteResponse();
    try {
      var paramData = model.toJson();
      paramData.keys
          .where((k) => paramData[k] == null) // filter keys
          .toList() // create a copy to avoid concurrent modifications
          .forEach(paramData.remove); // remove selected keys
      Map<String, Map<String, dynamic>> param = Map<String, Map<String, dynamic>>();
      param['quote'] = paramData;
      QuoteModel data = await quoteRestApiClient.updateQuote(model.id, param);
      if (data != null) {
        response.fromModel(data);
      }
    } catch (error, stacktrace) {
      logger.severe("Exception occured in updateQuote $error $stacktrace", error,
          stacktrace);
      response.exception = Exception(error.toString());
    }

    return response;
  }

}
