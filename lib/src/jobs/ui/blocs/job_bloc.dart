import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../domain/repositories/job_repository.dart';
import '../../domain/entities/job_response.dart';
import '../../domain/entities/package_response.dart';
import '../../domain/entities/job_list_response.dart';
import '../../domain/entities/change_request_list_response.dart';
import '../../domain/repositories/tag_repository.dart';
import '../../domain/entities/tag_response.dart';
import '../../domain/entities/location_response.dart';
import '../../../core/enum/app_type.dart';
import '../../domain/entities/job.dart';
import '../../domain/entities/booking.dart';
import '../../domain/entities/booking_response.dart';
import '../../domain/entities/tag.dart';
import '../../domain/repositories/location_repository.dart';
import '../../domain/repositories/package_repository.dart';
import '../../domain/repositories/booking_repository.dart';
import '../../domain/repositories/change_request_repository.dart';
import 'package:local_people_core/auth.dart';
import 'package:local_people_core/quote.dart';

import 'job_event.dart';
import 'job_state.dart';

class JobBloc extends Bloc<JobEvent, JobState> {
  final JobRepository jobRepository;
  final TagRepository tagRepository;
  final LocationRepository locationRepository;
  final AppType appType;
  final AuthLocalDataSource authLocalDataSource;
  final QuoteRepository quoteRepository;
  final QuoteRequestRepository quoteRequestRepository;
  final BookingRepository bookingRepository;
  final ChangeRequestRepository changeRequestRepository;

  // Create a broadcast controller that allows this stream to be listened
  // to multiple times. This is the primary, if not only, type of stream you'll be using.
  //final _jobsController = StreamController<Job>.broadcast();

  // Output stream. This one will be used within our pages to display the notes.
  //get jobs => _jobsController.stream;

