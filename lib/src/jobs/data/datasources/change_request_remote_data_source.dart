import '../models/change_request_model.dart';
import '../../domain/entities/change_request_list_response.dart';
import '../../domain/entities/change_request_response.dart';

abstract class ChangeRequestRemoteDataSource {
  Future<ChangeRequestListResponse> listTraderChangeRequests(int traderId);

  Future<ChangeRequestListResponse> listJobChangeRequests(int jobId);

  Future<ChangeRequestResponse> createChangeRequest(ChangeRequestModel changeRequest);

  Future<ChangeRequestResponse> showChangeRequest(int id);

  Future<ChangeRequestResponse> updateChangeRequest(ChangeRequestModel changeRequest);

  Future<Exception> deleteChangeRequest(int id);
}