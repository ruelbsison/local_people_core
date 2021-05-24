
import '../entities/requirement.dart';
import '../entities/requirement_response.dart';
import '../entities/requirement_list_response.dart';

abstract class RequirementRepository {
  Future<RequirementListResponse> listPackageRequirements(int packageId);

  Future<RequirementResponse> createRequirement(Requirement requirement);

  Future<RequirementResponse> showRequirement(int id);

  Future<RequirementResponse> updateRequirement(Requirement pequirement);

  Future<Exception> deleteRequirement(int id);
}