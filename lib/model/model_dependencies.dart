import 'package:get_it/get_it.dart';

import 'master_data/accessory_entity.dart';

class ModelDependencies {
  static void init(GetIt injector) {
    injector.registerFactory<AccessoryEntity>(() => AccessoryEntity());
  }
}
