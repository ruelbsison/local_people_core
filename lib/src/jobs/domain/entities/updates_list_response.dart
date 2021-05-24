
import 'updates.dart';
import '../../data/models/updates_model.dart';

class UpdatesListResponse {
  Exception exception;
  List<Updates> updates;

  void fromModel(List<UpdatesModel> list) {
    updates = List<Updates>();

    var listIter = list.iterator;
    while(listIter.moveNext() ) {
      UpdatesModel model = listIter.current;
      Updates update = Updates(
        id: model.id,
        details : model.details,
        status: model.status,
        delayedBy: model.delayedBy,
        jobId: model.jobId,
        createdAt: model.createdAt,
        updatedAt: model.updatedAt,
      );

      updates.add(update);
    }
  }
}

