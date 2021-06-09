import 'package:local_people_core/core.dart';

import '../../../core/configs/constants.dart';
import 'package:flutter/material.dart';
import '../blocs/message_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/message_body.dart';
import '../../domain/entities/message_box.dart';
import 'package:cached_network_image/cached_network_image.dart';

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

    return Scaffold(
      appBar: buildAppBar(),
      body: ((widget.messageBox.jobId == null
          || widget.messageBox.jobId == 0
          || widget.messageBox.jobId == -1)
          ? buildBodyWithMessageBox()
          : buildBodyWithJobMessage()),
    );
  }

  AppBar buildAppBar() {
    final ThemeData theme = Theme.of(context);
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          BackButton(),
          ClipOval (
            child: CachedNetworkImage(
              imageUrl: widget.messageBox.image,
              width: 60,
              height: 60,
              placeholder: (context, url) => LoadingWidget(
                isImage: true,
              ),
              errorWidget: (context, url, error) => Image.asset(
                'packages/local_people_core/assets/images/trader-profile-photo.png',
                fit: BoxFit.cover,
              ),
              fit: BoxFit.cover,
            ),
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

  Widget buildBodyWithMessageBox() {
    return MessageBody(
      messageBox: widget.messageBox,
      messages: [],
      showInputMessage: true,
    );
  }

  Widget buildBodyWithJobMessage() {
    final AppType appType = AppConfig.of(context).appType;
    context.read<MessageBloc>().add(LoadJobMessagesEvent(
        jobId: widget.messageBox.jobId,
        traderId: appType == AppType.CLIENT ? widget.messageBox.traderId : -1));
    return BlocProvider.value(
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
              messageBox: widget.messageBox,
              messages: state.messages,
              showInputMessage: true,
            );
          }
          return ErrorWidget('Unhandle State $state');
        },
      ),
    );
  }
  /*void updateBadger() {
    FlutterAppBadger.isAppBadgeSupported().then((isSupported) {
      if (isSupported) FlutterAppBadger.removeBadge();
      // FlutterAppBadger.updateBadgeCount(1);
    });
  }*/
}
