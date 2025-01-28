import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../business/master_data_business.dart';
import '../../dependencies.dart';
import '../../model/master_data/accessory_type_entity.dart';
import '../../model/view/add_item_model.dart';

part 'add_device_event.dart';
part 'add_device_state.dart';

class AddDeviceBloc extends Bloc<AddDeviceEvent, AddDeviceState> {
  final masterData = injector.get<MasterDataBusiness>();
  late List<AccessoryTypeEntity> accessoriesType;
  AddItemModel model = AddItemModel();

  AddDeviceBloc() : super(AddDeviceInitial()) {
    on<LoadData>(_onLoadData);
    on<OnChange>(_onChange);
  }

  Future<void> _onLoadData(LoadData event, Emitter<AddDeviceState> emit) async {
    
    accessoriesType = masterData.accessoriesType!;
    emit(AddDeviceLoaded(model: model, accessoriesType: accessoriesType));
  }

  Future<void> _onChange(OnChange event, Emitter<AddDeviceState> emit) async {
    model = event.model;
    log('---- onChange');
    emit(AddDeviceLoaded(model: model, accessoriesType: accessoriesType));
  }

  Future<void> onSave(AddItemModel model) async {
    // save vo data base
  }
}
