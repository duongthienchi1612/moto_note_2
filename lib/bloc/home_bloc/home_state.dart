part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoaded extends HomeState {
  final List<DeviceEntity> data;
  final int currentKm;

  HomeLoaded({required this.data, required this.currentKm});
}
