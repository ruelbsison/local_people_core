part of 'tag_bloc.dart';

abstract class TagEvent extends Equatable {
  const TagEvent();
}

class LoadTags extends TagEvent {
  @override
  List<Object> get props => [];
}

class LoadJobTags extends TagEvent {
  final int jobId;

  LoadJobTags({@required this.jobId});

  @override
  List<Object> get props => [jobId];
}
