import '../../data/models/message_model.dart';

import '../../domain/entities/message_list_response.dart';

import '../../domain/entities/message_response.dart';

import 'message_remote_data_source.dart';
import 'message_rest_api_client.dart';
import 'package:meta/meta.dart';
import 'package:logging/logging.dart';

class MessageRemoteDataSourceImpl implements MessageRemoteDataSource {
  final logger = Logger("MessageRemoteDataSourceImpl");
  final MessageRestApiClient messageRestApiClient;

  MessageRemoteDataSourceImpl({@required this.messageRestApiClient})
      : assert(messageRestApiClient != null);

  @override
  Future<MessageResponse> createMessage(MessageModel model) async {
    MessageResponse response = MessageResponse();
    try {
      var temp = model.toJson();
      //temp.removeWhere((key, value) => value == null);
      temp.keys
          .where((k) => temp[k] == null) // filter keys
          .toList() // create a copy to avoid concurrent modifications
          .forEach(temp.remove); // remove selected keys
      Map<String, Map<String, dynamic>> param = Map<String, Map<String, dynamic>>();
      param['message'] = temp;
      MessageModel data = await messageRestApiClient.createMessage(param);
      if (data != null) {
        response.fromModel(data);
      }
    } catch (error, stacktrace) {
      logger.severe("Exception occured in createMessage $error $stacktrace", error,
          stacktrace);
      response.exception = Exception(error.toString());
    }

    return response;
  }

  @override
  Future<Exception> deleteMessage(int id) async {
    Exception response = Exception();
    try {
      await messageRestApiClient.deleteMessage(id);
    } catch (error, stacktrace) {
      logger.severe("Exception occured in createMessage $error $stacktrace", error,
          stacktrace);
      response = Exception(error.toString());
    }

    return response;
  }

  @override
  Future<MessageListResponse> listJobMessages(int job_id) async {
    MessageListResponse response = MessageListResponse();
    try {
      List<MessageModel> data = await messageRestApiClient.listJobMessages(job_id);
      if (data != null) {
        response.fromModel(data);
      }
    } catch (error, stacktrace) {
      logger.severe("Exception occured in listJobMessages $error $stacktrace", error,
          stacktrace);
      response.exception = Exception(error.toString());
    }

    return response;
  }

  @override
  Future<MessageResponse> showMessage(int id) async {
    MessageResponse response = MessageResponse();
    try {
      MessageModel data = await messageRestApiClient.showMessage(id);
      if (data != null) {
        response.fromModel(data);
      }
    } catch (error, stacktrace) {
      logger.severe("Exception occured in showMessage $error $stacktrace", error,
          stacktrace);
      response.exception = Exception(error.toString());
    }

    return response;
  }

  @override
  Future<MessageResponse> updateMessage(MessageModel model) async {
    MessageResponse response = MessageResponse();
    try {
      Map<String, Map<String, dynamic>> param = Map<String, Map<String, dynamic>>();
      param['message'] = model.toJson();
      MessageModel data = await messageRestApiClient.updateMessage(model.id, param);
      if (data != null) {
        response.fromModel(data);
      }
    } catch (error, stacktrace) {
      logger.severe("Exception occured in updateMessage $error $stacktrace", error,
          stacktrace);
      response.exception = Exception(error.toString());
    }

    return response;
  }

  @override
  Future<MessageListResponse> listClientMessages(int clientId) async {
    MessageListResponse response = MessageListResponse();
    try {
      List<MessageModel> data = await messageRestApiClient.listClientMessages(clientId);
      if (data != null) {
        response.fromModel(data);
      }
    } catch (error, stacktrace) {
      logger.severe("Exception occured in listClientMessages $error $stacktrace", error,
          stacktrace);
      response.exception = Exception(error.toString());
    }

    return response;
  }

  @override
  Future<MessageListResponse> listTraderMessages(int traderId) async {
    MessageListResponse response = MessageListResponse();
    try {
      List<MessageModel> data = await messageRestApiClient.listTraderMessages(traderId);
      if (data != null) {
        response.fromModel(data);
      }
    } catch (error, stacktrace) {
      logger.severe("Exception occured in listTraderMessages $error $stacktrace", error,
          stacktrace);
      response.exception = Exception(error.toString());
    }

    return response;
  }
}