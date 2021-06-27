import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../domain/entities/job.dart';
import 'package:local_people_core/quote.dart';

class JobEvent extends Equatable {
  const JobEvent();

  @override
  List<Object> get props => [];
}

class JobPostEvent extends JobEvent {
  const JobPostEvent({@required this.job});

  final Job job;

  @override
  List<Object> get props => [job];
}

class LoadJobs extends JobEvent {
  // const LoadJobs({@required this.userId});
  //
  // final int userId;
  //
  // @override
  // List<Object> get props => [userId];
}
class RefreshJobs extends JobEvent {
  // const RefreshJobs({@required this.userId});
  //
  // final int userId;
  //
  // @override
  // List<Object> get props => [userId];
}

class LoadOpportunities extends JobEvent {}

class RefreshOpportunities extends JobEvent {}

class JobGetEvent extends JobEvent {
  final int jobId;

  JobGetEvent({@required this.jobId});

  @override
  List<Object> get props => [jobId];
}

class JobAwardEvent extends JobEvent {
  final Job job;
  final Quote quote;

  JobAwardEvent({@required this.job, @required this.quote});

  @override
  List<Object> get props => [job, quote];
}


