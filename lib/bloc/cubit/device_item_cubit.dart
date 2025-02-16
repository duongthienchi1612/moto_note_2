import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../constants.dart';

part 'device_item_state.dart';

class DeviceItemCubit extends Cubit<DeviceItemState> {
  DeviceItemCubit() : super(DeviceItemState(dx: 0));

  void updateDx(double dx) {
    if (dx < Constants.offsetShowIconDeleted) {
      dx = Constants.offsetShowIconDeleted;
    }
    if (dx > 0) {
      dx = 0;
    }
    emit(DeviceItemState(dx: dx));
  }

  void resetDx() {
    emit(DeviceItemState(dx: 0));
  }
}
