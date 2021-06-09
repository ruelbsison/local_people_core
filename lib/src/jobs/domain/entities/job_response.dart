import 'job.dart';
import 'location.dart';
import '../../data/models/job_model.dart';
import '../../data/models/location_model.dart';
import '../../domain/entities/tag.dart';

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
      private: model.private,
      );

      if (model.tag_ids != null && model.tag_ids.length > 0) {
        Iterator tagIter = model.tag_ids.iterator;
        while(tagIter.moveNext()) {
          int tagId = tagIter.current;
          job.tags.add(new Tag(
            id: tagId,
            name: '',
          ));
        }
      }
      if (model.location_id != null) {
        job.location = Location (
          id: model.location_id,
        );
      }

    print('-jobFromModel <-');
    }
}