import '../../model/device_entity.dart';
import '../base/interface.dart';

abstract class IDeviceRepository extends IBaseRepository<DeviceEntity> {
  Future<List<DeviceEntity>> getAllDeviceByUserId(String userId);
}
