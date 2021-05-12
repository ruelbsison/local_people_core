import 'package:equatable/equatable.dart';
import '../../domain/entities/job.dart';

abstract class JobState extends Equatable {
  const JobState();

  @override
  List<Object> get props => [];
}

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
    return 'HomeLoaded{response: $jobs}';
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