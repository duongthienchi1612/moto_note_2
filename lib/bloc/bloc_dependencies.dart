import 'package:get_it/get_it.dart';

import 'add_device_bloc/add_device_bloc.dart';
import 'home_bloc/home_bloc.dart';

class BlocDependencies {
  static void init(GetIt injector) {
    injector.registerFactory<AddDeviceBloc>(() => AddDeviceBloc());
    injector.registerFactory<HomeBloc>(() => HomeBloc());
  }
}
