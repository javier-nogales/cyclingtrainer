
import 'package:get_it/get_it.dart';
import 'package:trainerapp/api/bluetooth/flutter_blue_provider.dart';
import 'package:trainerapp/api/db/sqflite_provider.dart';
import 'package:trainerapp/api/device/device_factory.dart';
import 'package:trainerapp/api/use_cases/bluetooth_controller.dart';
import 'package:trainerapp/api/use_cases/bt_device_check_controller.dart';
import 'package:trainerapp/api/use_cases/linking_controller.dart';
import 'package:trainerapp/api/use_cases/linking_use_case.dart';
import 'package:trainerapp/api/use_cases/trainer_device_controller.dart';
import 'package:trainerapp/bloc/bt_device_check/bt_device_check_bloc.dart';

import 'api/bluetooth/bluetooth_provider.dart';
import 'api/bluetooth/flutter_blue_provider.dart';
import 'api/db/db_device_factory.dart';
import 'api/db/db_provider.dart';
import 'api/device/device_repository.dart';
import 'api/use_cases/bluetooth_use_cases.dart';
import 'api/use_cases/bt_device_check_use_cases.dart';
import 'api/use_cases/heart_rate_device_controller.dart';
import 'api/use_cases/heart_rate_device_use_cases.dart';
import 'api/use_cases/trainer_device_use_cases.dart';
import 'bloc/bluetooth_is_scanning/bluetooth_is_scanning_bloc.dart';
import 'bloc/bluetooth_scan/bluetooth_scan_bloc.dart';
import 'bloc/device_linking/device_linking_bloc.dart';
import 'bloc/device_state/device_state_bloc.dart';

final sl = GetIt.instance;

void init() {

  // Factory

  sl.registerFactory(
    () => TrainerDeviceStateBloc(
      useCases: sl()
    )
  );

  sl.registerFactory(
    () => HeartRateDeviceStateBloc(
      useCases: sl()
    )
  );

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

  sl.registerFactory(
    () => BTDeviceCheckBloc(
      useCases: sl()
    )
  );

  sl.registerFactory(
    () => DeviceLinkingBloc(
      useCases: sl()
    )
  );

  // Lazy Singleton

  sl.registerLazySingleton<TrainerDeviceUseCases>(
    () => TrainerDeviceController(
      TrainerDeviceRepository(sl(), sl(), TrainerDeviceFactory())
    )
  );

  sl.registerLazySingleton<HeartRateDeviceUseCases>(
    () => HeartRateDeviceController(
      HeartRateDeviceRepository(sl(), sl(), HeartRateDeviceFactory())
    )
  );

  sl.registerLazySingleton<LinkingUseCases>(
    () => LinkingController(sl())
  );
  
  sl.registerLazySingleton<DBProvider>(
    () => SQFLiteProvider()
  );

  sl.registerLazySingleton<BluetoothUseCases>(
    () => BluetoothController(sl())
  );

  sl.registerLazySingleton<BluetoothProvider>(
    () => FlutterBlueProvider()
  );

  sl.registerLazySingleton<DBDeviceFactory>(
    () => DefaultDBDeviceFactory()
  );

  sl.registerLazySingleton<BTDeviceCheckUseCases>(
    () => BTDeviceCheckController(sl())
  );

  

}