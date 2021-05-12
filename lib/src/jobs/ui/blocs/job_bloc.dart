import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../domain/repositories/job_repository.dart';
import '../../../core/enum/app_type.dart';
import '../../domain/entities/job.dart';

import 'job_event.dart';
import 'job_state.dart';

class JobBloc extends Bloc<JobEvent, JobState> {
  final JobRepository jobRepository;
  final AppType appType;

  JobBloc({@required this.jobRepository, @required this.appType}):
        super(JobLoading());

  @override
  JobState get initialState => JobLoading();

  @override
  Stream<JobState> mapEventToState(JobEvent event) async* {
    if (event is LoadJobs) {
      if (appType == AppType.CLIENT)
        yield* _mapLoadClientJobToState();
      else
        yield* _mapLoadTraderJobToState();
    } else if (event is RefreshJobs) {
      yield JobLoading();
      if (appType == AppType.CLIENT)
        yield* _mapLoadClientJobToState();
      else
        yield* _mapLoadTraderJobToState();
    }
  }

  Stream<JobState> _mapLoadClientJobToState() async* {

    try {
      final response = await jobRepository.getPostedJobs();
      if (response == null) {
        yield JobNotLoaded('');
      } else {
        yield JobLoaded(response);
      }
    } catch (e) {
      yield JobNotLoaded(e.toString());
    }
  }

  Stream<JobState> _mapLoadTraderJobToState() async* {
    try {
      final response = await jobRepository.getRequestedJobs();
      if (response == null) {
        yield JobNotLoaded('');
      } else {
        yield JobLoaded(response);
      }
    } catch (e) {
      yield JobNotLoaded(e.toString());
    }
  }
}
