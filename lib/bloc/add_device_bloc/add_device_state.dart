part of 'add_device_bloc.dart';

@immutable
sealed class AddDeviceState {}

final class AddDeviceInitial extends AddDeviceState {}

final class AddDeviceLoading extends AddDeviceState {}

final class AddDeviceLoaded extends AddDeviceState {
  final AddItemModel model;
  final List<String> accessories;
  final List<AccessoryTypeEntity> accessoriesType;
  AddDeviceLoaded({required this.model, required this.accessories, required this.accessoriesType});
}
