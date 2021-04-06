import 'package:meta/meta.dart';
import 'package:logging/logging.dart';

import '../../../../core.dart';
import 'user_rest_api_client.dart';
import '../models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<List<UserModel>> listUsers();

  Future<UserModel> createUser(UserModel user);

  Future<UserModel> showUser(int id);

  Future<UserModel> updateUser(UserModel user);

  Future<void> deleteUser(int id);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final logger = Logger("UserRemoteDataSourceImpl");
  final UserRestApiClient userRestApiClient;

  UserRemoteDataSourceImpl({
    @required this.userRestApiClient
  })  : assert(userRestApiClient != null);

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