import '../../constants.dart';
import '../../model/device_entity.dart';
import '../base/base_repository.dart';
import '../interface/devices_repository.dart';

class DeviceRepository extends BaseRepository<DeviceEntity> implements IDeviceRepository {
  DeviceRepository() : super(DatabaseName.moteNote);

  @override
  Future<List<DeviceEntity>> getAllDeviceByUserId(String userId) async {
    final condition = "user_id = '$userId'";
    final listContact = await list(condition, null, null, null, null);
    return listContact;
  }
}
