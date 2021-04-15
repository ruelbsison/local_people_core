import 'package:meta/meta.dart';
import 'package:logging/logging.dart';

import '../../../../core.dart';
import 'trader_rest_api_client.dart';
import '../models/user_model.dart';
import 'user_remote_data_source.dart';

class TraderRemoteDataSourceImpl implements UserRemoteDataSource {
  final logger = Logger("TraderRemoteDataSourceImpl");
  final TraderRestApiClient traderRestApiClient;

  TraderRemoteDataSourceImpl({
    @required this.traderRestApiClient
  })  : assert(traderRestApiClient != null);

  @override
  Future<UserModel> createUser(UserModel user) async {
    UserModel data;
    try {
      data = await traderRestApiClient.createUser(user.id, user);
    } catch (error, stacktrace) {
      logger.severe("Exception occured in createUser", error, stacktrace);
      throw ServerException.withError(error: error);
    }

    return data;
  }

  @override
  Future<void> deleteUser(int id) async {
    try {
      await traderRestApiClient.showUser(id);
    } catch (error, stacktrace) {
      logger.severe("Exception occured in showUser", error, stacktrace);
      throw ServerException.withError(error: error);
    }
  }

  @override
  Future<List<UserModel>> listUsers() async {
    List<UserModel> data;
    try {
      data = await traderRestApiClient.listUsers();
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
      data = await traderRestApiClient.showUser(id);
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
      data = await traderRestApiClient.updateUser(user.id, user);
    } catch (error, stacktrace) {
      logger.severe("Exception occured in updateUser" , error, stacktrace);
      throw ServerException.withError(error: error);
    }

    return data;
  }

}