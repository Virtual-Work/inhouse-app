import 'package:get_it/get_it.dart';
import 'package:virtualworkng/core/Services/Api.dart';
import 'package:virtualworkng/core/Services/Authenticate/authentication.dart';
import 'package:virtualworkng/model/CRUDModel.dart';
import 'package:virtualworkng/util/customFunctions.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
locator.registerLazySingleton(() => AuthService());
locator.registerLazySingleton(() => Api());
locator.registerLazySingleton(() => CustomFunction());
}
