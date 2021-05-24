
import 'updates.dart';
import '../../data/models/updates_model.dart';

class UpdatesResponse {
  Exception exception;
  Updates update;

  void fromModel(UpdatesModel model) {
      update = Updates(
        id: model.id,
        details : model.details,
        status: model.status,
        delayedBy: model.delayedBy,
        jobId: model.jobId,
        createdAt: model.createdAt,
        updatedAt: model.updatedAt,
      );
  }

  static UpdatesModel fromUpdates(Updates updates) {
    return UpdatesModel(
      id: updates.id,
      details: updates.details,
      status: updates.status,
      delayedBy: updates.delayedBy,
      jobId: updates.jobId,
      createdAt: updates.createdAt,
      updatedAt: updates.updatedAt,
    );
  }
}

