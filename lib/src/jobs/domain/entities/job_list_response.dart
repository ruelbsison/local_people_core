
import 'job.dart';
import 'location.dart';
import '../../data/models/job_model.dart';
import '../../data/models/location_model.dart';
import '../../data/models/tag_model.dart';
import 'tag.dart';

class JobListResponse {
  Exception exception;
  List<Job> _jobs;
  List<Job> get jobs => _jobs;

  void jobsFromModel(List<JobModel> list) {
    _jobs = List<Job>();

    var listIter = list.iterator;
    while(listIter.moveNext() ) {
      JobModel model = listIter.current;
      Job job = Job(
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

      _jobs.add(job);
    }
  }
}

