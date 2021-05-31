import 'package:local_people_core/core.dart';

import '../../../core/configs/constants.dart';
import 'package:flutter/material.dart';
import '../blocs/message_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/message_body.dart';
import '../../domain/entities/message_box.dart';

class MessagesScreen extends StatefulWidget {
  MessagesScreen({
    Key key,
    @required this.messageBox,
  }) : super(key: key);

  final MessageBox messageBox;

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessagesScreen> {
  @override
  Widget build(BuildContext context) {
    final AppType appType = AppConfig.of(context).appType;
    context.read<MessageBloc>().add(LoadJobMessagesEvent(
        jobId: widget.messageBox.jobId,
        traderId: appType == AppType.CLIENT ? widget.messageBox.traderId : -1));
    return Scaffold(
      appBar: buildAppBar(),
      body: BlocProvider.value(
        value: context.read<MessageBloc>(),
        child: BlocBuilder<MessageBloc, MessageState>(
          builder: (context, state) {
            if (state is JobMessageLoading) {
              return LoadingWidget();
            } else if (state is MessageInitial) {
              return LoadingWidget();
            } else if (state is LoadJobMessageFailed) {
              return ErrorWidget('Error $state');
            } else if (state is JobMessageLoaded) {
              return MessageBody(
                messages: state.messages,
                showInputMessage: true,
              );
            }
            return ErrorWidget('Unhandle State $state');
          },
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    final ThemeData theme = Theme.of(context);
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          BackButton(),
          CircleAvatar(
              //backgroundImage: AssetImage("assets/images/user_2.png"),
              ),
          SizedBox(width: kDefaultPadding * 0.75),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.messageBox.name,
                style: theme.textTheme.subtitle1,
              )
            ],
          )
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.local_phone),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.videocam),
          onPressed: () {},
        ),
        SizedBox(width: kDefaultPadding / 2),
      ],
    );
  }

  /*void updateBadger() {
    FlutterAppBadger.isAppBadgeSupported().then((isSupported) {
      if (isSupported) FlutterAppBadger.removeBadge();
      // FlutterAppBadger.updateBadgeCount(1);
    });
  }*/
}
