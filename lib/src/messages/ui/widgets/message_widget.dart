import '../../domain/entities/message.dart';
import 'package:flutter/material.dart';

import '../../../core/configs/constants.dart';
import 'audio_message.dart';
import 'text_message.dart';
import 'video_message.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_people_core/profile.dart';
import 'package:local_people_core/auth.dart';
import 'package:local_people_core/core.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget({
    Key key,
    @required this.message,
  }) : super(key: key);

  final Message message;

  @override
  Widget build(BuildContext context) {
    Widget messageContaint(Message message) {
      switch (message.messageType) {
        case MessageType.text:
          return TextMessage(message: message);
          break;
        case MessageType.audio:
          return AudioMessage(message: message);
          break;
        case MessageType.video:
          return VideoMessage();
          break;
        default:
          return SizedBox();
      }
    }

    final appType = AppConfig.of(context).appType;
    if (message.senderId == message.traderId) {
      BlocProvider.of<ProfileBloc>(context)
          .add((TraderProfileGetEvent(id: message.senderId)));
    } else if (message.senderId == message.clientId) {
      BlocProvider.of<ProfileBloc>(context)
          .add((ClientProfileGetEvent(id: message.senderId)));
    }
    return Padding(
      padding: const EdgeInsets.only(top: kDefaultPadding),
      child: Row(
        mainAxisAlignment:
        message.isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!message.isSender) ...[
          BlocProvider(
            create: (context) => ProfileBloc(
              profileRepository: RepositoryProvider.of<ProfileRepository>(context),
              appType: appType,
              authLocalDataSource: sl<AuthLocalDataSource>(),
            ),
            child: BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
              if (state is TraderProfileGetLoaded) {
                return buildProfileAvatar(state.profile.photo);
              } else if (state is ClientProfileGetLoaded) {
                return buildProfileAvatar(state.profile.photo);
              } else if (state is TraderProfileGetFailed || state is ClientProfileGetFailed) {
                return ErrorWidget('');
              } else {
                return LoadingWidget();
              }
            }),
          ),
            SizedBox(width: kDefaultPadding / 2),
          ],
          messageContaint(message),
          if (message.isSender) MessageStatusDot(status: message.messageStatus)
        ],
      ),
    );
  }

  Widget buildProfileAvatar(String photoUrl) {
    return CircleAvatar(
      radius: 12,
      child:  CachedNetworkImage(
        imageUrl: photoUrl,
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
    );
  }
}

class MessageStatusDot extends StatelessWidget {
  final MessageStatus status;

  const MessageStatusDot({Key key, this.status}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Color dotColor(MessageStatus status) {
      switch (status) {
        case MessageStatus.not_sent:
          return kErrorColor;
          break;
        case MessageStatus.not_view:
          return Theme.of(context).textTheme.bodyText1.color.withOpacity(0.1);
          break;
        case MessageStatus.viewed:
          return theme.primaryColor;
          break;
        default:
          return Colors.transparent;
      }
    }

    return Container(
      margin: EdgeInsets.only(left: kDefaultPadding / 2),
      height: 12,
      width: 12,
      decoration: BoxDecoration(
        color: dotColor(status),
        shape: BoxShape.circle,
      ),
      child: Icon(
        status == MessageStatus.not_sent ? Icons.close : Icons.done,
        size: 8,
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
    );
  }
}
