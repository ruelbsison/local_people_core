import 'package:meta/meta.dart';
import 'package:logging/logging.dart';

import '../../domain/entities/qualification.dart';
import '../../domain/entities/qualification_response.dart';
import '../../domain/entities/qualification_list_response.dart';

import '../../domain/repositories/qualification_repository.dart';
import '../datasources/qualification_remote_data_source.dart';
import '../models/qualification_model.dart';
import 'package:local_people_core/core.dart';

class QualificationRepositoryImpl implements QualificationRepository {
  final logger = Logger("QualificationRepositoryImpl");
  final NetworkInfo networkInfo;
  final QualificationRemoteDataSource qualificationRemoteDataSource;

  QualificationRepositoryImpl({
    @required this.networkInfo,
    @required this.qualificationRemoteDataSource,
  }) : assert(qualificationRemoteDataSource != null);

  @override
  Future<QualificationResponse> createQualification(Qualification qualification) async {
    QualificationResponse response = new QualificationResponse();
    if (await networkInfo.isConnected) {
      try {
        QualificationModel model = QualificationModel.fromQualification(qualification);
        response = await qualificationRemoteDataSource.createQualification(model);
        if (response != null && response.exception != null) {
          logger.severe(
              "Exception occured in createQualification", response.exception);
        }
      } catch (error, stacktrace) {
        logger.severe(
            "Exception occured in createQualification", error, stacktrace);
        response.exception = Exception(error.toString());
      }
    } else {
      response.exception = InternetConnectionException();
    }
    return response;
  }
  
  @override
  Future<QualificationResponse> showQualification(int id) async {
    QualificationResponse response = new QualificationResponse();
    if (await networkInfo.isConnected) {
      try {
        response = await qualificationRemoteDataSource.showQualification(id);
        if (response != null && response.exception != null) {
          logger.severe("Exception occured in getQualification", response.exception);
        }
      } catch (error, stacktrace) {
        logger.severe("Exception occured in getQualification", error, stacktrace);
        response.exception = Exception(error.toString());
      }
    } else {
      response.exception = InternetConnectionException();
    }
    return response;
  }

  @override
  Future<QualificationResponse> updateQualification(Qualification qualification) async {
    QualificationResponse response = new QualificationResponse();
    if (await networkInfo.isConnected) {
      try {
        QualificationModel model = QualificationModel.fromQualification(qualification);
        response = await qualificationRemoteDataSource.updateQualification(model);
        if (response != null && response.exception != null) {
          logger.severe("Exception occured in findTraderWithEmail", response.exception);
        }
      } catch (error, stacktrace) {
        logger.severe("Exception occured in findTraderWithEmail", error, stacktrace);
        response.exception = Exception(error.toString());
      }
    } else {
      response.exception = InternetConnectionException();
    }
    return response;
  }

  @override
  Future<QualificationListResponse> listTraderQualifications(int traderId) async {
    QualificationListResponse response = new QualificationListResponse();
    if (await networkInfo.isConnected) {
      try {
        response = await qualificationRemoteDataSource.listTraderQualifications(traderId);
        if (response != null && response.exception != null) {
          logger.severe("Exception occured in listTraderQualifications", response.exception);
        }
      } catch (error, stacktrace) {
        logger.severe("Exception occured in listTraderQualifications", error, stacktrace);
        response.exception = Exception(error.toString());
      }
    } else {
      response.exception = InternetConnectionException();
    }
    return response;
  }

  @override
  Future<Exception> deleteQualification(int id) async {
    Exception response;
    if (await networkInfo.isConnected) {
      try {
        await qualificationRemoteDataSource.deleteQualification(id);
      } catch (error, stacktrace) {
        logger.severe("Exception occured in deleteQualification", error, stacktrace);
        response = Exception(error.toString());
      }
    } else {
      response = InternetConnectionException();
    }

    return response;
  }

  @override
  Future<QualificationListResponse> listQualifications() async {
    QualificationListResponse response = QualificationListResponse();
    if (await networkInfo.isConnected) {
      try {
        response = await qualificationRemoteDataSource.listQualifications();
        if (response != null && response.exception != null) {
          logger.severe("Exception occured in listQualifications", response.exception);
        }
      } catch (error, stacktrace) {
        logger.severe("Exception occured in listQualifications", error, stacktrace);
        response.exception = Exception(error.toString());
      }
    } else {
      response.exception = InternetConnectionException();
    }

    return response;
  }

}