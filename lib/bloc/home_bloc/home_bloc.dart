import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:meta/meta.dart';

import '../../dependencies.dart';
import '../../model/device_entity.dart';
import '../../preference/user_reference.dart';
import '../../repository/interface/devices_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {

  final deviceRepository = injector.get<IDeviceRepository>();
  final userRef = injector.get<UserReference>();


  late List<DeviceEntity> data;
  int currentKm = 0;
  HomeBloc() : super(HomeInitial()) {
    on<LoadData>(_onLoadData);
    on<DeleteItem>(_onDeleteItem);
  }

  Future<void> _onLoadData(LoadData event, Emitter<HomeState> emit) async {
    data = await deviceRepository.getAllDevice();
    currentKm = await userRef.getCurrentKm() ?? 0;
    emit(HomeLoaded(data: data, currentKm: currentKm));
  }

  Future<void> _onDeleteItem(DeleteItem event, Emitter<HomeState> emit) async {
    final item = data.firstWhereOrNull((e) => e.id == event.id);
    await deviceRepository.delete(item);
    data.removeWhere((e) => e.id == event.id);
    emit(HomeLoaded(data: data, currentKm: currentKm));
  }

  Future<void> updateCurrentKm(int value) async {
    await userRef.setCurrentKm(value);
    add(LoadData());
  }
}
