import '../../model/master_data/accessory_type_entity.dart';
import '../base/base_repository.dart';
import '../interface/accessory_type_repository.dart';

class AccessoryTypeRepository extends BaseReadRepository<AccessoryTypeEntity> implements IAccessoryTypeRepository{
  AccessoryTypeRepository() : super();
}