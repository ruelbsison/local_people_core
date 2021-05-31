import 'package:get_it/get_it.dart';
import 'package:local_people_core/core.dart';
import 'package:local_people_core/auth.dart';

final sl = GetIt.instance; //sl is referred to as Service Locator

//Dependency injection
Future<void> locatorInit(AuthorizationConfig authorizationConfig) async {
  sl.registerLazySingleton<AuthLocalDataSource>(
        () => AuthLocalDataSourceImpl(
      authorizationConfig: authorizationConfig,
     ),
  );
}