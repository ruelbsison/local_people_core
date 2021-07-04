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
      traderId : model.trader_id ,
      jobId : model.job_id ,
      createdAt : model.created_at ,
      updatedAt: model.updated_at ,
      clinetId: model.client_id,
      );
    }

  static ChangeRequestModel fromChangeRequest(ChangeRequest changeRequest) {
    return ChangeRequestModel (
      id : changeRequest.id ,
      date : changeRequest.date.toString(),
      duration : changeRequest.duration ,
      status : changeRequest.status ,
      trader_id : changeRequest.traderId ,
      job_id : changeRequest.jobId ,
      client_id: changeRequest.clinetId,
      created_at : changeRequest.createdAt ,
      updated_at: changeRequest.updatedAt ,
    );
  }
}