import '../../data/models/message_model.dart';
import 'message.dart';

class MessageListResponse {
  Exception exception;
  List<Message> messages;

  void fromModel(List<MessageModel> list) {
    messages = List<Message>();

    var listIter = list.iterator;
    while (listIter.moveNext()) {
      MessageModel model = listIter.current;
      Message message = Message(
        id: model.id,
        userId: (model.client_id != null ? model.client_id : model.trader_id),
        subject: model.subject,
        text: model.body,
        //read: model.read,
        createdAt: DateTime.parse(model.created_at),
      );

      messages.add(message);
    }
  }
}
