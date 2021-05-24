part of 'tag_bloc.dart';

abstract class TagState extends Equatable {
  const TagState();
}

class TagInitial extends TagState {
  @override
  List<Object> get props => [];
}

class TagsLoading extends TagState {
  @override
  List<Object> get props => [];
}

class LoadTagsFailed extends TagState {
  @override
  List<Object> get props => [];
}

class TagsLoaded extends TagState {
  final List<Tag> tags;

  TagsLoaded({@required this.tags});

  @override
  List<Object> get props => [tags];
}

class JobTagsLoading extends TagState {
  @override
  List<Object> get props => [];
}

class LoadJobTagsFailed extends TagState {
  @override
  List<Object> get props => [];
}

class JobTagsLoaded extends TagState {
  final List<Tag> tags;

  JobTagsLoaded({@required this.tags});

  @override
  List<Object> get props => [tags];
}
