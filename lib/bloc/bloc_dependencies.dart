import 'package:get_it/get_it.dart';

import 'add_device_bloc/add_device_bloc.dart';

class BlocDependencies {
  static void init(GetIt injector) {
    injector.registerFactory<AddDeviceBloc>(() => AddDeviceBloc());
  }
}
