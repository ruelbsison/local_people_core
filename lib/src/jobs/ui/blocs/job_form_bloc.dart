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
    try {
      final response = await jobRepository.postJob(job);
      if (response == null) {
        yield JobFormPostFailed('');
      } else if (response != null && response.exception != null) {
        yield JobFormPostFailed(response.exception.toString());
      } else if (response != null && response.job != null) {
        if (response.job.tags != null && response.job.tags.length > 0) {
          List<Tag> tagsWithName = [];
          var tagIterator = job.tags.iterator;
          while (tagIterator.moveNext()) {
            Tag tag = tagIterator.current;

            try {
              TagResponse tagResponse = await tagRepository.showTag(tag.id);
              if (tagResponse == null) {
                //yield JobNotLoaded('');
              } else if (tagResponse != null &&
                  tagResponse.exception != null) {
                //yield JobNotLoaded(tagListResponse.exception.toString());
              } else if (tagResponse.tag != null) {
                tagsWithName.add(tagResponse.tag);
              }
            } catch (e) {
              print(e.toString());
              //yield JobNotLoaded(e.toString());
            }

            if (tagsWithName.length > 0) {
              job.tags = tagsWithName;
            }
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
