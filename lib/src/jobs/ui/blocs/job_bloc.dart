import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../domain/repositories/job_repository.dart';
import '../../domain/entities/job_list_response.dart';
import '../../domain/repositories/tag_repository.dart';
import '../../domain/entities/tag_response.dart';
import '../../domain/entities/location_response.dart';
import '../../../core/enum/app_type.dart';
import '../../domain/entities/job.dart';
import '../../domain/entities/tag.dart';
import '../../domain/repositories/location_repository.dart';
import 'package:local_people_core/auth.dart';

import 'job_event.dart';
import 'job_state.dart';

class JobBloc extends Bloc<JobEvent, JobState> {
  final JobRepository jobRepository;
  final TagRepository tagRepository;
  final LocationRepository locationRepository;
  final AppType appType;
  final AuthLocalDataSource authLocalDataSource;

  JobBloc({@required this.jobRepository, @required this.tagRepository,
    @required this.locationRepository, @required this.appType,
    @required this.authLocalDataSource}):
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
    } else if (event is LoadOpportunities) {
      yield OpportunitiesLoading();
      yield* _mapLoadOpportunitiesToState();
    } else if (event is RefreshOpportunities) {
      yield OpportunitiesLoading();
      yield* _mapLoadOpportunitiesToState();
    }
  }

  Stream<JobState> _mapLoadClientJobToState() async* {

    try {
      int clientId = await authLocalDataSource.getUserId();
      JobListResponse response = await jobRepository.listClientJobs(clientId);
      if (response == null) {
        yield JobNotLoaded('');
      } else if (response != null && response.exception != null) {
        yield JobNotLoaded(response.exception.toString());
      } else if (response.jobs != null) {
        var listIterator = response.jobs.iterator;
        while (listIterator.moveNext()) {
          Job job = listIterator.current;
          job.images = [];
          if (job.tags != null && job.tags.length > 0) {
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

          if (job.location != null && job.location.id > 0){
            try {
              LocationResponse locResponse = await locationRepository.showLocation(job.location.id);
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
        }
        response.jobs.sort((a, b) {
          return a.compareTo(b);
        });
        yield JobLoaded(response.jobs.reversed.toList());
      }
    } catch (e) {
      yield JobNotLoaded(e.toString());
    }
  }

  Stream<JobState> _mapLoadTraderJobToState() async* {
    try {
      int traderId = await authLocalDataSource.getUserId();
      final JobListResponse response = await jobRepository.listTraderJobs(traderId);
      if (response == null) {
        yield JobNotLoaded('');
      } else if (response != null && response.exception != null) {
        yield JobNotLoaded(response.exception.toString());
      } else if (response.jobs != null) {
        var listIterator = response.jobs.iterator;
        while (listIterator.moveNext()) {
          Job job = listIterator.current;
          job.images = [];
          if (job.tags != null && job.tags.length > 0) {
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
          if (job.location != null && job.location.id > 0){
            try {
              LocationResponse locResponse = await locationRepository.showLocation(job.location.id);
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
        }
        response.jobs.sort((a, b) {
          return a.compareTo(b);
        });
        yield JobLoaded(response.jobs.reversed.toList());
      }
    } catch (e) {
      yield JobNotLoaded(e.toString());
    }
  }

  Stream<JobState> _mapLoadOpportunitiesToState() async* {
    try {
      final JobListResponse response = await jobRepository.listJobs();
      if (response == null) {
        yield OpportunitiesNotLoaded('');
      } else if (response != null && response.exception != null) {
        yield OpportunitiesNotLoaded(response.exception.toString());
      } else if (response.jobs != null) {
        var listIterator = response.jobs.iterator;
        while (listIterator.moveNext()) {
          Job job = listIterator.current;
          job.images = [];
          if (job.tags != null && job.tags.length > 0) {
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
          if (job.location != null && job.location.id > 0){
            try {
              LocationResponse locResponse = await locationRepository.showLocation(job.location.id);
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
        }
        response.jobs.sort((a, b) {
          return a.compareTo(b);
        });
        yield OpportunitiesLoaded(response.jobs.reversed.toList());
        //yield OpportunitiesLoaded(response.jobs);
      }
    } catch (e) {
      yield OpportunitiesNotLoaded(e.toString());
    }
  }

}
