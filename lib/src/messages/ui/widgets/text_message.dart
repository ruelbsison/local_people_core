import '../../domain/entities/message.dart';
import 'package:flutter/material.dart';

import '../../../core/configs/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/message_bloc.dart';
import '../../domain/repositories/message_repository.dart';
import 'package:local_people_core/core.dart';
import 'package:local_people_core/auth.dart';

class TextMessage extends StatefulWidget {
  const TextMessage({
    Key key,
    this.message,
  }) : super(key: key);

  final Message message;

  @override
  _TextMessageState createState() =>
      _TextMessageState();
}

class _TextMessageState extends State<TextMessage> {
  @override
  Widget build(BuildContext context) {
    // final appType = AppConfig.of(context).appType;
    // if (widget.message.entityStatus == EntityStatus.ENTIRY_STATUS_CREATING) {
    //   widget.message.text = '...';
    //   BlocProvider.of<MessageBloc>(context).add(SendMessageEvent(message: widget.message));
    //   return BlocProvider(
    //     create: (context) =>
    //         MessageBloc(
    //           messageRepository: RepositoryProvider.of<MessageRepository>(
    //               context),
    //           appType: appType,
    //           authLocalDataSource: sl<AuthLocalDataSource>(),
    //         ),
    //     //child: BlocBuilder<MessageBloc, MessageState>(
    //    //   builder: (context, state) {
    //       child: BlocListener<MessageBloc, MessageState>(
    //         listener: (context, state) {
    //         if (state is SendMessageFailed) {
    //           setState(() {
    //             widget.message.entityStatus = EntityStatus.ENTIRY_STATUS_ERROR;
    //             widget.message.messageStatus = MessageStatus.not_sent;
    //             widget.message.text = state.message.text;
    //           });
    //           //return ErrorWidget('Unhandle State $state');
    //         } else if (state is MessageSent) {
    //           setState(() {
    //             widget.message.entityStatus = EntityStatus.ENTIRY_STATUS_COMPLETED;
    //             widget.message.messageStatus = MessageStatus.not_view;
    //             widget.message.text = state.message.text;
    //           });
    //           //return buildBody(context);
    //         } else {
    //           setState(() {
    //             widget.message.text = '...';
    //           });
    //         }
    //       }, child: buildBody(context),
    //     ),
    //   );
    // }

    return buildBody(context);
  }

  Widget buildBody(BuildContext context) {
    final theme = Theme.of(context);
    final Size size = MediaQuery.of(context).size;
    return Container(
      //padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
      //margin: EdgeInsets.all(12.0),
      padding: EdgeInsets.symmetric(
        horizontal: kDefaultPadding * 0.75,
        vertical: kDefaultPadding / 2,
      ),
      decoration: BoxDecoration(
        //color: theme.primaryColor.withOpacity(widget.message.isSender ? 1 : 0.1),
        color: theme.primaryColor.withOpacity( 1),
        borderRadius: BorderRadius.circular(30),
      ),
      width: size.width - 130,
      // decoration: BoxDecoration(
      //   color: Color.fromRGBO(255, 255, 255, 1),
      //   borderRadius: BorderRadius.circular(5.0),
      // ),
      child:Text(
        widget.message.text,
        maxLines: 250,
        style: TextStyle(
          color: widget.message.isSender
              ? Colors.black
              : Theme.of(context).textTheme.bodyText1.color,
        ),
      ),
    );
  }
}
