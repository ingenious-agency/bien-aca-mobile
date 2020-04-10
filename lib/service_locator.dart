import 'package:get_it/get_it.dart';
import 'package:bien_aca_quarantine/services/NavigationService.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
}
