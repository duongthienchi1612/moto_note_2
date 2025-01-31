import '../../constants.dart';
import '../../model/device_entity.dart';
import '../base/base_repository.dart';
import '../interface/devices_repository.dart';

class DeviceRepository extends BaseRepository<DeviceEntity> implements IDeviceRepository {
  DeviceRepository() : super(DatabaseName.moteNote);

  @override
  Future<List<DeviceEntity>> getAllDevice() async {
    final listContact = await list(null, null, null, null, null);
    return listContact;
  }
}
