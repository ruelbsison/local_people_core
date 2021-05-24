
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
          date : model.date ,
          duration : model.duration ,
          status : model.status ,
          traderId : model.traderId ,
          jobId : model.jobId ,
          createdAt : model.createdAt ,
          updatedAt: model.updatedAt ,
      );
      changeRequests.add(changeRequest);
    }
  }
}

