
import 'requirement.dart';
import '../../data/models/requirement_model.dart';

class RequirementListResponse {
  Exception exception;
  List<Requirement> requirements;

  void fromModel(List<RequirementModel> list) {
    requirements = List<Requirement>();

    var listIter = list.iterator;
    while(listIter.moveNext() ) {
      RequirementModel model = listIter.current;
      Requirement requirement = Requirement(
        id: model.id,
        packageId : model.packageId,
        title: model.title,
        description: model.description,
        createdAt: model.createdAt,
        updatedAt: model.updatedAt,
      );

      requirements.add(requirement);
    }
  }
}

