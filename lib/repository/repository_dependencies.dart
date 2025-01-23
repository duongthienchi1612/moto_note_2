import 'package:get_it/get_it.dart';

import 'interface/accessory_repository.dart';
import 'master_data/accessory_repository.dart';

class RepositoryDependencies {
  static void init(GetIt injector) {
    injector.registerLazySingleton<IAccessoryRepository>(() => AccessoryRepository());
  }
}
