import '../models/qualification_model.dart';
import '../../domain/entities/qualification_list_response.dart';
import '../../domain/entities/qualification_response.dart';
import 'package:meta/meta.dart';
import 'package:dio/dio.dart';
import 'package:logging/logging.dart';

import '../../../../core.dart';
import 'qualification_rest_api_client.dart';
import 'qualification_remote_data_source.dart';

class QualificationRemoteDataSourceImpl implements QualificationRemoteDataSource {
  final logger = Logger("QualificationRemoteDataSourceImpl");
  final QualificationRestApiClient qualificationRestApiClient;

  QualificationRemoteDataSourceImpl({@required this.qualificationRestApiClient})
      : assert(QualificationRestApiClient != null);

  @override
  Future<QualificationResponse> createQualification(QualificationModel model) async {
    QualificationResponse response = QualificationResponse();

    try {
      var paramData = model.toJson();
      paramData.keys
          .where((k) => paramData[k] == null) // filter keys
          .toList() // create a copy to avoid concurrent modifications
          .forEach(paramData.remove); // remove selected keys
      Map<String, Map<String, dynamic>> param = Map<String, Map<String, dynamic>>();
      param['qualification'] = paramData;
      QualificationModel data =
      await qualificationRestApiClient.createQualification(param);
      if (data != null) {
        response.fromModel(data);
      }
    } catch (error, stacktrace) {
      logger.severe("Exception occured in createQualification $error $stacktrace",
          error, stacktrace);
      response.exception = ServerException.withError(error: error);
    }

    return response;
  }

  @override
  Future<ServerException> deleteQualification(int id) async {
    ServerException exception;

    try {
      await qualificationRestApiClient.deleteQualification(id);
    } catch (error, stacktrace) {
      logger.severe("Exception occured in deleteQualification $error $stacktrace",
          error, stacktrace);
      exception = ServerException.withError(error: error);
    }

    return exception;
  }

  @override
  Future<QualificationListResponse> listQualifications() async {
    QualificationListResponse response = QualificationListResponse();

    try {
      List<QualificationModel> data = await qualificationRestApiClient.listQualifications();
      if (data != null) {
        response.fromModel(data);
      }
    } catch (error, stacktrace) {
      logger.severe("Exception occured in listQualifications $error $stacktrace",
          error, stacktrace);
      response.exception = ServerException.withError(error: error);
    }

    return response;
  }

  @override
  Future<QualificationResponse> showQualification(int id) async {
    QualificationResponse response = QualificationResponse();

    try {
      QualificationModel data = await qualificationRestApiClient.showQualification(id);
      if (data != null) {
        response.fromModel(data);
      }
    } catch (error, stacktrace) {
      logger.severe("Exception occured in showQualification $error $stacktrace", error,
          stacktrace);
      response.exception = ServerException.withError(error: error);
    }

    return response;
  }

  @override
  Future<QualificationResponse> updateQualification(QualificationModel model) async {
    QualificationResponse response = QualificationResponse();

    try {
      var paramData = model.toJson();
      paramData.keys
          .where((k) => paramData[k] == null) // filter keys
          .toList() // create a copy to avoid concurrent modifications
          .forEach(paramData.remove); // remove selected keys
      Map<String, Map<String, dynamic>> param = Map<String, Map<String, dynamic>>();
      param['qualification'] = paramData;
      QualificationModel data =
      await qualificationRestApiClient.updateQualification(model.id, param);
      if (data != null) {
        response.fromModel(data);
      }
    } catch (error, stacktrace) {
      logger.severe("Exception occured in updateQualification $error $stacktrace",
          error, stacktrace);
      response.exception = ServerException.withError(error: error);
    }

    return response;
  }

  @override
  Future<QualificationListResponse> listTraderQualifications(int traderId) async {
    QualificationListResponse response = QualificationListResponse();

    try {
      List<QualificationModel> data = await qualificationRestApiClient.listTraderQualifications(traderId);
      if (data != null) {
        response.fromModel(data);
      }
    } catch (error, stacktrace) {
      logger.severe("Exception occured in listTopRatedQualifications $error $stacktrace",
          error, stacktrace);
      response.exception = ServerException.withError(error: error);
    }

    return response;
  }
}
