import '../models/package_model.dart';
import '../../domain/entities/package_list_response.dart';
import '../../domain/entities/package_response.dart';

abstract class PackageRemoteDataSource {
  Future<PackageListResponse> listTraderPackages(int traderId);

  Future<PackageResponse> createPackage(PackageModel package);

  Future<PackageResponse> showPackage(int id);

  Future<PackageResponse> updatePackage(PackageModel package);

  Future<Exception> deletePackage(int id);
}