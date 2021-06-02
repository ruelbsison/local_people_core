import '../entities/qualification.dart';
import '../entities/qualification_response.dart';
import '../entities/qualification_list_response.dart';

abstract class QualificationRepository {

  Future<QualificationListResponse> listQualifications();

  Future<QualificationListResponse> listTraderQualifications(int traderId);

  Future<QualificationResponse> showQualification(int id);

  Future<QualificationResponse> createQualification(Qualification qualification);

  Future<QualificationResponse> updateQualification(Qualification qualification);

  Future<Exception> deleteQualification(int id);

}