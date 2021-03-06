import '../entities/client_profile.dart';
import '../entities/client_response.dart';
import '../entities/trader_profile.dart';
import '../entities/trader_response.dart';
import '../entities/trader_list_response.dart';
import 'package:local_people_core/profile.dart';

abstract class ProfileRepository {
  Future<ClientResponse> findClientProfileWithEmail(String email);

  Future<ClientResponse> getClientProfile(int id);

  Future<ClientResponse> createClientProfile(ClientProfile profile);

  Future<ClientResponse> updateClientProfile(ClientProfile profile);

  Future<TraderResponse> findTraderProfileWithEmail(String email);

  Future<TraderResponse> getTraderProfile(int id);

  Future<TraderResponse> createTraderProfile(TraderProfile profile);

  Future<TraderResponse> updateTraderProfile(TraderProfile profile);

  Future<TraderListResponse> getTopRatedTrader();

}