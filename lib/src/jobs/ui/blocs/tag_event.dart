part of 'tag_bloc.dart';

abstract class TagEvent extends Equatable {
  const TagEvent();
}

class LoadTagsEvent extends TagEvent {
  @override
  List<Object> get props => [];
}

class LoadJobTagsEvent extends TagEvent {
  final int jobId;

  LoadJobTagsEvent({@required this.jobId});

  @override
  List<Object> get props => [jobId];
}
