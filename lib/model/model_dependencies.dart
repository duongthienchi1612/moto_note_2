import 'package:get_it/get_it.dart';

import 'device_entity.dart';
import 'master_data/accessory_entity.dart';
import 'master_data/accessory_type_entity.dart';
import 'user_entity.dart';

class ModelDependencies {
  static void init(GetIt injector) {
    // master data
    injector.registerFactory<AccessoryEntity>(() => AccessoryEntity());
    injector.registerFactory<AccessoryTypeEntity>(() => AccessoryTypeEntity());

    // user data 
    injector.registerFactory<DeviceEntity>(() => DeviceEntity());
    injector.registerFactory<UserEntity>(() => UserEntity());
  }
}
