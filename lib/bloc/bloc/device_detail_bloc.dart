import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'device_detail_event.dart';
part 'device_detail_state.dart';

class DeviceDetailBloc extends Bloc<DeviceDetailEvent, DeviceDetailState> {
  DeviceDetailBloc() : super(DeviceDetailInitial()) {
    on<DeviceDetailEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
