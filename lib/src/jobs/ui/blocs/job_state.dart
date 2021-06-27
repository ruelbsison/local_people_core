import 'package:equatable/equatable.dart';
import '../../domain/entities/job.dart';
import 'package:meta/meta.dart';
import '../../domain/entities/booking.dart';

abstract class JobState extends Equatable {
  const JobState();

  @override
  List<Object> get props => [];
}

class JobRefreshing extends JobState {}

class JobLoading extends JobState {}

class JobLoaded extends JobState {
  final List<Job> jobs;

  const JobLoaded(this.jobs);

  @override
  List<Object> get props {
    return [jobs];
  }

  @override
  String toString() {
    return 'JobLoaded{response: $jobs}';
  }
}

class JobNotLoaded extends JobState {
  final String e;

  const JobNotLoaded(this.e);

  @override
  String toString() {
    return 'JobNotLoaded{e: $e}';
  }
}

class OpportunitiesRefreshing extends JobState {}

class OpportunitiesLoading extends JobState {}

class OpportunitiesLoaded extends JobState {
  final List<Job> jobs;

  const OpportunitiesLoaded(this.jobs);

  @override
  List<Object> get props {
    return [jobs];
  }

  @override
  String toString() {
    return 'OpportunitiesLoaded{response: $jobs}';
  }
}

class OpportunitiesNotLoaded extends JobState {
  final String e;

  const OpportunitiesNotLoaded(this.e);

  @override
  String toString() {
    return 'OpportunitiesNotLoaded{e: $e}';
  }
}

class JobGetLoading extends JobState {
  @override
  List<Object> get props => [];
}

class JobGetFailed extends JobState {
  @override
  List<Object> get props => [];
}

class JobGetLoaded extends JobState {
  final Job job;

  JobGetLoaded({@required this.job});

  @override
  List<Object> get props => [job];
}

class JobLoadCompleted extends JobState {
  final Job job;

  JobLoadCompleted({@required this.job});

  @override
  List<Object> get props => [job];
}

class JobAwarding extends JobState {
  @override
  List<Object> get props => [];
}

class JobAwardFailed extends JobState {
  final String e;

  const JobAwardFailed(this.e);

  @override
  String toString() {
    return 'JobAwardFailed{e: $e}';
  }
}

class JobAwardComplete extends JobState {
  final Booking booking;

  const JobAwardComplete(this.booking);

  @override
  String toString() {
    return 'JobAwardComplete{e: $booking}';
  }
}