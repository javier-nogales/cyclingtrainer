
import 'package:get_it/get_it.dart';
import 'package:trainerapp/api/bluetooth/flutter_blue_provider.dart';
import 'package:trainerapp/api/use_cases/bluetooth_controller.dart';

import 'api/bluetooth/bluetooth_provider.dart';
import 'api/use_cases/bluetooth_use_cases.dart';
import 'bloc/bluetooth_is_scanning/bluetooth_is_scanning_bloc.dart';
import 'bloc/bluetooth_scan/bluetooth_scan_bloc.dart';

final sl = GetIt.instance;

void init() {

  sl.registerFactory(
    () => BluetoothScanBloc(
      useCases: sl()
    )
  );

  sl.registerFactory(
    () => BluetoothIsScanningBloc(
      useCases: sl()
    )
  );

  sl.registerLazySingleton<BluetoothUseCases>(
    () => BluetoothController(sl())
  );

  sl.registerLazySingleton<BluetoothProvider>(
    () => FlutterBlueProvider()
  );

}