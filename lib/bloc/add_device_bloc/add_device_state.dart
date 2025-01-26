part of 'add_device_bloc.dart';

@immutable
sealed class AddDeviceState {}

final class AddDeviceInitial extends AddDeviceState {}

final class AddDeviceLoading extends AddDeviceState {}

final class AddDeviceLoaded extends AddDeviceState {
  final List<AccessoryTypeEntity> accessoriesType;
  AddDeviceLoaded({required this.accessoriesType});
}
