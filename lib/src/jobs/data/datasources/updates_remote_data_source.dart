import '../models/updates_model.dart';
import '../../domain/entities/updates_list_response.dart';
import '../../domain/entities/updates_response.dart';

abstract class UpdatesRemoteDataSource {
  Future<UpdatesListResponse> listJobUpdatess(int jobId);

  Future<UpdatesResponse> createUpdates(UpdatesModel updates);

  Future<UpdatesResponse> showUpdates(int id);

  Future<UpdatesResponse> updateUpdates(UpdatesModel updates);

  Future<Exception> deleteUpdates(int id);
}