import 'package:get_it/get_it.dart';
import 'package:local_people_core/core.dart';
import 'package:local_people_core/auth.dart';
import 'package:local_people_core/profile.dart';
import 'package:local_people_core/jobs.dart';

final sl = GetIt.instance; //sl is referred to as Service Locator

//Dependency injection
Future<void> locatorInit(AuthorizationConfig authorizationConfig) async {
  sl.registerLazySingleton(() => DialogService());

  sl.registerLazySingleton<AuthLocalDataSource>(
        () => AuthLocalDataSourceImpl(
      authorizationConfig: authorizationConfig,
     ),
  );
  sl.registerLazySingleton<List<Tag>>(
        () => [],
  );
}

Future<void> locatorAddClientProfile(ClientProfile clientProfile) async {
  sl.registerLazySingleton<ClientProfile>(
        () => clientProfile,
  );
}

Future<void> locatorAddTraderProfile(TraderProfile traderProfile) async {
  sl.registerLazySingleton<TraderProfile>(
        () => traderProfile,
  );
}

// Future<void> locatorAddListTag(List<Tag> tags) async {
//   sl.registerLazySingleton<List<Tag>>(
//         () => tags,
//   );
// }