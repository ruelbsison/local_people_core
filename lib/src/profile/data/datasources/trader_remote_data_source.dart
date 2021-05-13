import '../../domain/entities/trader_list_response.dart';
import '../../domain/entities/trader_response.dart';
import '../models/trader_model.dart';
import '../../../core/exceptions/server_exception.dart';

abstract class TraderRemoteDataSource {
  Future<TraderListResponse> listTraders();

  Future<TraderResponse> createTrader(TraderModel Trader);

  Future<TraderResponse> showTrader(int id);

  Future<TraderResponse> updateTrader(TraderModel Trader);

  Future<TraderResponse> findTraderWithEmail(String email_address);

  Future<ServerException> deleteTrader(int id);
}