import '../models/requirement_model.dart';

import '../../domain/entities/requirement_list_response.dart';

import '../../domain/entities/requirement_response.dart';

import 'requirement_remote_data_source.dart';
import 'requirement_rest_api_client.dart';
import 'package:meta/meta.dart';
import 'package:logging/logging.dart';

class RequirementRemoteDataSourceImpl implements RequirementRemoteDataSource {
  final logger = Logger("RequirementRemoteDataSourceImpl");
  final RequirementRestApiClient requirementRestApiClient;

  RequirementRemoteDataSourceImpl({@required this.requirementRestApiClient})
      : assert(requirementRestApiClient != null);

  @override
  Future<RequirementResponse> createRequirement(RequirementModel model) async {
    RequirementResponse response = RequirementResponse();
    try {
      var paramData = model.toJson();
      paramData.keys
          .where((k) => paramData[k] == null) // filter keys
          .toList() // create a copy to avoid concurrent modifications
          .forEach(paramData.remove); // remove selected keys
      Map<String, Map<String, dynamic>> param = Map<String, Map<String, dynamic>>();
      param['requirement'] = paramData;
      RequirementModel data = await requirementRestApiClient.createRequirement(param);
      if (data != null) {
        response.fromModel(data);
      }
    } catch (error, stacktrace) {
      logger.severe("Exception occured in createRequirement $error $stacktrace", error,
          stacktrace);
      response.exception = Exception(error.toString());
    }

    return response;
  }

  @override
  Future<Exception> deleteRequirement(int id) async {
    Exception response;
    try {
      await requirementRestApiClient.deleteRequirement(id);
    } catch (error, stacktrace) {
      logger.severe("Exception occured in deleteRequirement $error $stacktrace", error,
          stacktrace);
      response = Exception(error.toString());
    }

    return response;
  }

  @override
  Future<RequirementListResponse> listPackageRequirements(int packageIdId) async {
    RequirementListResponse response = RequirementListResponse();
    try {
      List<RequirementModel> data = await requirementRestApiClient.listJobRequirements(packageIdId);
      if (data != null) {
        response.fromModel(data);
      }
    } catch (error, stacktrace) {
      logger.severe("Exception occured in listJobRequirements $error $stacktrace", error,
          stacktrace);
      response.exception = Exception(error.toString());
    }

    return response;
  }

  @override
  Future<RequirementResponse> showRequirement(int id) async {
    RequirementResponse response = RequirementResponse();
    try {
      RequirementModel data = await requirementRestApiClient.showRequirement(id);
      if (data != null) {
        response.fromModel(data);
      }
    } catch (error, stacktrace) {
      logger.severe("Exception occured in listTraderRequirements $error $stacktrace", error,
          stacktrace);
      response.exception = Exception(error.toString());
    }

    return response;
  }

  @override
  Future<RequirementResponse> updateRequirement(RequirementModel model) async {
    RequirementResponse response = RequirementResponse();
    try {
      var paramData = model.toJson();
      paramData.keys
          .where((k) => paramData[k] == null) // filter keys
          .toList() // create a copy to avoid concurrent modifications
          .forEach(paramData.remove); // remove selected keys
      Map<String, Map<String, dynamic>> param = Map<String, Map<String, dynamic>>();
      param['requirement'] = paramData;
      RequirementModel data = await requirementRestApiClient.updateRequirement(model.id, param);
      if (data != null) {
        response.fromModel(data);
      }
    } catch (error, stacktrace) {
      logger.severe("Exception occured in updateRequirement $error $stacktrace", error,
          stacktrace);
      response.exception = Exception(error.toString());
    }

    return response;
  }

}
