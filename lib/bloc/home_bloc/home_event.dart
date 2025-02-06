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
  final AppLocalizations localizations;
  SortData({required this.localizations, required this.filter});
}
