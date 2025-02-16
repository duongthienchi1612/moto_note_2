part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class LoadData extends HomeEvent {}

class DeleteItem extends HomeEvent {
  final String id;
  DeleteItem(this.id);
}

class SortData extends HomeEvent {
  final OptionModel filter;
  SortData(this.filter);
}
class UpdateCurrentKm extends HomeEvent {
  final int currentKm;
  UpdateCurrentKm(this.currentKm);
}

// account
class AddAccount extends HomeEvent {
  final String userName;
  AddAccount(this.userName);
}

class EditAccount extends HomeEvent {
  final String userName;
  EditAccount(this.userName);
}

class SwitchAccount extends HomeEvent {
  final String userId;
  SwitchAccount(this.userId);
}
class DeleteAccount extends HomeEvent {
  final String userId;
  DeleteAccount(this.userId);
}
class OpenMenu extends HomeEvent {
  final bool isOpen;
  OpenMenu(this.isOpen);
}
