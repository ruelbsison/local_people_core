import '../../domain/entities/package.dart';
import '../models/package_model.dart';
import '../../domain/entities/package_list_response.dart';

import '../../domain/entities/package_response.dart';
import '../../domain/repositories/package_repository.dart';
import '../datasources/package_remote_data_source.dart';
import 'package:meta/meta.dart';
import 'package:logging/logging.dart';
import 'package:local_people_core/core.dart';

class PackageRepositoryImpl extends PackageRepository {
  final logger = Logger("PackageRepositoryImpl");
  final NetworkInfo networkInfo;
  final PackageRemoteDataSource packageRemoteDataSource;

  PackageRepositoryImpl({
    @required this.networkInfo,
    @required this.packageRemoteDataSource
  }) : assert(networkInfo != null), assert(packageRemoteDataSource != null);

  @override
  Future<PackageResponse> createPackage(Package Package) async {
    PackageResponse response = PackageResponse();
    if (await networkInfo.isConnected) {
      try {
        PackageModel model = PackageResponse.fromPackage(Package);
        response = await packageRemoteDataSource.createPackage(model);
        if (response.exception != null) {
          logger.severe("Exception occured in createPackage", response.exception);
        }
      } catch (error, stacktrace) {
        logger.severe("Exception occured in createPackage", error, stacktrace);
        response.exception = Exception(error.toString());
      }
    } else {
      response.exception = InternetConnectionException();
    }

    return response;
  }

  @override
  Future<Exception> deletePackage(int id) async {
    Exception exception;
    if (await networkInfo.isConnected) {
      try {
        await packageRemoteDataSource.deletePackage(id);
      } catch (error, stacktrace) {
        logger.severe("Exception occured in deletePackage", error, stacktrace);
        exception = Exception(error.toString());
      }
    } else {
      exception = InternetConnectionException();
    }

    return exception;
  }

  @override
  Future<PackageListResponse> listTraderPackages(int trader_id) async {
    PackageListResponse response = PackageListResponse();
    if (await networkInfo.isConnected) {
      try {
        response = await packageRemoteDataSource.listTraderPackages(trader_id);
        if (response.exception != null) {
          logger.severe("Exception occured in listTraderPackages", response.exception);
        }
      } catch (error, stacktrace) {
        logger.severe("Exception occured in listTraderPackages", error, stacktrace);
        response.exception = Exception(error.toString());
      }
    } else {
      response.exception = InternetConnectionException();
    }

    return response;
  }

  @override
  Future<PackageResponse> showPackage(int id) async {
    PackageResponse response = PackageResponse();
    if (await networkInfo.isConnected) {
      try {
        response = await packageRemoteDataSource.showPackage(id);
        if (response.exception != null) {
          logger.severe("Exception occured in showPackage", response.exception);
        }
      } catch (error, stacktrace) {
        logger.severe("Exception occured in showPackage", error, stacktrace);
        response.exception = Exception(error.toString());
      }
    } else {
      response.exception = InternetConnectionException();
    }

    return response;
  }

  @override
  Future<PackageResponse> updatePackage(Package Package) async {
    PackageResponse response = PackageResponse();
    if (await networkInfo.isConnected) {
      try {
        PackageModel model = PackageResponse.fromPackage(Package);
        response = await packageRemoteDataSource.updatePackage(model);
        if (response.exception != null) {
          logger.severe("Exception occured in updatePackage", response.exception);
        }
      } catch (error, stacktrace) {
        logger.severe("Exception occured in updatePackage", error, stacktrace);
        response.exception = Exception(error.toString());
      }
    } else {
      response.exception = InternetConnectionException();
    }

    return response;
  }

}