import 'job.dart';
import 'location.dart';
import '../../data/models/job_model.dart';
import '../../data/models/location_model.dart';

class JobResponse {
  Exception exception;
  Job _job;
  Job get job => _job;
  set job(Job value) {
    _job = value;
  }

  void jobFromModel(JobModel model) {
    print('-jobFromModel ->');
    this.job = Job(
        id: model.id,
        clientId : model.client_id,
        traderId : model.trader_id,
        title: model.title,
        description: model.description,
        preview: model.description,
        budget: model.budget,
        //tags: result.tags,
        minutesLeft: 120,
        //images: model.images,
        date: DateTime.parse(model.date),
      );

      if (model.location != null) {
        job.location = Location (
          id: model.location.id,
          name: model.location.name,
          address: model.location.address,
        );
      }

    print('-jobFromModel <-');
    }
}