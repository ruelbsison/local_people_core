library local_people_core;

export './src/messages/domain/entities/message.dart';
export './src/messages/domain/entities/message_box.dart';
export './src/messages/domain/entities/message_response.dart';
export './src/messages/domain/entities/message_list_response.dart';

export './src/messages/domain/repositories/message_repository.dart';
export './src/messages/data/models/message_model.dart';
export './src/messages/data/datasources/message_rest_api_client.dart';
export './src/messages/data/datasources/message_remote_data_source.dart';
export './src/messages/data/datasources/message_remote_data_source_impl.dart';
export './src/messages/data/repositories/message_repository_impl.dart';

export './src/messages/ui/blocs/message_box_bloc.dart';
export './src/messages/ui/blocs/message_bloc.dart';
export './src/messages/ui/widgets/text_message.dart';
export './src/messages/ui/widgets/audio_message.dart';
export './src/messages/ui/widgets/video_message.dart';
export './src/messages/ui/widgets/message_input_field.dart';
export './src/messages/ui/widgets/message_widget.dart';
export './src/messages/ui/widgets/message_body.dart';
export './src/messages/ui/widgets/message_box_card.dart';
export './src/messages/ui/widgets/message_box_body.dart';

export './src/messages/ui/views/messages_screen.dart';
export './src/messages/ui/views/message_box_screen.dart';