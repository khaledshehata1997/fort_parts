import 'package:data_access/src/interfaces/i_api_repository.dart';
import 'package:data_access/src/interfaces/i_authentication_repository.dart';
import 'package:data_access/src/interfaces/i_settings_repository.dart';
import 'package:data_access/src/repositories/api_repository.dart';
import 'package:data_access/src/repositories/authentication_repository.dart';
import 'package:data_access/src/repositories/settings_repository.dart';
import 'package:get_it/get_it.dart';

final GetIt sl = GetIt.instance;

Future<void> initDependencyInjection() async {
  sl.registerLazySingleton<IApiRepository>(() => ApiRepository());
  sl.registerLazySingleton<IAuthenticationRepository>(() => AuthenticationRepository());
  sl.registerLazySingleton<ISettingsRepository>(() => SettingsRepository());
}
