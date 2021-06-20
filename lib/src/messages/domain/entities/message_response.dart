import 'message.dart';
import '../../data/models/message_model.dart';

class MessageResponse {
  Exception exception;
  Message message;

  void fromModel(MessageModel model, int userId) {
    message = Message(
      id: model.id,
      clientId: model.client_id,
      traderId: model.trader_id,
      subject: model.subject,
      text: model.body,
      messageStatus: model.read == true ? MessageStatus.viewed : MessageStatus.not_view,
      createdAt: DateTime.parse(model.created_at),
      jobId: model.job_id,
      messageType: MessageType.text,
      senderId: model.sender_id,
      isSender: userId == model.sender_id ? true : false,
      recipientId: model.recipient_id,
      );
  }
}