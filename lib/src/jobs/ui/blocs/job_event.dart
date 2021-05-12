import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../domain/entities/job.dart';

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

class LoadJobs extends JobEvent {}
class RefreshJobs extends JobEvent {}


