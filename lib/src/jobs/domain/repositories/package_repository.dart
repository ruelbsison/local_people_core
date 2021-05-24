
import '../entities/package.dart';
import '../entities/package_response.dart';
import '../entities/package_list_response.dart';

abstract class PackageRepository {
  Future<PackageListResponse> listTraderPackages(int traderId);

  Future<PackageResponse> createPackage(Package package);

  Future<PackageResponse> showPackage(int id);

  Future<PackageResponse> updatePackage(Package package);

  Future<Exception> deletePackage(int id);
}