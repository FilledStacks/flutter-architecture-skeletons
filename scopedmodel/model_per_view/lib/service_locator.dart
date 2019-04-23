import 'package:get_it/get_it.dart';
import 'package:model_per_view/scoped_models/home_view_model.dart';
import 'package:model_per_view/scoped_models/results_view_model.dart';
import 'package:model_per_view/scoped_models/login_view_model.dart';
import 'package:model_per_view/scoped_models/sign_up_view_model.dart';

import 'package:model_per_view/services/user_service.dart';
import 'package:model_per_view/services/web_service.dart';

GetIt locator = new GetIt();

void setupLocator() {
  // Register services
  locator.registerLazySingleton<WebService>(() => WebService());
  locator.registerLazySingleton<UserService>(() => UserService());
  
  // Register ScopedModels
  locator.registerFactory<HomeModel>(() => HomeModel());
  locator.registerFactory<ResultsModel>(() => ResultsModel());
  locator.registerFactory<LoginModel>(() => LoginModel());
  locator.registerFactory<SignUpModel>(() => SignUpModel());
}

