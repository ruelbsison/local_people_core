part of 'job_form_bloc.dart';

abstract class JobFormEvent extends Equatable {
  const JobFormEvent();

  @override
  List<Object> get props => [];
}

class JobFormPostEvent extends JobFormEvent {
  const JobFormPostEvent({@required this.job});

  final Job job;

  @override
  List<Object> get props => [job];
}

class JobFormSaveToDraftEvent extends JobFormEvent {
  const JobFormSaveToDraftEvent({@required this.job});

  final Job job;

  @override
  List<Object> get props => [job];
}
