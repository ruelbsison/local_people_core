import '../../domain/entities/qualification_list_response.dart';
import '../../domain/entities/qualification_response.dart';
import '../models/qualification_model.dart';
import '../../../core/exceptions/server_exception.dart';

abstract class QualificationRemoteDataSource {
  Future<QualificationListResponse> listQualifications();

  Future<QualificationListResponse> listTraderQualifications(int traderId);

  Future<QualificationResponse> createQualification(QualificationModel model);

  Future<QualificationResponse> showQualification(int id);

  Future<QualificationResponse> updateQualification(QualificationModel model);

  Future<ServerException> deleteQualification(int id);
}