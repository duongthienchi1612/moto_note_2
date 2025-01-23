import '../dependencies.dart';
import '../model/master_data/accessory_entity.dart';
import '../repository/master_data/accessory_repository.dart';

class MasterDataBusiness {

  List<AccessoryEntity>? accessories;

  final _accessoryRepository = injector.get<AccessoryRepository>();

  MasterDataBusiness();

  Future init() async {
    accessories = await _accessoryRepository.listAll();
  }
}
