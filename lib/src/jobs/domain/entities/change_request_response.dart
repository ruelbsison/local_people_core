import 'change_request.dart';
import '../../data/models/change_request_model.dart';

class ChangeRequestResponse {
  Exception exception;
  ChangeRequest changeRequest;

  void fromModel(ChangeRequestModel model) {
    changeRequest = ChangeRequest (
      id : model.id ,
      date : DateTime.parse(model.date),
      duration : model.duration ,
      status : model.status ,
      traderId : model.traderId ,
      jobId : model.jobId ,
      createdAt : model.createdAt ,
      updatedAt: model.updatedAt ,
      );
    }

  static ChangeRequestModel fromChangeRequest(ChangeRequest changeRequest) {
    return ChangeRequestModel (
      id : changeRequest.id ,
      date : changeRequest.date.toString(),
      duration : changeRequest.duration ,
      status : changeRequest.status ,
      traderId : changeRequest.traderId ,
      jobId : changeRequest.jobId ,
      createdAt : changeRequest.createdAt ,
      updatedAt: changeRequest.updatedAt ,
    );
  }
}