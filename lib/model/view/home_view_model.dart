import '../device_entity.dart';
import '../user_entity.dart';

class HomeViewModel {
  List<DeviceEntity> data;
  int currentKm;
  UserEntity currentUser;
  List<UserEntity> users;

  HomeViewModel(this.data, this.currentKm, this.currentUser, this.users);
}
