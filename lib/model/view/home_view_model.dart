import '../device_entity.dart';
import '../user_entity.dart';

class HomeViewModel {
  List<DeviceEntity> data;
  int currentKm;
  UserEntity currentUser;
  List<UserEntity> users;
  bool isMenuOpen;

  HomeViewModel(this.data, this.currentKm, this.currentUser, this.users, this.isMenuOpen);

  HomeViewModel copyWith({
    bool? isMenuOpen,
    List<DeviceEntity>? data,
    int? currentKm,
    UserEntity? currentUser,
    List<UserEntity>? users,
  }) {
    return HomeViewModel(
      data ?? List.from(this.data),
      currentKm ?? this.currentKm,
      currentUser ?? this.currentUser,
      users ?? List.from(this.users),
      isMenuOpen ?? this.isMenuOpen,
    );
  }
}
