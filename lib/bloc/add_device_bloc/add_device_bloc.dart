import 'package:basic_utils/basic_utils.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../business/master_data_business.dart';
import '../../dependencies.dart';
import '../../model/device_entity.dart';
import '../../model/master_data/accessory_entity.dart';
import '../../model/master_data/accessory_type_entity.dart';
import '../../model/view/add_item_model.dart';
import '../../repository/interface/devices_repository.dart';
import '../../utilities/localization_helper.dart';
import '../../utilities/static_var.dart';

part 'add_device_event.dart';
part 'add_device_state.dart';

class AddDeviceBloc extends Bloc<AddDeviceEvent, AddDeviceState> {
  final masterData = injector.get<MasterDataBusiness>();
  final deviceRepo = injector.get<IDeviceRepository>();
  final localizations = LocalizationHelper.instance;

  late List<String> accessories;
  late List<AccessoryTypeEntity> accessoriesType;
  late bool isAddNew;
  String? deviceId;
  AddItemModel model = AddItemModel();

  AddDeviceBloc() : super(AddDeviceInitial()) {
    on<LoadData>(_onLoadData);
    on<OnChange>(_onChange);
  }

  Future<void> _onLoadData(LoadData event, Emitter<AddDeviceState> emit) async {
    accessoriesType = masterData.accessoriesType!;
    accessories = masterData.accessories!.map((e) => e.nameVi!).toList();
    isAddNew = event.isAddNew;
    if (StringUtils.isNotNullOrEmpty(event.deviceId)) {
      deviceId = event.deviceId;
      final item = await deviceRepo.getById(event.deviceId!);
      model
        ..deviceName = item!.deviceName
        ..deviceTypeId = item.deviceTypeId
        ..lastReplacementKm = item.lastReplacementKm
        ..lastReplacementDate = item.lastReplacementDate
        ..nextReplacementKm = item.nextReplacementKm
        ..note = item.note;
      emit(AddDeviceLoaded(model: model, accessories: accessories, accessoriesType: accessoriesType));
      return;
    }
    emit(AddDeviceLoaded(model: model, accessories: accessories, accessoriesType: accessoriesType));
  }

  Future<void> _onChange(OnChange event, Emitter<AddDeviceState> emit) async {
    model = event.model;
    emit(AddDeviceLoaded(model: model, accessories: accessories, accessoriesType: accessoriesType));
  }

  Future<void> onSave(AddItemModel model) async {
    if (isAddNew) {
      final item = DeviceEntity()
        ..userId = StaticVar.currentUserId
        ..deviceName = model.deviceName
        ..deviceTypeId = model.deviceTypeId
        ..lastReplacementKm = model.lastReplacementKm
        ..lastReplacementDate = model.lastReplacementDate
        ..nextReplacementKm = model.nextReplacementKm
        ..note = model.note;
      await deviceRepo.insert(item);
    } else {
      final item = await deviceRepo.getById(deviceId!);
      item!
        ..deviceName = model.deviceName
        ..deviceTypeId = model.deviceTypeId
        ..lastReplacementKm = model.lastReplacementKm
        ..lastReplacementDate = model.lastReplacementDate
        ..nextReplacementKm = model.nextReplacementKm
        ..note = model.note;
      await deviceRepo.update(item);
    }
  }

  String? validateForm(AddItemModel model) {
    if (StringUtils.isNullOrEmpty(model.deviceName)) {
      emit(AddDeviceLoaded(model: model, accessories: accessories, accessoriesType: accessoriesType));
      return localizations.emptyDeviceName;
    }
    return null;
  }
}
