
import '../entities/change_request.dart';
import '../entities/change_request_response.dart';
import '../entities/change_request_list_response.dart';

abstract class ChangeRequestRepository {
  Future<ChangeRequestListResponse> listTraderChangeRequests(int traderId);

  Future<ChangeRequestListResponse> listJobChangeRequests(int jobId);

  Future<ChangeRequestResponse> createChangeRequest(ChangeRequest changeRequest);

  Future<ChangeRequestResponse> showChangeRequest(int id);

  Future<ChangeRequestResponse> updateChangeRequest(ChangeRequest changeRequest);

  Future<Exception> deleteChangeRequest(int id);
}