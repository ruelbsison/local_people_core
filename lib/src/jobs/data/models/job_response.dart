import '../../../core/exceptions/server_exception.dart';
import '../../domain/entities/job.dart';
import '../../domain/entities/location.dart';
import '../models/job_model.dart';
import '../models/location_model.dart';

class JobResponse {
  ServerException exception;
  Job _job;
  Job get job => _job;

  void jobFromModel(JobModel model) {
      _job = Job(
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
    }
}