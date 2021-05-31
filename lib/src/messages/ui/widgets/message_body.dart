import '../../../core/configs/constants.dart';
import '../../domain/entities/message.dart';
import '../../domain/repositories/message_repository.dart';
import 'package:flutter/material.dart';
import '../blocs/message_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_people_core/core.dart';
import 'package:local_people_core/auth.dart';
import 'message_input_field.dart';
import 'message_widget.dart';

class MessageBody extends StatefulWidget {
  MessageBody({
    Key key,
    @required this.messages,
    this.showInputMessage = true,
  }) : super(key: key);

  final List<Message> messages;
  final bool showInputMessage;

  @override
  _MessageBodyState createState() => _MessageBodyState();
}

class _MessageBodyState extends State<MessageBody> {
  int jobId;
  int clientId;
  int traderId;
  String subject;

  @override
  void initState() {
    if (widget.messages.length > 0) {
      Message message = widget.messages[0];
      jobId = message.jobId;
      clientId = message.clientId;
      traderId = message.traderId;
      subject = message.subject;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appType = AppConfig.of(context).appType;
    return BlocProvider(
      create: (context) => MessageBloc(
        messageRepository: RepositoryProvider.of<MessageRepository>(context),
        appType: appType,
        authLocalDataSource: sl<AuthLocalDataSource>(),
      ),
      child: BlocListener<MessageBloc, MessageState>(
        listener: (context, state) {
          if (state is MessageInitial) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          } else if (state is MessageSending) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(content: Text('Sending ...')),
              );
          } else if (state is SendMessageFailed) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            return ErrorWidget('Unhandle State $state');
          } else if (state is MessageSent) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            setState(() {
              widget.messages.add(state.message);
            });
            //context.read<MessageBloc>().add(LoadJobMessagesEvent(jobId: jobId));
          }
        },
        child: builBody(context),
      ),
    );
  }

  Widget builBody(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: ListView.builder(
              itemCount: widget.messages.length,
              itemBuilder: (context, index) =>
                  MessageWidget(message: widget.messages[index]),
            ),
          ),
        ),
        if (widget.showInputMessage == true)
          MessageInputField(
            jobId: jobId,
            clientId: clientId,
            traderId: traderId,
            subject: subject,
          ),
      ],
    );
  }
}
