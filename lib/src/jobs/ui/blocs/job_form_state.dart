part of 'job_form_bloc.dart';

class JobFormState extends Equatable {
  const JobFormState();

  @override
  List<Object> get props => [];
}

class JobFormPosting extends JobFormState {}

class JobFormPostCompleted extends JobFormState {
  final Job job;

  const JobFormPostCompleted(this.job);

  @override
  List<Object> get props => [job];
}

class JobFormPostFailed extends JobFormState {
  final String e;

  const JobFormPostFailed(this.e);

  @override
  List<Object> get props => [e];

  @override
  String toString() {
    return 'JobFormPostFailed{e: $e}';
  }
}

class JobFormSavingToDraft extends JobFormState {}

class JobFormSaveToDraftCompleted extends JobFormState {
  final Job job;

  const JobFormSaveToDraftCompleted(this.job);

  @override
  List<Object> get props => [job];
}

class JobFormSaveToDraftFailed extends JobFormState {
  final String e;

  const JobFormSaveToDraftFailed(this.e);

  @override
  List<Object> get props => [e];

  @override
  String toString() {
    return 'JobFormSaveToDraftFailed{e: $e}';
  }
}
