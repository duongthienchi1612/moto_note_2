import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../business/master_data_business.dart';
import '../../dependencies.dart';
import '../../model/master_data/accessory_type_entity.dart';

part 'add_device_event.dart';
part 'add_device_state.dart';

class AddDeviceBloc extends Bloc<AddDeviceEvent, AddDeviceState> {
  final masterData = injector.get<MasterDataBusiness>();
  late List<AccessoryTypeEntity> accessoriesType;

  AddDeviceBloc() : super(AddDeviceInitial()) {
    on<LoadData>(_onLoadData);
  }

  Future<void> _onLoadData(LoadData event, Emitter<AddDeviceState> emit) async {
    accessoriesType = masterData.accessoriesType!;
    emit(AddDeviceLoaded(accessoriesType: accessoriesType));
  }
}
