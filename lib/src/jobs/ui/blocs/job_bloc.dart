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
      yield JobLoading();
      if (appType == AppType.CLIENT)
        yield* _mapLoadClientJobToState(event.userId);
      else
        yield* _mapLoadTraderJobToState(event.userId);
    } else if (event is RefreshJobs) {
      yield JobLoading();
      if (appType == AppType.CLIENT)
        yield* _mapLoadClientJobToState(event.userId);
      else
        yield* _mapLoadTraderJobToState(event.userId);
    }
  }

  Stream<JobState> _mapLoadClientJobToState(int client_id) async* {

    try {
      final response = await jobRepository.listClientJobs(client_id);
      if (response == null) {
        yield JobNotLoaded('');
      } else {
        yield JobLoaded(response.jobs);
      }
    } catch (e) {
      yield JobNotLoaded(e.toString());
    }
  }

  Stream<JobState> _mapLoadTraderJobToState(int trader_id) async* {
    try {
      final response = await jobRepository.listTraderJobs(trader_id);
      if (response == null) {
        yield JobNotLoaded('');
      } else {
        yield JobLoaded(response.jobs);
      }
    } catch (e) {
      yield JobNotLoaded(e.toString());
    }
  }
}
