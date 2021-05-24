import '../../domain/entities/requirement.dart';
import '../models/requirement_model.dart';
import '../../domain/entities/requirement_list_response.dart';

import '../../domain/entities/requirement_response.dart';
import '../../domain/repositories/requirement_repository.dart';
import '../datasources/requirement_remote_data_source.dart';
import 'package:meta/meta.dart';
import 'package:logging/logging.dart';
import 'package:local_people_core/core.dart';

class RequirementRepositoryImpl extends RequirementRepository {
  final logger = Logger("RequirementRepositoryImpl");
  final NetworkInfo networkInfo;
  final RequirementRemoteDataSource requirementRemoteDataSource;

  RequirementRepositoryImpl({
    @required this.networkInfo,
    @required this.requirementRemoteDataSource
  }) : assert(networkInfo != null), assert(requirementRemoteDataSource != null);

  @override
  Future<RequirementResponse> createRequirement(Requirement Requirement) async {
    RequirementResponse response = RequirementResponse();
    if (await networkInfo.isConnected) {
      try {
        RequirementModel model = RequirementResponse.fromRequirement(Requirement);
        response = await requirementRemoteDataSource.createRequirement(model);
        if (response.exception != null) {
          logger.severe("Exception occured in createRequirement", response.exception);
        }
      } catch (error, stacktrace) {
        logger.severe("Exception occured in createRequirement", error, stacktrace);
        response.exception = Exception(error.toString());
      }
    } else {
      response.exception = InternetConnectionException();
    }

    return response;
  }

  @override
  Future<Exception> deleteRequirement(int id) async {
    Exception exception;
    if (await networkInfo.isConnected) {
      try {
        await requirementRemoteDataSource.deleteRequirement(id);
      } catch (error, stacktrace) {
        logger.severe("Exception occured in deleteRequirement", error, stacktrace);
        exception = Exception(error.toString());
      }
    } else {
      exception = InternetConnectionException();
    }

    return exception;
  }

  @override
  Future<RequirementListResponse> listPackageRequirements(int packageId) async {
    RequirementListResponse response = RequirementListResponse();
    if (await networkInfo.isConnected) {
      try {
        response = await requirementRemoteDataSource.listPackageRequirements(packageId);
        if (response.exception != null) {
          logger.severe("Exception occured in listPackageRequirements", response.exception);
        }
      } catch (error, stacktrace) {
        logger.severe("Exception occured in listPackageRequirements", error, stacktrace);
        response.exception = Exception(error.toString());
      }
    } else {
      response.exception = InternetConnectionException();
    }

    return response;
  }

  @override
  Future<RequirementResponse> showRequirement(int id) async {
    RequirementResponse response = RequirementResponse();
    if (await networkInfo.isConnected) {
      try {
        response = await requirementRemoteDataSource.showRequirement(id);
        if (response.exception != null) {
          logger.severe("Exception occured in showRequirement", response.exception);
        }
      } catch (error, stacktrace) {
        logger.severe("Exception occured in showRequirement", error, stacktrace);
        response.exception = Exception(error.toString());
      }
    } else {
      response.exception = InternetConnectionException();
    }

    return response;
  }

  @override
  Future<RequirementResponse> updateRequirement(Requirement Requirement) async {
    RequirementResponse response = RequirementResponse();
    if (await networkInfo.isConnected) {
      try {
        RequirementModel model = RequirementResponse.fromRequirement(Requirement);
        response = await requirementRemoteDataSource.updateRequirement(model);
        if (response.exception != null) {
          logger.severe("Exception occured in updateRequirement", response.exception);
        }
      } catch (error, stacktrace) {
        logger.severe("Exception occured in updateRequirement", error, stacktrace);
        response.exception = Exception(error.toString());
      }
    } else {
      response.exception = InternetConnectionException();
    }

    return response;
  }

}