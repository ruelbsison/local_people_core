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
        clientId: model.client_id,
        traderId: model.trader_id,
        subject: model.subject,
        text: model.body,
        messageStatus: model.read == true ? MessageStatus.viewed : MessageStatus.not_view,
        createdAt: DateTime.parse(model.created_at),
        jobId: model.job_id,
        messageType: MessageType.text,
      );

      messages.add(message);
    }
  }
}
