
import 'qualification.dart';
import '../../data/models/qualification_model.dart';

class QualificationListResponse {
  Exception exception;
  List<Qualification> qualifications;

  void fromModel(List<QualificationModel>  models) {
    qualifications = [];
    var listIter = models.iterator;
    while(listIter.moveNext() ) {
      QualificationModel model = listIter.current;
      Qualification qualification = Qualification(
        id: model.id,
        title: model.title,
        traderId: model.trader_id,
      );
      qualifications.add(qualification);
    }
  }

}

