import '../models/requirement_model.dart';
import '../../domain/entities/requirement_list_response.dart';
import '../../domain/entities/requirement_response.dart';

abstract class RequirementRemoteDataSource {
  Future<RequirementListResponse> listPackageRequirements(int packageIdId);

  Future<RequirementResponse> createRequirement(RequirementModel requirement);

  Future<RequirementResponse> showRequirement(int id);

  Future<RequirementResponse> updateRequirement(RequirementModel requirement);

  Future<Exception> deleteRequirement(int id);
}