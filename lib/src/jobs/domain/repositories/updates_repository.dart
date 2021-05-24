
import '../entities/updates.dart';
import '../entities/updates_response.dart';
import '../entities/updates_list_response.dart';

abstract class UpdatesRepository {
  Future<UpdatesListResponse> listJobUpdatess(int jobId);

  Future<UpdatesResponse> createUpdates(Updates updates);

  Future<UpdatesResponse> showUpdates(int id);

  Future<UpdatesResponse> updateUpdates(Updates updates);

  Future<Exception> deleteUpdates(int id);
}