import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../domain/repositories/job_repository.dart';
import '../../../core/enum/app_type.dart';
//import '../../domain/entities/job.dart';
import 'package:local_people_core/auth.dart';

import 'job_event.dart';
import 'job_state.dart';

class JobBloc extends Bloc<JobEvent, JobState> {
  final JobRepository jobRepository;
  final AppType appType;
  final AuthLocalDataSource authLocalDataSource;

  JobBloc({@required this.jobRepository, @required this.appType, @required this.authLocalDataSource}):
        super(JobLoading());

  @override
  JobState get initialState => JobLoading();

  @override
  Stream<JobState> mapEventToState(JobEvent event) async* {
    if (event is LoadJobs) {
      yield JobLoading();
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
      int clientId = await authLocalDataSource.getUserId();
      final response = await jobRepository.listClientJobs(clientId);
      if (response == null) {
        yield JobNotLoaded('');
      } else {
        yield JobLoaded(response.jobs);
      }
    } catch (e) {
      yield JobNotLoaded(e.toString());
    }
  }

  Stream<JobState> _mapLoadTraderJobToState() async* {
    try {
      int traderId = await authLocalDataSource.getUserId();
      final response = await jobRepository.listTraderJobs(traderId);
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
