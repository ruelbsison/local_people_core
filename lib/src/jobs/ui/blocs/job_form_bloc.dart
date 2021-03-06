import 'dart:async';
import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:local_people_core/jobs.dart';
import '../../domain/entities/location.dart';
import '../../domain/entities/tag.dart';
import '../../domain/entities/job.dart';
import 'package:formz/formz.dart';
import 'package:intl/intl.dart';
import '../../domain/repositories/job_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../domain/repositories/tag_repository.dart';
import '../../domain/entities/tag_response.dart';
import '../../domain/repositories/location_repository.dart';


part 'job_form_event.dart';
part 'job_form_state.dart';

class JobFormBloc extends Bloc<JobFormEvent, JobFormState> {
  final JobRepository jobRepository;
  final TagRepository tagRepository;
  final LocationRepository locationRepository;

  JobFormBloc({@required this.jobRepository,
    @required this.tagRepository,
    @required this.locationRepository}) : super(const JobFormState());

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
    if (job.location != null) {
      try {
        LocationResponse locResponse = await locationRepository.createLocation(job.location);
        if (locResponse == null) {
          //yield JobNotLoaded('');
        } else if (locResponse != null &&
            locResponse.exception != null) {
          //yield JobNotLoaded(tagListResponse.exception.toString());
        } else if (locResponse.location != null) {
          job.location = locResponse.location;
        }
      } catch (e) {
        print(e.toString());
        //yield JobNotLoaded(e.toString());
      }
    }

    try {
      final response = await jobRepository.postJob(job);
      if (response == null) {
        yield JobFormPostFailed('');
      } else if (response != null && response.exception != null) {
        yield JobFormPostFailed(response.exception.toString());
      } else if (response != null && response.job != null) {
        if (job.location != null) {
          job.location.jobId = response.job.id;
          try {
            LocationResponse locResponse = await locationRepository
                .updateLocation(job.location);
            if (locResponse == null) {
              //yield JobNotLoaded('');
            } else if (locResponse != null &&
                locResponse.exception != null) {
              //yield JobNotLoaded(tagListResponse.exception.toString());
            } else if (locResponse.location != null) {
              job.location = locResponse.location;
            }
          } catch (e) {
            print(e.toString());
            //yield JobNotLoaded(e.toString());
          }
        }
        yield JobFormPostCompleted(response.job);
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
        yield JobFormSaveToDraftCompleted(response.job);
      }
    } catch (e) {
      yield JobFormSaveToDraftFailed(e.toString());
    }
  }
}
