
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
import 'api/device/device_package.dart';
import 'api/device/device_repository.dart';
import 'api/use_cases/bluetooth_use_cases.dart';
import 'api/use_cases/bt_device_check_use_cases.dart';
import 'api/use_cases/heart_rate_device_controller.dart';
import 'api/use_cases/heart_rate_device_use_cases.dart';
import 'api/use_cases/trainer_device_use_cases.dart';
import 'bloc/bluetooth_is_scanning/bluetooth_is_scanning_bloc.dart';
import 'bloc/bluetooth_scan/bluetooth_scan_bloc.dart';
import 'bloc/device/device_bloc.dart';
import 'bloc/device_linking/device_linking_bloc.dart';
import 'bloc/device_state/device_state_bloc.dart';

final sl = GetIt.instance;

void init() {

  // Factory

  // sl.registerFactory(
  //   () => TrainerDeviceStateBloc(
  //     useCases: sl(),
  //     linkingBloc: sl(),
  //   )
  // );

  // sl.registerFactory(
  //   () => HeartRateDeviceStateBloc(
  //     useCases: sl(),
  //     linkingBloc: sl(),
  //   )
  // );

  sl.registerFactory<TrainerDeviceStateBloc>(
    () => TrainerDeviceStateBloc(
      useCases: sl()
    )
  );

  sl.registerFactoryParam<SynchronizedTrainerDeviceStateBloc, DeviceLinkingBloc, void>(
    (linkingBloc1, _) => SynchronizedTrainerDeviceStateBloc(
      useCases: sl(),
      linkingBloc: linkingBloc1
    )
  );

  sl.registerFactory<HeartRateDeviceStateBloc>(
    () => HeartRateDeviceStateBloc(
      useCases: sl()
    )
  );

  sl.registerFactoryParam<SynchronizedHeartRateDeviceStateBloc, DeviceLinkingBloc, void>(
    (linkingBloc, _) => SynchronizedHeartRateDeviceStateBloc(
      useCases: sl(),
      linkingBloc: linkingBloc,
    )
  );

  sl.registerFactoryParam<TrainerDeviceBloc, DeviceLinkingBloc, void>( 
    (linkingBloc, _) => TrainerDeviceBloc(
      useCases:sl(),
      linkingBloc: linkingBloc,
    ) 
  );

  sl.registerFactoryParam<HeartRateDeviceBloc, DeviceLinkingBloc, void>( 
    (linkingBloc, _) => HeartRateDeviceBloc(
      useCases:sl(),
      linkingBloc: linkingBloc,
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

  // sl.registerLazySingleton<DeviceLinkingBloc>(
  //   () => DeviceLinkingBloc(useCases: sl())
  // );

  // Lazy Singleton
  sl.registerLazySingleton<TrainerDeviceRepository>(
    () => TrainerDeviceRepository(
      sl(),
      TrainerDeviceFactory()
    )
  );

  // sl.registerLazySingleton<DeviceRepository<TrainerDevice>>(
  //   () => TrainerDeviceRepository(
  //     sl(),
  //     sl(),
  //     TrainerDeviceFactory()
  //   )
  // );

  sl.registerLazySingleton<HeartRateDeviceRepository>(
    () => HeartRateDeviceRepository(
      sl(),
      HeartRateDeviceFactory()
    )
  );

  // sl.registerLazySingleton<DeviceRepository<HeartRateDevice>>(
  //   () => HeartRateDeviceRepository(
  //     sl(),
  //     sl(),
  //     HeartRateDeviceFactory()
  //   )
  // );

  sl.registerLazySingleton<TrainerDeviceUseCases>(
    () => TrainerDeviceController(
      sl()
      // TrainerDeviceRepository(sl(), sl(), TrainerDeviceFactory())
    )
  );

  sl.registerLazySingleton<HeartRateDeviceUseCases>(
    () => HeartRateDeviceController(
      sl()
      // HeartRateDeviceRepository(sl(), sl(), HeartRateDeviceFactory())
    )
  );

  sl.registerLazySingleton<LinkingUseCases>(
    () => LinkingController(
      sl(), 
      sl(),
      sl(),
      // HeartRateDeviceRepository(sl(), sl(), HeartRateDeviceFactory()), 
      // TrainerDeviceRepository(sl(), sl(), TrainerDeviceFactory())
    )
  );
  
  sl.registerLazySingleton<DBProvider>(
    () => SQFLiteProvider()
  );

  sl.registerLazySingleton<BluetoothUseCases>(
    () => BluetoothController(sl(), sl())
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