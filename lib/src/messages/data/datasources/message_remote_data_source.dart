import '../models/message_model.dart';
import '../../domain/entities/message_response.dart';
import '../../domain/entities/message_list_response.dart';

abstract class MessageRemoteDataSource {
  Future<MessageListResponse> listClientMessages(int clientId);

  Future<MessageListResponse> listTraderMessages(int traderId);

  Future<MessageListResponse> listJobMessages(int jobId);

  Future<MessageResponse> createMessage(MessageModel message);

  Future<MessageResponse> showMessage(int id);

  Future<MessageResponse> updateMessage(MessageModel message);

  Future<Exception> deleteMessage(int id);
}