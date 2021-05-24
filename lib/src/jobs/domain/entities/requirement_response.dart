import 'requirement.dart';
import '../../data/models/requirement_model.dart';

class RequirementResponse {
  Exception exception;
  Requirement requirement;

  void fromModel(RequirementModel model) {
    requirement = Requirement(
      id: model.id,
      packageId : model.packageId,
      title: model.title,
      description: model.description,
      createdAt: model.createdAt,
      updatedAt: model.updatedAt,
    );
  }

  static RequirementModel fromRequirement(Requirement requirement) {
    return RequirementModel (
      id: requirement.id,
      packageId : requirement.packageId,
      title: requirement.title,
      description: requirement.description,
      createdAt: requirement.createdAt,
      updatedAt: requirement.updatedAt,
    );
  }
}