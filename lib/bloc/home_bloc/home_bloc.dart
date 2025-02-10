import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:meta/meta.dart';

import '../../constants.dart';
import '../../dependencies.dart';
import '../../model/device_entity.dart';
import '../../model/option_model.dart';
import '../../model/user_entity.dart';
import '../../model/view/home_view_model.dart';
import '../../preference/user_reference.dart';
import '../../repository/interface/devices_repository.dart';
import '../../repository/interface/users_repository.dart';
import '../../utilities/static_var.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final deviceRepository = injector.get<IDeviceRepository>();
  final usersRepository = injector.get<IUserRepository>();
  final userRef = injector.get<UserReference>();

  late List<DeviceEntity> data;
  int currentKm = 0;
  HomeBloc() : super(HomeInitial()) {
    on<LoadData>(_onLoadData);
    on<DeleteItem>(_onDeleteItem);
    on<SortData>(_onSortData);
    on<UpdateCurrentKm>(_onUpdateCurrentKm);
    on<AddAccount>(_onAddAccount);
    on<SwitchAccount>(_onSwitchAccount);
    on<EditAccount>(_onEditAccount);
    on<DeleteAccount>(_onDeleteAccount);
  }

  Future<void> _onLoadData(LoadData event, Emitter<HomeState> emit) async {
    data = await deviceRepository.getAllDeviceByUserId(StaticVar.currentUserId);
    currentKm = await userRef.getCurrentKm() ?? 0;
    final user = await usersRepository.getById(StaticVar.currentUserId);
    final users = (await usersRepository.listAll())!.where((e) => e.id != StaticVar.currentUserId).toList();
    final model = HomeViewModel(data, currentKm, user!, users);
    emit(HomeLoaded(model));
  }

  Future<void> _onDeleteItem(DeleteItem event, Emitter<HomeState> emit) async {
    final currentState = state as HomeLoaded;
    final model = currentState.model;
    final item = data.firstWhereOrNull((e) => e.id == event.id);
    await deviceRepository.delete(item);

    model.data.removeWhere((e) => e.id == event.id);
    emit(HomeLoaded(model));
  }

  Future<void> _onSortData(SortData event, Emitter<HomeState> emit) async {
    final currentState = state as HomeLoaded;
    final model = currentState.model;
    final isAscending = event.filter.value == SortField.aZ;
    final Map<String, Comparable Function(DeviceEntity)> fieldMap = {
      SortField.name: (DeviceEntity d) => d.deviceName ?? '',
      SortField.lastKm: (DeviceEntity d) => d.lastReplacementKm ?? 0,
      SortField.lastDate: (DeviceEntity d) => d.lastReplacementDate ?? DateTime.now(),
      SortField.nextKm: (DeviceEntity d) => d.nextReplacementKm ?? 0,
    };
    final keyExtractor = fieldMap[event.filter.name] ?? fieldMap[SortField.nextKm]!;
    model.data.sort((a, b) =>
        isAscending ? keyExtractor(a).compareTo(keyExtractor(b)) : keyExtractor(b).compareTo(keyExtractor(a)));
    emit(HomeLoaded(model));
  }

  Future<void> _onUpdateCurrentKm(UpdateCurrentKm event, Emitter<HomeState> emit) async {
    final currentState = state as HomeLoaded;
    final model = currentState.model;
    await userRef.setCurrentKm(event.currentKm);

    model.currentKm = event.currentKm;
    emit(HomeLoaded(model));
  }

  // account
  Future<void> _onAddAccount(AddAccount event, Emitter<HomeState> emit) async {
    final currentState = state as HomeLoaded;
    final model = currentState.model;
    final item = UserEntity()..userName = event.userName;
    await usersRepository.insert(item);
    
    final users = (await usersRepository.listAll())!.where((e) => e.id != StaticVar.currentUserId).toList();
    model.users = users;
    emit(HomeLoaded(currentState.model));
  }

  Future<void> _onSwitchAccount(SwitchAccount event, Emitter<HomeState> emit) async {
    final currentState = state as HomeLoaded;
    final model = currentState.model;
    await userRef.setCurrentUserId(event.userId);
    StaticVar.currentUserId = event.userId;
    data = await deviceRepository.getAllDeviceByUserId(StaticVar.currentUserId);

    final listAllUser = await usersRepository.listAll();
    model.data = await deviceRepository.getAllDeviceByUserId(StaticVar.currentUserId);
    model.currentKm = await userRef.getCurrentKm() ?? 0;
    model.users = listAllUser!.where((e) => e.id != event.userId).toList();
    model.currentUser = listAllUser.firstWhereOrNull((e) => e.id == event.userId)!;
    emit(HomeLoaded(currentState.model));
  }

  Future<void> _onEditAccount(EditAccount event, Emitter<HomeState> emit) async {
    final currentState = state as HomeLoaded;
    final model = currentState.model;

    final user = await usersRepository.getById(StaticVar.currentUserId);
    user!.userName = event.userName;
    await usersRepository.update(user);

    final listAllUser = await usersRepository.listAll();
    model.users = listAllUser!.where((e) => e.id != StaticVar.currentUserId).toList();
    model.currentUser = listAllUser.firstWhereOrNull((e) => e.id == StaticVar.currentUserId)!;
    emit(HomeLoaded(currentState.model));
  }

  Future<void> _onDeleteAccount(DeleteAccount event, Emitter<HomeState> emit) async {
    final currentState = state as HomeLoaded;
    final model = currentState.model;

    final user = await usersRepository.getById(event.userId);
    await usersRepository.delete(user);

    final listAllUser = await usersRepository.listAll();
    model.users = listAllUser!.where((e) => e.id != StaticVar.currentUserId).toList();
    model.currentUser = listAllUser.firstWhereOrNull((e) => e.id == StaticVar.currentUserId)!;
    emit(HomeLoaded(currentState.model));
  }

}
