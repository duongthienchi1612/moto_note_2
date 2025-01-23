import '../../model/master_data/accessory_entity.dart';
import '../base/base_repository.dart';
import '../interface/accessory_repository.dart';

class AccessoryRepository extends BaseReadRepository<AccessoryEntity> implements IAccessoryRepository{
  AccessoryRepository() : super();
}