import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../dependencies.dart';
import '../../model/device_entity.dart';
import '../../repository/interface/devices_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {

  final deviceRepository = injector.get<IDeviceRepository>();
  HomeBloc() : super(HomeInitial()) {
    on<LoadData>(_onLoadData);
  }

  Future<void> _onLoadData(LoadData event, Emitter<HomeState> emit) async {
    final data = await deviceRepository.getAllDevice();
    emit(HomeLoaded(data));
  }
}
