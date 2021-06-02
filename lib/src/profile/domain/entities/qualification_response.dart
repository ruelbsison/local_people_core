
import 'qualification.dart';
import '../../data/models/qualification_model.dart';

class QualificationResponse {
  Exception exception;
  Qualification qualification;

  void fromModel(QualificationModel model) {
    qualification = Qualification(
      id: model.id,
      title: model.title,
      traderId: model.trader_id,
    );
  }
}

