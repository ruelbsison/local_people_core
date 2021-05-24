import '../models/package_model.dart';

import '../../domain/entities/package_list_response.dart';

import '../../domain/entities/package_response.dart';

import 'package_remote_data_source.dart';
import 'package_rest_api_client.dart';
import 'package:meta/meta.dart';
import 'package:logging/logging.dart';

class PackageRemoteDataSourceImpl implements PackageRemoteDataSource {
  final logger = Logger("PackageRemoteDataSourceImpl");
  final PackageRestApiClient packageRestApiClient;

  PackageRemoteDataSourceImpl({@required this.packageRestApiClient})
      : assert(packageRestApiClient != null);

  @override
  Future<PackageResponse> createPackage(PackageModel model) async {
    PackageResponse response = PackageResponse();
    try {
      var paramData = model.toJson();
      paramData.keys
          .where((k) => paramData[k] == null) // filter keys
          .toList() // create a copy to avoid concurrent modifications
          .forEach(paramData.remove); // remove selected keys
      Map<String, Map<String, dynamic>> param = Map<String, Map<String, dynamic>>();
      param['package'] = paramData;
      PackageModel data = await packageRestApiClient.createPackage(param);
      if (data != null) {
        response.fromModel(data);
      }
    } catch (error, stacktrace) {
      logger.severe("Exception occured in createPackage $error $stacktrace", error,
          stacktrace);
      response.exception = Exception(error.toString());
    }

    return response;
  }

  @override
  Future<Exception> deletePackage(int id) async {
    Exception response;
    try {
      await packageRestApiClient.deletePackage(id);
    } catch (error, stacktrace) {
      logger.severe("Exception occured in deletePackage $error $stacktrace", error,
          stacktrace);
      response = Exception(error.toString());
    }

    return response;
  }

  @override
  Future<PackageListResponse> listTraderPackages(int traderId) async {
    PackageListResponse response = PackageListResponse();
    try {
      List<PackageModel> data = await packageRestApiClient.listTraderPackages(traderId);
      if (data != null) {
        response.fromModel(data);
      }
    } catch (error, stacktrace) {
      logger.severe("Exception occured in listTraderPackages $error $stacktrace", error,
          stacktrace);
      response.exception = Exception(error.toString());
    }
    return response;
  }

  @override
  Future<PackageResponse> showPackage(int id) async {
    PackageResponse response = PackageResponse();
    try {
      PackageModel data = await packageRestApiClient.showPackage(id);
      if (data != null) {
        response.fromModel(data);
      }
    } catch (error, stacktrace) {
      logger.severe("Exception occured in listTraderPackages $error $stacktrace", error,
          stacktrace);
      response.exception = Exception(error.toString());
    }

    return response;
  }

  @override
  Future<PackageResponse> updatePackage(PackageModel model) async {
    PackageResponse response = PackageResponse();
    try {
      var paramData = model.toJson();
      paramData.keys
          .where((k) => paramData[k] == null) // filter keys
          .toList() // create a copy to avoid concurrent modifications
          .forEach(paramData.remove); // remove selected keys
      Map<String, Map<String, dynamic>> param = Map<String, Map<String, dynamic>>();
      param['package'] = paramData;
      PackageModel data = await packageRestApiClient.updatePackage(model.id, param);
      if (data != null) {
        response.fromModel(data);
      }
    } catch (error, stacktrace) {
      logger.severe("Exception occured in updatePackage $error $stacktrace", error,
          stacktrace);
      response.exception = Exception(error.toString());
    }

    return response;
  }

}
