
import 'package:local_people_core/src/quote/domain/entities/quote_request.dart';
import 'package:local_people_core/src/quote/data/models/quote_request_model.dart';
import 'package:local_people_core/src/quote/domain/entities/quote_request_list_response.dart';

import 'package:local_people_core/src/quote/domain/entities/quote_request_response.dart';
import 'package:meta/meta.dart';
import 'package:logging/logging.dart';
import 'package:local_people_core/core.dart';
import '../datasources/quote_request_remote_data_source.dart';
import '../../domain/repositories/quote_request_repository.dart';

class QuoteRequestRepositoryImpl extends QuoteRequestRepository {
  final logger = Logger("QuoteRequestRepositoryImpl");
  final NetworkInfo networkInfo;
  final QuoteRequestRemoteDataSource quoteRemoteDataSource;

  QuoteRequestRepositoryImpl({
    @required this.networkInfo,
    @required this.quoteRemoteDataSource
  }) : assert(networkInfo != null), assert(quoteRemoteDataSource != null);

  @override
  Future<QuoteRequestResponse> createQuoteRequest(QuoteRequest quoteRequest) async {
    QuoteRequestResponse response = QuoteRequestResponse();
    if (await networkInfo.isConnected) {
      try {
        QuoteRequestModel model = QuoteRequestResponse.fromQuoteRequest(quoteRequest);
        response = await quoteRemoteDataSource.createQuoteRequest(model);
        if (response.exception != null) {
          logger.severe("Exception occured in createQuote", response.exception);
        }
      } catch (error, stacktrace) {
        logger.severe("Exception occured in createQuote", error, stacktrace);
        response.exception = Exception(error.toString());
      }
    } else {
      response.exception = InternetConnectionException();
    }

    return response;
  }

  @override
  Future<Exception> deleteQuoteRequest(int id) async {
    Exception response;
    if (await networkInfo.isConnected) {
      try {
        await quoteRemoteDataSource.deleteQuoteRequest(id);
      } catch (error, stacktrace) {
        logger.severe("Exception occured in deleteQuoteRequest", error, stacktrace);
        response = Exception(error.toString());
      }
    } else {
      response = InternetConnectionException();
    }

    return response;
  }

  @override
  Future<QuoteRequestListResponse> listJobQuoteRequests(int job_id) async {
    QuoteRequestListResponse response = QuoteRequestListResponse();
    if (await networkInfo.isConnected) {
      try {
        response = await quoteRemoteDataSource.listJobQuoteRequests(job_id);
        if (response.exception != null) {
          logger.severe("Exception occured in listJobQuoteRequests", response.exception);
        }
      } catch (error, stacktrace) {
        logger.severe("Exception occured in listJobQuoteRequests", error, stacktrace);
        response.exception = Exception(error.toString());
      }
    } else {
      response.exception = InternetConnectionException();
    }

    return response;
  }

  @override
  Future<QuoteRequestListResponse> listTraderQuoteRequests(int trader_id) async {
    QuoteRequestListResponse response = QuoteRequestListResponse();
    if (await networkInfo.isConnected) {
      try {
        response = await quoteRemoteDataSource.listTraderQuoteRequests(trader_id);
        if (response.exception != null) {
          logger.severe("Exception occured in listTraderQuoteRequests", response.exception);
        }
      } catch (error, stacktrace) {
        logger.severe("Exception occured in listTraderQuoteRequests", error, stacktrace);
        response.exception = Exception(error.toString());
      }
    } else {
      response.exception = InternetConnectionException();
    }

    return response;
  }

  @override
  Future<QuoteRequestResponse> showQuoteRequest(int id) async {
    QuoteRequestResponse response = QuoteRequestResponse();
    if (await networkInfo.isConnected) {
      try {
        response = await quoteRemoteDataSource.showQuoteRequest(id);
        if (response.exception != null) {
          logger.severe("Exception occured in showQuoteRequest", response.exception);
        }
      } catch (error, stacktrace) {
        logger.severe("Exception occured in showQuoteRequest", error, stacktrace);
        response.exception = Exception(error.toString());
      }
    } else {
      response.exception = InternetConnectionException();
    }

    return response;
  }

  @override
  Future<QuoteRequestResponse> updateQuoteRequest(QuoteRequest quoteRequest) async {
    QuoteRequestResponse response = QuoteRequestResponse();
    if (await networkInfo.isConnected) {
      try {
        QuoteRequestModel model = QuoteRequestResponse.fromQuoteRequest(quoteRequest);
        response = await quoteRemoteDataSource.updateQuoteRequest(model);
        if (response.exception != null) {
          logger.severe("Exception occured in updateQuoteRequest", response.exception);
        }
      } catch (error, stacktrace) {
        logger.severe("Exception occured in updateQuoteRequest", error, stacktrace);
        response.exception = Exception(error.toString());
      }
    } else {
      response.exception = InternetConnectionException();
    }

    return response;
  }
  
}