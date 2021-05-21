import 'package:local_people_core/src/quote/domain/entities/quote.dart';
import 'package:local_people_core/src/quote/data/models/quote_model.dart';
import 'package:local_people_core/src/quote/domain/entities/quote_list_response.dart';

import 'package:local_people_core/src/quote/domain/entities/quote_response.dart';
import '../../domain/repositories/quote_repository.dart';
import '../datasources/quote_remote_data_source.dart';
import 'package:meta/meta.dart';
import 'package:logging/logging.dart';
import 'package:local_people_core/core.dart';

class QuoteRepositoryImpl extends QuoteRepository {
  final logger = Logger("QuoteRepositoryImpl");
  final NetworkInfo networkInfo;
  final QuoteRemoteDataSource quoteRemoteDataSource;

  QuoteRepositoryImpl({
    @required this.networkInfo,
    @required this.quoteRemoteDataSource
  }) : assert(networkInfo != null), assert(quoteRemoteDataSource != null);

  @override
  Future<QuoteResponse> createQuote(Quote quote) async {
    QuoteResponse response = QuoteResponse();
    if (await networkInfo.isConnected) {
      try {
        QuoteModel model = QuoteResponse.fromQuote(quote);
        response = await quoteRemoteDataSource.createQuote(model);
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
  Future<Exception> deleteQuote(int id) async {
    Exception exception;
    if (await networkInfo.isConnected) {
      try {
        await quoteRemoteDataSource.deleteQuote(id);
      } catch (error, stacktrace) {
        logger.severe("Exception occured in deleteQuote", error, stacktrace);
        exception = Exception(error.toString());
      }
    } else {
      exception = InternetConnectionException();
    }

    return exception;
  }

  @override
  Future<QuoteListResponse> listJobQuotes(int job_id) async {
    QuoteListResponse response = QuoteListResponse();
    if (await networkInfo.isConnected) {
      try {
        response = await quoteRemoteDataSource.listJobQuotes(job_id);
        if (response.exception != null) {
          logger.severe("Exception occured in listJobQuotes", response.exception);
        }
      } catch (error, stacktrace) {
        logger.severe("Exception occured in listJobQuotes", error, stacktrace);
        response.exception = Exception(error.toString());
      }
    } else {
      response.exception = InternetConnectionException();
    }

    return response;
  }

  @override
  Future<QuoteListResponse> listTraderQuotes(int trader_id) async {
    QuoteListResponse response = QuoteListResponse();
    if (await networkInfo.isConnected) {
      try {
        response = await quoteRemoteDataSource.listTraderQuotes(trader_id);
        if (response.exception != null) {
          logger.severe("Exception occured in listTraderQuotes", response.exception);
        }
      } catch (error, stacktrace) {
        logger.severe("Exception occured in listTraderQuotes", error, stacktrace);
        response.exception = Exception(error.toString());
      }
    } else {
      response.exception = InternetConnectionException();
    }

    return response;
  }

  @override
  Future<QuoteResponse> showQuote(int id) async {
    QuoteResponse response = QuoteResponse();
    if (await networkInfo.isConnected) {
      try {
        response = await quoteRemoteDataSource.showQuote(id);
        if (response.exception != null) {
          logger.severe("Exception occured in showQuote", response.exception);
        }
      } catch (error, stacktrace) {
        logger.severe("Exception occured in showQuote", error, stacktrace);
        response.exception = Exception(error.toString());
      }
    } else {
      response.exception = InternetConnectionException();
    }

    return response;
  }

  @override
  Future<QuoteResponse> updateQuote(Quote quote) async {
    QuoteResponse response = QuoteResponse();
    if (await networkInfo.isConnected) {
      try {
        QuoteModel model = QuoteResponse.fromQuote(quote);
        response = await quoteRemoteDataSource.updateQuote(model);
        if (response.exception != null) {
          logger.severe("Exception occured in updateQuote", response.exception);
        }
      } catch (error, stacktrace) {
        logger.severe("Exception occured in updateQuote", error, stacktrace);
        response.exception = Exception(error.toString());
      }
    } else {
      response.exception = InternetConnectionException();
    }

    return response;
  }

}