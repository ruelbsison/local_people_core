part of 'job_form_bloc.dart';

class JobFormState extends Equatable {
  const JobFormState({this.job, this.status});

  final Job job;
  final FormzStatus status;
  //final AutocompletePrediction location;

  JobFormState copyWith({
    job,
    status,
  }) {
    return JobFormState(
      job: job ?? this.job,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [job, status];

  /*const JobFormState({
    this.description = '',
    this.budget = 0,
    this.date = '',
    this.location = ,
    this.tags = const [],
    this.images = const [],
    this.status = FormzStatus.pure,
  });

  final String description;
  final int budget;
  final String date;
  final Location location;
  final List<Tag> tags;
  final List<File> images;
  final FormzStatus status;

  JobFormState copyWith({
    description,
    budget,
    date,
    location,
    tags,
    images,
    status,
  }) {
    return JobFormState(
      description: description ?? this.description,
      budget: budget ?? this.budget,
      date: date ?? this.date,
      location: location ?? this.location,
      tags: tags ?? this.tags,
      images: images ?? this.images,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [description, budget, date, location, tags, images, status];*/
}

class JobFormPosting extends JobFormState {}

class JobFormPostCompleted extends JobFormState {
  const JobFormPostCompleted(Job job):  super(job: job);
}

class JobFormPostFailed extends JobFormState {
  final String e;

  const JobFormPostFailed(this.e);

  @override
  String toString() {
    return 'JobFormPostFailed{e: $e}';
  }
}

class JobFormSavingToDraft extends JobFormState {}

class JobFormSaveToDraftCompleted extends JobFormState {
  const JobFormSaveToDraftCompleted(Job job):  super(job: job);
}

class JobFormSaveToDraftFailed extends JobFormState {
  final String e;

  const JobFormSaveToDraftFailed(this.e);

  @override
  String toString() {
    return 'JobFormSaveToDraftFailed{e: $e}';
  }
}
