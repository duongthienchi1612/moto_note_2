import '../dependencies.dart';
import '../model/master_data/accessory_entity.dart';
import '../model/master_data/accessory_type_entity.dart';
import '../repository/interface/accessory_repository.dart';
import '../repository/interface/accessory_type_repository.dart';

class MasterDataBusiness {
  MasterDataBusiness();

  final _accessoryRepository = injector.get<IAccessoryRepository>();
  final _accessoryTypeRepository = injector.get<IAccessoryTypeRepository>();

  List<AccessoryEntity>? accessories;
  List<AccessoryTypeEntity>? accessoriesType;

  Future init() async {
    accessories = await _accessoryRepository.listAll();
    accessoriesType = await _accessoryTypeRepository.listAll();
  }
}
