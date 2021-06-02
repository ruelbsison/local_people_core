part of 'qualification_bloc.dart';

abstract class QualificationEvent extends Equatable {
  const QualificationEvent();
}

class QualificationAddEvent extends QualificationEvent {
  const QualificationAddEvent({@required this.qualification});

  final Qualification qualification;

  @override
  List<Object> get props => [qualification];
}

class QualificationDeleteEvent extends QualificationEvent {
  const QualificationDeleteEvent({@required this.id});

  final int id;

  @override
  List<Object> get props => [id];
}

class QualificationGetEvent extends QualificationEvent {
  const QualificationGetEvent({@required this.id});

  final int id;

  @override
  List<Object> get props => [id];
}

class QualificationUpdateEvent extends QualificationEvent {
  const QualificationUpdateEvent({@required this.qualification});

  final Qualification qualification;

  @override
  List<Object> get props => [qualification];
}