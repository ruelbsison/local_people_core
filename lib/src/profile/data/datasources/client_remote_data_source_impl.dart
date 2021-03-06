import 'package:local_people_core/src/profile/data/models/client_model.dart';
import 'package:local_people_core/src/profile/domain/entities/client_list_response.dart';
import 'package:local_people_core/src/profile/domain/entities/client_response.dart';
import 'package:meta/meta.dart';
import 'package:logging/logging.dart';
import 'package:dio/dio.dart';
import '../../../../core.dart';
import 'client_rest_api_client.dart';
import 'client_remote_data_source.dart';

class ClientRemoteDataSourceImpl implements ClientRemoteDataSource {
  final logger = Logger("ClientRemoteDataSourceImpl");
  final ClientRestApiClient clientRestApiClient;

  ClientRemoteDataSourceImpl({
      @required this.clientRestApiClient}
      ) : assert(clientRestApiClient != null);

  @override
  Future<ClientResponse> createClient(ClientModel model) async {
    ClientResponse response = ClientResponse();

    try {
      var paramData = model.toJson();
      paramData.keys
          .where((k) => paramData[k] == null) // filter keys
          .toList() // create a copy to avoid concurrent modifications
          .forEach(paramData.remove); // remove selected keys
      Map<String, Map<String, dynamic>> param = Map<String, Map<String, dynamic>>();
      param['client'] = paramData;
      ClientModel data =
          await clientRestApiClient.createClient(param);
      if (data != null) {
        response.fromModel(data);
      }
    } catch (error, stacktrace) {
      logger.severe("Exception occured in createClient $error $stacktrace",
          error, stacktrace);
      response.exception = ServerException.withError(error: error);
    }

    return response;
  }

  @override
  Future<ServerException> deleteClient(int id) async {
    ServerException exception;

    try {
      await clientRestApiClient.deleteClient(id);
    } catch (error, stacktrace) {
      logger.severe("Exception occured in deleteClient $error $stacktrace",
          error, stacktrace);
      exception = ServerException.withError(error: error);
    }

    return exception;
  }

  @override
  Future<ClientResponse> findClientWithEmail(String email_address) async {
    ClientResponse response = ClientResponse();

    try {
      ClientModel data =
          await clientRestApiClient.findClientWithEmail(Uri.encodeQueryComponent(email_address));
      if (data != null) {
        response.fromModel(data);
      }
    } catch (error, stacktrace) {
      logger.severe(
          "Exception occured in findClientWithEmail $error $stacktrace",
          error,
          stacktrace);
      response.exception = Exception(error.toString());
    }

    return response;
  }

  @override
  Future<ClientListResponse> listClients() async {
    ClientListResponse response = ClientListResponse();

    try {
      List<ClientModel> data = await clientRestApiClient.listClients();
      if (data != null) {
        response.fromModel(data);
      }
    } catch (error, stacktrace) {
      logger.severe("Exception occured in listClients $error $stacktrace",
          error, stacktrace);
      response.exception = ServerException.withError(error: error);
    }

    return response;
  }

  @override
  Future<ClientResponse> showClient(int id) async {
    ClientResponse response = ClientResponse();

    try {
      ClientModel data = await clientRestApiClient.showClient(id);
      if (data != null) {
        response.fromModel(data);
      }
    } catch (error, stacktrace) {
      logger.severe("Exception occured in showClient $error $stacktrace", error,
          stacktrace);
      response.exception = ServerException.withError(error: error);
    }

    return response;
  }

  @override
  Future<ClientResponse> updateClient(ClientModel model) async {
    ClientResponse response = ClientResponse();

    try {
      var paramData = model.toJson();
      paramData.keys
          .where((k) => paramData[k] == null) // filter keys
          .toList() // create a copy to avoid concurrent modifications
          .forEach(paramData.remove); // remove selected keys
      Map<String, Map<String, dynamic>> param = Map<String, Map<String, dynamic>>();
      param['client'] = paramData;
      ClientModel data =
          await clientRestApiClient.updateClient(model.id, param);
      if (data != null) {
        response.fromModel(data);
      }
    } catch (error, stacktrace) {
      logger.severe("Exception occured in updateClient $error $stacktrace",
          error, stacktrace);
      response.exception = ServerException.withError(error: error);
    }

    return response;
  }
}
