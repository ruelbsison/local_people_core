
import '../../../core/exceptions/server_exception.dart';
import '../../domain/entities/job.dart';
import '../../domain/entities/location.dart';
import '../models/job_model.dart';
import '../models/location_model.dart';
import '../models/tag_model.dart';
import '../../domain/entities/tag.dart';

class JobListResponse {
  ServerException exception;
  List<Job> _jobs;
  List<Job> get jobs => _jobs;

  void jobsFromModel(List<JobModel> list) {
    _jobs = List<Job>();

    var listIter = list.iterator;
    while(listIter.moveNext() ) {
      JobModel model = listIter.current;
      Job job = Job(
        id: model.id,
        client_id: model.client_id,
        title: model.title,
        description: model.description,
        preview: model.description,
        location: Location (
          id: model.location.id,
          name: model.location.name,
          address: model.location.address,
          long: model.location.longitude.toDouble(),
          lat: model.location.latitude.toDouble(),
        ),
        budget: model.budget,
        //tags: result.tags,
        minutesLeft: 120,
        //images: model.images,
        date: DateTime.parse(model.date),
      );

      var tagIter = model.tags.iterator;
      while (tagIter.moveNext()) {
        TagModel model = tagIter.current;
        job.tags.add(
            Tag(
          id: model.id,
          name: model.name,
        ));
      }

      _jobs.add(job);
    }
  }
}

