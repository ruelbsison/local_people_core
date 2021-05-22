import 'message.dart';
import '../../data/models/message_model.dart';

class MessageResponse {
  Exception exception;
  Message message;

  void fromModel(MessageModel model) {
    message = Message(
      id: model.id,
      userId: (model.client_id != null ? model.client_id : model.trader_id),
      subject: model.subject,
      text: model.body,
      //read: model.read,
      createdAt: DateTime.parse(model.created_at),
      );
  }
}