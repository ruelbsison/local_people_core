import '../../domain/entities/message.dart';
import 'package:flutter/material.dart';

import '../../../core/configs/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/message_bloc.dart';
import '../../domain/repositories/message_repository.dart';
import 'package:local_people_core/core.dart';
import 'package:local_people_core/auth.dart';


class TextMessage extends StatelessWidget {
  const TextMessage({
    Key key,
    this.message,
  }) : super(key: key);

  final Message message;

  @override
  Widget build(BuildContext context) {
    final appType = AppConfig.of(context).appType;
    if (message.entityStatus == EntityStatus.ENTIRY_STATUS_CREATING) {
      BlocProvider.of<MessageBloc>(context).add(SendMessageEvent(message: message));
      return BlocProvider(
        create: (context) =>
            MessageBloc(
              messageRepository: RepositoryProvider.of<MessageRepository>(
                  context),
              appType: appType,
              authLocalDataSource: sl<AuthLocalDataSource>(),
            ),
        child: BlocBuilder<MessageBloc, MessageState>(
          builder: (context, state) {
            if (state is SendMessageFailed) {
              message.entityStatus = EntityStatus.ENTIRY_STATUS_ERROR;
              return ErrorWidget('Unhandle State $state');
            } else if (state is MessageSent) {
              message.entityStatus = EntityStatus.ENTIRY_STATUS_COMPLETED;
              return buildBody(context);
            }
            return LoadingWidget();
          },
        ),
      );
    }

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
        color: theme.primaryColor.withOpacity(message.isSender ? 1 : 0.1),
        borderRadius: BorderRadius.circular(30),
      ),
      width: size.width - 130,
      // decoration: BoxDecoration(
      //   color: Color.fromRGBO(255, 255, 255, 1),
      //   borderRadius: BorderRadius.circular(5.0),
      // ),
      child:Text(
        message.text,
        maxLines: 250,
        style: TextStyle(
          color: message.isSender
              ? Colors.black
              : Theme.of(context).textTheme.bodyText1.color,
        ),
      ),
    );
  }
}
