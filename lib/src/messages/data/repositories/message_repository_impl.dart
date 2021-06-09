
import '../../domain/entities/message.dart';
import '../models/message_model.dart';
import '../../domain/entities/message_list_response.dart';
import '../../domain/entities/message_response.dart';

import '../../domain/repositories/message_repository.dart';
import '../datasources/message_remote_data_source.dart';
import 'package:meta/meta.dart';
import 'package:logging/logging.dart';
import 'package:local_people_core/core.dart';

class MessageRepositoryImpl implements MessageRepository {
  final logger = Logger("MessageRepositoryImpl");
  final NetworkInfo networkInfo;
  final MessageRemoteDataSource messageRemoteDataSource;

  MessageRepositoryImpl({
    @required this.networkInfo,
    @required this.messageRemoteDataSource
  }) : assert(networkInfo != null), assert(messageRemoteDataSource != null);

  @override
  Future<MessageResponse> createMessage(Message message) async {
    MessageResponse response = MessageResponse();
    if (await networkInfo.isConnected) {
      try {
        MessageModel model = MessageModel.fromMessage(message);
        response = await messageRemoteDataSource.createMessage(model);
        if (response.exception != null) {
          logger.severe("Exception occured in createMessage", response.exception);
        }
      } catch (error, stacktrace) {
        logger.severe("Exception occured in createMessage", error, stacktrace);
        response.exception = Exception(error.toString());
      }
    } else {
      response.exception = InternetConnectionException();
    }

    return response;
  }

  @override
  Future<Exception> deleteMessage(int id) async {
    Exception response;
    if (await networkInfo.isConnected) {
      try {
        await messageRemoteDataSource.deleteMessage(id);
      } catch (error, stacktrace) {
        logger.severe("Exception occured in deleteMessage", error, stacktrace);
        response = Exception(error.toString());
      }
    } else {
      response = InternetConnectionException();
    }

    return response;
  }

  @override
  Future<MessageListResponse> listClientMessages(int client_id) async {
    MessageListResponse response = MessageListResponse();
    if (await networkInfo.isConnected) {
      try {
        response = await messageRemoteDataSource.listClientMessages(client_id);
        if (response.exception != null) {
          logger.severe("Exception occured in listClientMessages", response.exception);
        }
      } catch (error, stacktrace) {
        logger.severe("Exception occured in listClientMessages", error, stacktrace);
        response.exception = Exception(error.toString());
      }
    } else {
      response.exception = InternetConnectionException();
    }

    return response;
  }

  @override
  Future<MessageListResponse> listJobMessages(int currentUserId, int jobId) async {
    MessageListResponse response = MessageListResponse();
    if (await networkInfo.isConnected) {
      try {
        response = await messageRemoteDataSource.listJobMessages(currentUserId, jobId);
        if (response.exception != null) {
          logger.severe("Exception occured in listJobMessages", response.exception);
        }
      } catch (error, stacktrace) {
        logger.severe("Exception occured in listJobMessages", error, stacktrace);
        response.exception = Exception(error.toString());
      }
    } else {
      response.exception = InternetConnectionException();
    }

    return response;
  }

  @override
  Future<MessageListResponse> listTraderMessages(int trader_id) async {
    MessageListResponse response = MessageListResponse();
    if (await networkInfo.isConnected) {
      try {
        response = await messageRemoteDataSource.listTraderMessages(trader_id);
        if (response.exception != null) {
          logger.severe("Exception occured in listTraderMessages", response.exception);
        }
      } catch (error, stacktrace) {
        logger.severe("Exception occured in listTraderMessages", error, stacktrace);
        response.exception = Exception(error.toString());
      }
    } else {
      response.exception = InternetConnectionException();
    }

    return response;
  }

  @override
  Future<MessageResponse> showMessage(int currentUserId, int id) async {
    MessageResponse response = MessageResponse();
    if (await networkInfo.isConnected) {
      try {
        response = await messageRemoteDataSource.showMessage(currentUserId, id);
        if (response.exception != null) {
          logger.severe("Exception occured in showMessage", response.exception);
        }
      } catch (error, stacktrace) {
        logger.severe("Exception occured in showMessage", error, stacktrace);
        response.exception = Exception(error.toString());
      }
    } else {
      response.exception = InternetConnectionException();
    }

    return response;
  }

  @override
  Future<MessageResponse> updateMessage(Message message) async {
    MessageResponse response = MessageResponse();
    if (await networkInfo.isConnected) {
      try {
        MessageModel model = MessageModel.fromMessage(message);
        response = await messageRemoteDataSource.updateMessage(model);
        if (response.exception != null) {
          logger.severe("Exception occured in showMessage", response.exception);
        }
      } catch (error, stacktrace) {
        logger.severe("Exception occured in showMessage", error, stacktrace);
        response.exception = Exception(error.toString());
      }
    } else {
      response.exception = InternetConnectionException();
    }

    return response;
  }
}