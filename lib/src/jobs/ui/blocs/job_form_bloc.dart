import 'dart:async';
import 'dart:io';
import 'package:equatable/equatable.dart';
import '../../domain/entities/location.dart';
import '../../domain/entities/tag.dart';
import '../../domain/entities/job.dart';
import 'package:formz/formz.dart';
import 'package:intl/intl.dart';
import '../../domain/repositories/job_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'job_form_event.dart';
part 'job_form_state.dart';

class JobFormBloc extends Bloc<JobFormEvent, JobFormState> {
  final JobRepository jobRepository;

  JobFormBloc({@required this.jobRepository}) : super(const JobFormState());

  /*@override
  void onTransition(Transition<JobFormEvent, JobFormState> transition) {
    print(transition);
    super.onTransition(transition);
  }*/

  @override
  Stream<JobFormState> mapEventToState(JobFormEvent event) async* {
    if (event is JobFormPostEvent) {
      yield JobFormPosting();
      yield* _mapJobPostToState(event.job);
      // if (state.status.isValidated) {
      //   yield state.copyWith(status: FormzStatus.submissionInProgress);
      //   await Future<void>.delayed(const Duration(seconds: 1));
      //   yield state.copyWith(status: FormzStatus.submissionSuccess);
      // }
    } else if (event is JobFormSaveToDraftEvent) {
      yield JobFormSavingToDraft();
      yield* _mapJobSaveToDraftToState(event.job);
    }
  }

  Stream<JobFormState> _mapJobPostToState(Job job) async* {
    try {
      final response = await jobRepository.postJob(job);
      if (response == null) {
        yield JobFormPostFailed('');
      } else {
        yield JobFormPostCompleted(response);
      }
    } catch (e) {
      yield JobFormPostFailed(e.toString());
    }
  }

  Stream<JobFormState> _mapJobSaveToDraftToState(Job job) async* {
    try {
      final response = await jobRepository.postJob(job);
      if (response == null) {
        yield JobFormSaveToDraftFailed('');
      } else {
        yield JobFormSaveToDraftCompleted(response);
      }
    } catch (e) {
      yield JobFormSaveToDraftFailed(e.toString());
    }
  }
}
