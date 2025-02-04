part of 'add_device_bloc.dart';

@immutable
sealed class AddDeviceEvent {}

final class LoadData extends AddDeviceEvent {
  final String? deviceId;
  final bool isAddNew;
  LoadData({this.deviceId, this.isAddNew = false});
}

final class OnChange extends AddDeviceEvent {
  final AddItemModel model;
  OnChange(this.model);
}

final class OnSave extends AddDeviceEvent {
  final AddItemModel model;
  OnSave(this.model);
}
