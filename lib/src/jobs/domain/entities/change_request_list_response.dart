
import 'change_request.dart';
import '../../data/models/change_request_model.dart';

class ChangeRequestListResponse {
  Exception exception;
  List<ChangeRequest> changeRequests;

  void fromModel(List<ChangeRequestModel> list) {
    changeRequests = List<ChangeRequest>();

    var listIter = list.iterator;
    while(listIter.moveNext() ) {
      ChangeRequestModel model = listIter.current;
      ChangeRequest changeRequest = ChangeRequest(
          id : model.id ,
          date : DateTime.parse(model.date) ,
          duration : model.duration ,
          status : model.status ,
          traderId : model.trader_id ,
          jobId : model.job_id ,
          clinetId: model.client_id,
          createdAt : model.created_at ,
          updatedAt: model.updated_at ,
      );
      changeRequests.add(changeRequest);
    }
  }
}