  JobBloc({
    @required this.jobRepository,
    @required this.tagRepository,
    @required this.locationRepository,
    @required this.appType,
    @required this.quoteRepository,
    @required this.quoteRequestRepository,
    //@required this.packageRepository,
    @required this.authLocalDataSource,
    @required this.bookingRepository,
    @required this.changeRequestRepository,
  }): super(JobLoading());

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
      yield JobRefreshing();
      if (appType == AppType.CLIENT)
        yield* _mapLoadClientJobToState();
      else
        yield* _mapLoadTraderJobToState();
    } else if (event is LoadOpportunities) {
      yield OpportunitiesLoading();
      yield* _mapLoadOpportunitiesToState();
    } else if (event is RefreshOpportunities) {
      yield OpportunitiesRefreshing();
      yield* _mapLoadOpportunitiesToState();
    } else if (event is JobGetEvent) {
      yield JobGetLoading();
      yield* _mapJobGetToState(event.jobId);
    } else if (event is JobAwardEvent) {
      yield JobAwarding();
      yield* _mapJobAwardToState(event.job, event.quote);
    }
  }

  Stream<JobState> _mapJobAwardToState(Job job, Quote quote) async* {

    job.awarded = true;
    job.traderId = quote.traderId;
    try {
      JobResponse response = await jobRepository.updateJob(job);
      if (response == null) {
        yield JobAwardFailed('');
      } else if (response != null && response.exception != null) {
        yield JobAwardFailed(response.exception.toString());
      } else if (response.job != null) {
        Booking booking = Booking(
          startTime: quote.deliveryDate,
          endTime: quote.deliveryDate.add(
              Duration(hours: quote.dureationRequired)
          ),
          traderId: quote.traderId,
          jobId: quote.jobId,
          details: quote.details,
          status: 'Awarded',
        );
        BookingResponse bookingResponse = await bookingRepository.createBooking(booking);
        if (bookingResponse == null) {
          yield JobAwardFailed('');
        } else if (bookingResponse != null && bookingResponse.exception != null) {
          yield JobAwardFailed(bookingResponse.exception.toString());
        } else if (bookingResponse.booking != null) {
          yield JobAwardComplete(bookingResponse.booking);
        }
      }
    } catch (e) {
      print(e.toString());
      yield JobAwardFailed(e.toString());
    }
  }

  Future<Job> getRelatedJobData(Job job) async  {
    int jobId = job.id;

    try {
      QuoteListResponse qlRes = await quoteRepository.listJobQuotes(job.id);
      if (qlRes == null) {
        //yield JobGetFailed();
      } else if (qlRes != null && qlRes.exception != null) {
        //yield JobGetFailed();
      } else if (qlRes.quotes != null) {
        job.bids = qlRes.quotes;
      }
    } catch (e) {
      print(e.toString());
      //yield JobChangeRequestFailed(e.toString());
    }

    try {
      QuoteRequestListResponse qrRes = await quoteRequestRepository.listJobQuoteRequests(job.id);
      if (qrRes == null) {
        //yield JobGetFailed();
      } else if (qrRes != null && qrRes.exception != null) {
        //yield JobGetFailed();
      } else if (qrRes.quoteRequests != null && qrRes.quoteRequests.length > 0) {
        job.quoteRequests = qrRes.quoteRequests;
      }
    } catch (e) {
    print(e.toString());
    //yield JobChangeRequestFailed(e.toString());
    }

    try {
      ChangeRequestListResponse changeResponse = await changeRequestRepository.listJobChangeRequests(jobId);
      if (changeResponse == null) {
        //yield JobChangeRequestFailed('');
      } else if (changeResponse.exception != null) {
        //yield JobChangeRequestFailed(response.exception.toString());
      } else if (changeResponse.changeRequests != null) {
        job.changeRequests = changeResponse.changeRequests;
        //yield JobChangeRequestLoaded(response.changeRequests);
      }
    } catch (e) {
      print(e.toString());
      //yield JobChangeRequestFailed(e.toString());
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

    return Future.value(job);

  }

  Stream<JobState> _mapJobGetToState(int jobId) async* {

    try {
      JobResponse response = await jobRepository.showJob(jobId);
      if (response == null) {
        yield JobGetFailed();
      } else if (response != null && response.exception != null) {
        yield JobGetFailed();
      } else if (response.job != null) {
        Job job = await getRelatedJobData(response.job);
        yield JobGetLoaded(job: job);
      }
    } catch (e) {
      print(e.toString());
      yield JobGetFailed();
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
        List<Job> jobs = [];
        var listIterator = response.jobs.iterator;
        while (listIterator.moveNext()) {
          Job job = listIterator.current;
          if (job == null) continue;
          job.images = [];
          if (job.id == null || job.id <= 0) continue;

          job = await getRelatedJobData(job);
          jobs.add(job);
          //_jobsController.sink.add(job);
        }

        jobs.sort((a, b) {
          return a.compareTo(b);
        });
        yield JobLoaded(jobs.reversed.toList());
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
        List<Job> jobs = [];
        var listIterator = response.jobs.iterator;
        while (listIterator.moveNext()) {
          Job job = listIterator.current;
          if (job == null) continue;
          job.images = [];
          if (job.id == null || job.id <= 0) continue;

          job = await getRelatedJobData(job);
          jobs.add(job);
        }

        jobs.sort((a, b) {
          return a.compareTo(b);
        });
        yield JobLoaded(jobs.reversed.toList());
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
        List<Job> jobs = [];
        var listIterator = response.jobs.iterator;
        while (listIterator.moveNext()) {
          Job job = listIterator.current;
          if (job == null) continue;
          job.images = [];
          if (job.id == null || job.id <= 0) continue;

          job = await getRelatedJobData(job);
          jobs.add(job);
        }

        jobs.sort((a, b) {
          return a.compareTo(b);
        });
        yield OpportunitiesLoaded(jobs.reversed.toList());
        //yield OpportunitiesLoaded(response.jobs);
      }
    } catch (e) {
      yield OpportunitiesNotLoaded(e.toString());
    }
  }

}
