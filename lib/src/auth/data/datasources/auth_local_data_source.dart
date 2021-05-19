import 'package:meta/meta.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../core/configs/auth_config.dart';
import '../models/auth_local_model.dart';
import 'package:logging/logging.dart';
//import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDataSource {
  Future<bool> didAuthExpired();

  Future<bool> hasAuth();

  Future<bool> saveAuth(AuthLocalModel authLocal);

  Future<String> getUserName();

  Future<bool> deleteAuth();

  Future<AuthLocalModel> getAuth();

  Future<String> getEmail();

  Future<int> getUserId();

  Future<String> getToken();

}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final logger = Logger("AuthLocalDataSourceImpl");
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();
  final AuthorizationConfig authorizationConfig;

  AuthLocalDataSourceImpl({
    @required this.authorizationConfig
  })  : assert(authorizationConfig != null);

  Future<bool> hasAuth() async {
    try {
      logger.info('hasAuth:');

      //SharedPreferences prefs = await SharedPreferences.getInstance();
      //String storedUserToken = await prefs.getString(authorizationConfig.authUserTokenKey);
      final String storedUserToken = await secureStorage.read(key: authorizationConfig.authUserTokenKey);
      if (storedUserToken == null) {
        logger.info('hasAuth: storedUserToken is null');
      } else {
        logger.info('hasAuth: storedUserToken: ' + storedUserToken);
      }
      if (storedUserToken == null) return false;
    } on Exception catch (e, s) {
      throw e;
    }
    return true;
  }

  Future<bool> saveAuth(AuthLocalModel authLocal) async {
      //SharedPreferences prefs = await SharedPreferences.getInstance();
      if (authLocal.userId != null) {
        try {
          await secureStorage.write(
              key: authorizationConfig.authUserIdKey,
              value: authLocal.userId.toString(),
          );
          // await prefs.setInt(
          //   authorizationConfig.authUserIdKey,
          //   authLocal.userId,
          // );
        } on Exception catch (error, stacktrace) {
          logger.severe("Exception occured in saveAuth $error $stacktrace", error, stacktrace);
        }
      }

      if (authLocal.userFullName != null) {
        try {
          await secureStorage.write(
              key: authorizationConfig.authUserNameKey,
              value: authLocal.userFullName);
          // await prefs.setString(
          //     authorizationConfig.authUserNameKey,
          //     authLocal.userFullName);
        } on Exception catch (error, stacktrace) {
          logger.severe("Exception occured in saveAuth $error $stacktrace", error, stacktrace);
        }
      }

      if (authLocal.userEmail != null) {
        try {
          await secureStorage.write(
              key: authorizationConfig.authUserEmailKey,
              value: authLocal.userEmail);
          // await prefs.setString(
          //     authorizationConfig.authUserEmailKey,
          //     authLocal.userEmail);
        } on Exception catch (error, stacktrace) {
          logger.severe("Exception occured in saveAuth $error $stacktrace", error, stacktrace);
        }
      }


      if (authLocal.userPhoto != null) {
        try {
          await secureStorage.write(
              key: authorizationConfig.authUserPhotoKey,
              value: authLocal.userPhoto);
          // await prefs.setString(
          //     authorizationConfig.authUserPhotoKey,
          //     authLocal.userPhoto);
        } on Exception catch (error, stacktrace) {
          logger.severe("Exception occured in saveAuth $error $stacktrace", error, stacktrace);
        }
      }


      if (authLocal.token != null) {
        try {
          logger.info('Writing token: ' + authLocal.token);

          await secureStorage.write(
              key: authorizationConfig.authUserTokenKey,
              value: authLocal.token);
          // await prefs.setString(
          //     authorizationConfig.authUserTokenKey,
          //     authLocal.token);
          logger.info('Writing token ok: ' + authLocal.token);
        } on Exception catch (error, stacktrace) {
          logger.severe("Exception occured in saveAuth $error $stacktrace", error, stacktrace);
        }
      }


      if (authLocal.tokenExpirationDate != null) {
        try {
          await secureStorage.write(
              key: authorizationConfig.authUserTokenDateKey,
              value: authLocal.tokenExpirationDate.millisecondsSinceEpoch.toString());
          // await prefs.setString(
          //     authorizationConfig.authUserTokenDateKey,
          //     authLocal.tokenExpirationDate.millisecondsSinceEpoch.toString());
        } on Exception catch (error, stacktrace) {
          logger.severe("Exception occured in saveAuth $error $stacktrace", error, stacktrace);
        }
      }

      //prefs.commit();
    return true;
  }

  Future<bool> didAuthExpired() async {
    try {
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // final String storedUserTokenDate =
      // await prefs.getString(authorizationConfig.authUserTokenDateKey);
      final String storedUserTokenDate =
        await secureStorage.read(key: authorizationConfig.authUserTokenDateKey);
      if (storedUserTokenDate == null) return true;

      DateTime tokenExpirationDate = DateTime.fromMillisecondsSinceEpoch(int.parse(storedUserTokenDate));
      DateTime currentDateTime = DateTime.now();
      return currentDateTime.isAfter(tokenExpirationDate);
    } on Exception catch (e, s) {
      throw e;
    }
  }

  Future<bool> deleteAuth() async {
    logger.info('deleteAuth');

    try {
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // await prefs.remove(authorizationConfig.authUserIdKey);
      //
      // await prefs.remove(authorizationConfig.authUserNameKey);
      //
      // await prefs.remove(authorizationConfig.authUserEmailKey);
      //
      // await prefs.remove(authorizationConfig.authUserPhotoKey);
      //
      // await prefs.remove(authorizationConfig.authUserTokenKey);
      //
      // await prefs.remove(authorizationConfig.authUserTokenDateKey);

      await secureStorage.delete(key: authorizationConfig.authUserIdKey);

      await secureStorage.delete(key: authorizationConfig.authUserNameKey);

      await secureStorage.delete(key: authorizationConfig.authUserEmailKey);

      await secureStorage.delete(key: authorizationConfig.authUserPhotoKey);

      await secureStorage.delete(key: authorizationConfig.authUserTokenKey);

      await secureStorage.delete(key: authorizationConfig.authUserTokenDateKey);
    } on Exception catch (e, s) {
      throw e;
    }

    return true;
  }

  Future<String> getUserName() async {
    try {
      final String storedUserName =
        await secureStorage.read(key: authorizationConfig.authUserNameKey);
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // final String storedUserName =
      //   await prefs.getString(authorizationConfig.authUserNameKey);
      if (storedUserName == null) return '';

      return storedUserName;
    } on Exception catch (e, s) {
      throw e;
    }
  }

  @override
  Future<AuthLocalModel> getAuth() async {
    AuthLocalModel authLocalModel;
    try {
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // int userId = await prefs.getInt(authorizationConfig.authUserIdKey);
      // String userFullName = await prefs.getString(authorizationConfig.authUserNameKey);
      // String email = await prefs.getString(authorizationConfig.authUserEmailKey);
      // String userPhoto = await prefs.getString(authorizationConfig.authUserPhotoKey);
      // String refreshToken = await prefs.getString(authorizationConfig.authUserTokenKey);
      // String expiredAt = await prefs.getString(authorizationConfig.authUserTokenDateKey);

      String userId = await secureStorage.read(key: authorizationConfig.authUserIdKey);
      String userFullName = await secureStorage.read(key: authorizationConfig.authUserNameKey);
      String email = await secureStorage.read(key: authorizationConfig.authUserEmailKey);
      String userPhoto = await secureStorage.read(key: authorizationConfig.authUserPhotoKey);
      String refreshToken = await secureStorage.read(key: authorizationConfig.authUserTokenKey);
      String expiredAt = await secureStorage.read(key: authorizationConfig.authUserTokenDateKey);

      DateTime tokenExpirationDate = DateTime.fromMillisecondsSinceEpoch(int.parse(expiredAt));
      authLocalModel = AuthLocalModel(
        userId:  int.parse(userId),
        userEmail: email,
        userFullName: userFullName,
        userPhoto: userPhoto,
        token: refreshToken,
        tokenExpirationDate: tokenExpirationDate,
      );
    } on Exception catch (e, s) {
      throw e;
    }
    return authLocalModel;
  }

  @override
  Future<String> getEmail() async {
    try {
      final String storedEmail =
          await secureStorage.read(key: authorizationConfig.authUserEmailKey);
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // final String storedEmail =
      //   await prefs.getString(authorizationConfig.authUserEmailKey);
      if (storedEmail == null) return '';

      return storedEmail;
    } on Exception catch (e, s) {
      throw e;
    }
  }

  @override
  Future<int> getUserId() async {
    try {
      final String storedUserId =
          await secureStorage.read(key: authorizationConfig.authUserIdKey);
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // final int storedUserId =
      //   await prefs.getInt(authorizationConfig.authUserIdKey);
      //return storedUserId;
      if (storedUserId == null) return 0;

      return int.parse(storedUserId);
    } on Exception catch (e, s) {
      throw e;
    }
  }

  @override
  Future<String> getToken() async {
    try {
      final String storedToken =
         await secureStorage.read(key: authorizationConfig.authUserTokenKey);
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // final String storedToken =
      //   await prefs.getString(authorizationConfig.authUserTokenKey);
      if (storedToken == null) return '';

      return storedToken;
    } on Exception catch (e, s) {
      throw e;
    }
  }
}