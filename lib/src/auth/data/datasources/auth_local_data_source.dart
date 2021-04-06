import 'package:meta/meta.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../core/configs/auth_config.dart';
import '../models/auth_local_model.dart';

abstract class AuthLocalDataSource {
  Future<bool> didAuthExpired();

  Future<bool> hasAuth();

  Future<bool> saveAuth(AuthLocalModel authLocal);

  Future<String> getUserName();

  Future<bool> deleteAuth();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();
  final AuthorizationConfig authorizationConfig;


  AuthLocalDataSourceImpl({
    @required this.authorizationConfig
  })  : assert(authorizationConfig != null);

  Future<bool> hasAuth() async {
    try {
      final String storedUserIdK =
      await secureStorage.read(key: authorizationConfig.authUserIdKey);
      if (storedUserIdK == null) return false;
    } on Exception catch (e, s) {
      return false;
    }
    return true;
  }

  Future<bool> saveAuth(AuthLocalModel authLocal) async {
    try {
      await secureStorage.write(
          key: authorizationConfig.authUserIdKey,
          value: authLocal.userId.toString());

      await secureStorage.write(
          key: authorizationConfig.authUserNameKey,
          value: authLocal.userName);

      await secureStorage.write(
          key: authorizationConfig.authUserEmailKey,
          value: authLocal.userEmail);

      await secureStorage.write(
          key: authorizationConfig.authUserTokenKey,
          value: authLocal.token);

      await secureStorage.write(
          key: authorizationConfig.authUserTokenDateKey,
          value: authLocal.tokenExpirationDate.millisecondsSinceEpoch.toString());
    } on Exception catch (e, s) {
      return false;
    }
    return true;
  }

  Future<bool> didAuthExpired() async {
    try {
      final String storedUserTokenDate =
      await secureStorage.read(key: authorizationConfig.authUserTokenDateKey);
      if (storedUserTokenDate == null) return true;

      DateTime tokenExpirationDate = DateTime.fromMillisecondsSinceEpoch(int.parse(storedUserTokenDate));
      DateTime currentDateTime = DateTime.now();
      return currentDateTime.isAfter(tokenExpirationDate);
    } on Exception catch (e, s) {
      return true;
    }
  }

  Future<bool> deleteAuth() async {
    try {
      await secureStorage.delete(key: authorizationConfig.authUserIdKey);

      await secureStorage.delete(key: authorizationConfig.authUserNameKey);

      await secureStorage.delete(key: authorizationConfig.authUserEmailKey);

      await secureStorage.delete(key: authorizationConfig.authUserTokenKey);

      await secureStorage.delete(key: authorizationConfig.authUserTokenDateKey);
    } on Exception {
      return false;
    }

    return true;
  }

  Future<String> getUserName() async {
    try {
      final String storedUserName =
      await secureStorage.read(key: authorizationConfig.authUserNameKey);
      if (storedUserName == null) return '';

      return storedUserName;
    } on Exception catch (e, s) {
      return '';
    }
  }
}