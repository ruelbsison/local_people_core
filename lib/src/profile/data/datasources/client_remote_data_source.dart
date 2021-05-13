import '../../domain/entities/client_list_response.dart';
import '../../domain/entities/client_response.dart';
import '../models/client_model.dart';
import '../../../core/exceptions/server_exception.dart';

abstract class ClientRemoteDataSource {
  Future<ClientListResponse> listClients();

  Future<ClientResponse> createClient(ClientModel client);

  Future<ClientResponse> showClient(int id);

  Future<ClientResponse> updateClient(ClientModel client);

  Future<ClientResponse> findClientWithEmail(String email_address);

  Future<ServerException> deleteClient(int id);
}