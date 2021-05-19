import 'package:local_people_core/profile.dart';
import 'package:meta/meta.dart';
import 'package:logging/logging.dart';

import '../../domain/entities/client_profile.dart';
import '../../domain/entities/client_response.dart';
import '../../domain/entities/trader_profile.dart';
import '../../domain/entities/trader_response.dart';

import '../../domain/repositories/profile_repository.dart';
import '../datasources/client_remote_data_source.dart';
import '../datasources/trader_remote_data_source.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final logger = Logger("ProfileRepositoryImpl");
  final ClientRemoteDataSource clientRemoteDataSource;
  final TraderRemoteDataSource traderRemoteDataSource;

  ProfileRepositoryImpl({
    @required this.clientRemoteDataSource,
    @required this.traderRemoteDataSource
  }) : assert(clientRemoteDataSource != null), assert(traderRemoteDataSource != null);

  @override
  Future<ClientResponse> createClientProfile(ClientModel model) async {
    ClientResponse response;

    try {
      //ClientModel model = ClientModel.fromClientProfile(client);
      response = await clientRemoteDataSource.createClient(model);
      if (response != null && response.exception != null) {
        logger.severe("Exception occured in createClientProfile", response.exception);
      }
    } catch (error, stacktrace) {
      logger.severe("Exception occured in createClientProfile", error, stacktrace);
      response = error;
    }

    return response;
  }

  @override
  Future<TraderResponse> createTraderProfile(TraderModel model) async {
    TraderResponse response;

    try {
      //TraderModel model = TraderModel.fromTraderProfile(trader);
      response = await traderRemoteDataSource.createTrader(model);
      if (response != null && response.exception != null) {
        logger.severe("Exception occured in createTraderProfile", response.exception);
      }
    } catch (error, stacktrace) {
      logger.severe("Exception occured in createTraderProfile", error, stacktrace);
      response = error;
    }

    return response;
  }

  @override
  Future<ClientResponse> findClientProfileWithEmail(String email) async {
    ClientResponse response;

    try {
      response = await clientRemoteDataSource.findClientWithEmail(email);
      if (response != null && response.exception != null) {
        logger.severe("Exception occured in findClientProfileWithEmail", response.exception);
      }
    } catch (error, stacktrace) {
      logger.severe("Exception occured in findClientProfileWithEmail", error, stacktrace);
    }

    return response;
  }

  @override
  Future<TraderResponse> findTraderProfileWithEmail(String email) async {
    TraderResponse response;

    try {
      response = await traderRemoteDataSource.findTraderWithEmail(email);
      if (response != null && response.exception != null) {
        logger.severe("Exception occured in findTraderProfileWithEmail", response.exception);
      }
    } catch (error, stacktrace) {
      logger.severe("Exception occured in findTraderProfileWithEmail", error, stacktrace);
    }

    return response;
  }

  @override
  Future<ClientResponse> getClientProfile(int id) async {
    ClientResponse response;

    try {
      response = await clientRemoteDataSource.showClient(id);
      if (response != null && response.exception != null) {
        logger.severe("Exception occured in getClientProfile", response.exception);
      }
    } catch (error, stacktrace) {
      logger.severe("Exception occured in getClientProfile", error, stacktrace);
    }

    return response;
  }

  @override
  Future<TraderResponse> getTraderProfile(int id) async {
    TraderResponse response;

    try {
      response = await traderRemoteDataSource.showTrader(id);
      if (response != null && response.exception != null) {
        logger.severe("Exception occured in getTraderProfile", response.exception);
      }
    } catch (error, stacktrace) {
      logger.severe("Exception occured in getTraderProfile", error, stacktrace);
    }

    return response;
  }

  @override
  Future<ClientResponse> updateClientProfile(ClientModel model) async {
    ClientResponse response;

    try {
      //ClientModel model = ClientModel.fromClientProfile(client);
      response = await clientRemoteDataSource.updateClient(model);
      if (response != null && response.exception != null) {
        logger.severe("Exception occured in findTraderProfileWithEmail", response.exception);
      }
    } catch (error, stacktrace) {
      logger.severe("Exception occured in findTraderProfileWithEmail", error, stacktrace);
    }

    return response;
  }

  @override
  Future<TraderResponse> updateTraderProfile(TraderModel model) async {
    TraderResponse response;

    try {
      //TraderModel model = TraderModel.fromTraderProfile(trader);
      response = await traderRemoteDataSource.updateTrader(model);
      if (response != null && response.exception != null) {
        logger.severe("Exception occured in findTraderProfileWithEmail", response.exception);
      }
    } catch (error, stacktrace) {
      logger.severe("Exception occured in findTraderProfileWithEmail", error, stacktrace);
    }

    return response;
  }

  @override
  Future<TraderListResponse> getTopRatedTrader() async {
    TraderListResponse response;

    try {
      response = await traderRemoteDataSource.listTopRatedTraders();
      if (response != null && response.exception != null) {
        logger.severe("Exception occured in getTopRatedTrader", response.exception);
      }
    } catch (error, stacktrace) {
      logger.severe("Exception occured in getTopRatedTrader", error, stacktrace);
      response = error;
    }

    return response;
  }

}