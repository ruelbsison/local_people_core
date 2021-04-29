import 'package:meta/meta.dart';
import 'package:logging/logging.dart';

import 'user_remote_data_source.dart';
import '../../../../core.dart';
import 'user_rest_api_client.dart';
import '../models/user_model.dart';

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final logger = Logger("UserRemoteDataSourceImpl");
  final String baseUrl;
  UserRestApiClient userRestApiClient;

  UserRemoteDataSourceImpl({
    @required this.baseUrl
  })  : assert(baseUrl != null) {
    userRestApiClient = UserRestApiClient(RestAPIConfig.getDioOptions(),
        baseUrl: baseUrl);
  }

  @override
  Future<UserModel> createUser(UserModel user) async {
    UserModel data;
    try {
      data = await userRestApiClient.createUser(user.id, user);
    } catch (error, stacktrace) {
      logger.severe("Exception occured in createUser", error, stacktrace);
      throw ServerException.withError(error: error);
    }

    return data;
  }

  @override
  Future<void> deleteUser(int id) async {
    try {
      await userRestApiClient.showUser(id);
    } catch (error, stacktrace) {
      logger.severe("Exception occured in showUser", error, stacktrace);
      throw ServerException.withError(error: error);
    }
  }

  @override
  Future<List<UserModel>> listUsers() async {
    List<UserModel> data;
    try {
      data = await userRestApiClient.listUsers();
    } catch (error, stacktrace) {
      logger.severe("Exception occured in showUser", error, stacktrace);
      throw ServerException.withError(error: error);
    }

    return data;
  }

  @override
  Future<UserModel> showUser(int id) async {
    UserModel data;
    try {
      data = await userRestApiClient.showUser(id);
    } catch (error, stacktrace) {
      logger.severe("Exception occured in showUser", error, stacktrace);
      throw ServerException.withError(error: error);
    }

    return data;
  }

  @override
  Future<UserModel> updateUser(UserModel user) async {
    UserModel data;
    try {
      data = await userRestApiClient.updateUser(user.id, user);
    } catch (error, stacktrace) {
      logger.severe("Exception occured in updateUser" , error, stacktrace);
      throw ServerException.withError(error: error);
    }

    return data;
  }

}