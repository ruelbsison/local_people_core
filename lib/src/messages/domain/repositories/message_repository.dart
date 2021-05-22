import '../entities/message.dart';
import '../entities/message_response.dart';
import '../entities/message_list_response.dart';

abstract class MessageRepository {

  Future<MessageListResponse> listClientMessages(int client_id);

  Future<MessageListResponse> listTraderMessages(int trader_id);

  Future<MessageListResponse> listJobMessages(int job_id);

  Future<MessageResponse> createMessage(Message message);

  Future<MessageResponse> showMessage(int id);

  Future<MessageResponse> updateMessage(Message message);

  Future<Exception> deleteMessage(int id);
}