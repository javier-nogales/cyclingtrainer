
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
import 'api/bluetooth/bt_device_controller.dart';
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
import 'bloc/device/device_bloc.dart';
import 'bloc/device_linking/device_linking_bloc.dart';
import 'bloc/device_state/device_state_bloc.dart';
import 'core/utils/logger.dart';

final sl = GetIt.instance;

void init() {

  // Factory
  // sl.registerFactory<TrainerDeviceStateBloc>(
  //   ()   => TrainerDeviceStateBloc(
  //     useCases: sl()
  //   )
  // );
  // debug version
  sl.registerFactory<TrainerDeviceStateBloc>(
    () {
      debug('[Injector] TrainerDeviceStateBloc');
      return TrainerDeviceStateBloc(useCases: sl());
    }
  );

  // sl.registerFactoryParam<SynchronizedTrainerDeviceStateBloc, DeviceLinkingBloc, void>(
  //   (linkingBloc, _) => SynchronizedTrainerDeviceStateBloc(
  //     useCases: sl(),
  //     linkingBloc: linkingBloc
  //   )
  // );
  // debug version
  sl.registerFactoryParam<SynchronizedTrainerDeviceStateBloc, DeviceLinkingBloc, void>(
    (linkingBloc, _) {
      debug('[Injector] SynchronizedTrainerDeviceStateBloc');
      return SynchronizedTrainerDeviceStateBloc(
          useCases: sl(),
          linkingBloc: linkingBloc
      );
    }
  );

  // sl.registerFactory<HeartRateDeviceStateBloc>(
  //   () => HeartRateDeviceStateBloc(
  //     useCases: sl()
  //   )
  // );
  // debug version
  sl.registerFactory<HeartRateDeviceStateBloc>(
    () {
      debug('[Injector] HeartRateDeviceStateBloc');
      return HeartRateDeviceStateBloc(useCases: sl());
    }
  );

  // sl.registerFactoryParam<SynchronizedHeartRateDeviceStateBloc, DeviceLinkingBloc, void>(
  //   (linkingBloc, _) => SynchronizedHeartRateDeviceStateBloc(
  //     useCases: sl(),
  //     linkingBloc: linkingBloc,
  //   )
  // );
  // debug version
  sl.registerFactoryParam<SynchronizedHeartRateDeviceStateBloc, DeviceLinkingBloc, void>(
    (linkingBloc, _) {
      debug('[Injector] SynchronizedHeartRateDeviceStateBloc');
      return SynchronizedHeartRateDeviceStateBloc(
        useCases: sl(),
        linkingBloc: linkingBloc,
      );
    }
  );

  // sl.registerFactoryParam<TrainerDeviceBloc, DeviceLinkingBloc, void>(
  //   (linkingBloc, _) => TrainerDeviceBloc(
  //     useCases:sl(),
  //     linkingBloc: linkingBloc,
  //   )
  // );
  // debug version
  sl.registerFactoryParam<TrainerDeviceBloc, DeviceLinkingBloc, void>(
    (linkingBloc, _) {
      debug('[Injector] TrainerDeviceBloc');
      return TrainerDeviceBloc(
        useCases:sl(),
        linkingBloc: linkingBloc,
      );
    }
  );

  // sl.registerFactoryParam<HeartRateDeviceBloc, DeviceLinkingBloc, void>(
  //   (linkingBloc, _) => HeartRateDeviceBloc(
  //     useCases:sl(),
  //     linkingBloc: linkingBloc,
  //   )
  // );
  // debug version
  sl.registerFactoryParam<HeartRateDeviceBloc, DeviceLinkingBloc, void>(
    (linkingBloc, _) {
      debug('[Injector] HeartRateDeviceBloc');
      return HeartRateDeviceBloc(
        useCases:sl(),
        linkingBloc: linkingBloc,
      );
    }
  );

  // sl.registerFactory(
  //   () => BluetoothScanBloc(
  //     useCases: sl()
  //   )
  // );
  // debug version
  sl.registerFactory(
    () {
      debug('[Injector] BluetoothScanBloc');
      return BluetoothScanBloc(useCases: sl());
    }
  );

  // sl.registerFactory(
  //   () => BluetoothIsScanningBloc(
  //     useCases: sl()
  //   )
  // );
  // debug version
  sl.registerFactory(
    () {
      debug('[Injector] BluetoothIsScanningBloc');
      return BluetoothIsScanningBloc(useCases: sl());
    }
  );

  // sl.registerFactory(
  //   () => BTDeviceCheckBloc(
  //     useCases: sl()
  //   )
  // );
  // debug version
  sl.registerFactory(
    () {
      debug('[Injector] BTDeviceCheckBloc');
      return BTDeviceCheckBloc(useCases: sl());
    }
  );

  // sl.registerFactory(
  //   () => DeviceLinkingBloc(
  //     useCases: sl()
  //   )
  // );
  // debug version
  sl.registerFactory(
    () {
      debug('[Injector] DeviceLinkingBloc');
      return DeviceLinkingBloc(useCases: sl());
    }
  );

  // sl.registerFactory(
  //         () => BTDeviceController(sl<BluetoothProvider>())
  // );
  sl.registerFactory(
    () {
      debug('[Injector] BTDeviceController');
      return BTDeviceController(sl<BluetoothProvider>());
    }
  );

  /*
    Lazy Singleton
   */
  // sl.registerLazySingleton<TrainerDeviceRepository>(
  //         () => TrainerDeviceRepository(
  //         sl(),
  //         TrainerDeviceFactory(BTDeviceController(sl<BluetoothProvider>()))
  //     )
  // );
  // debug version
  sl.registerLazySingleton<TrainerDeviceRepository>(
    () {
      debug('[Injector] TrainerDeviceRepository');
      return TrainerDeviceRepository(
        sl(),
        TrainerDeviceFactory(BTDeviceController(sl<BluetoothProvider>()))
      );
    }
  );

  // sl.registerLazySingleton<HeartRateDeviceRepository>(
  //         () => HeartRateDeviceRepository(
  //         sl(),
  //         HeartRateDeviceFactory(BTDeviceController(sl<BluetoothProvider>()))
  //     )
  // );
  // debug version
  sl.registerLazySingleton<HeartRateDeviceRepository>(
    () {
      debug('[Injector] HeartRateDeviceRepository');
      return HeartRateDeviceRepository(
          sl(),
          HeartRateDeviceFactory(BTDeviceController(sl<BluetoothProvider>()))
      );
    }
  );

  // sl.registerLazySingleton<TrainerDeviceUseCases>(
  //         () => TrainerDeviceController(
  //         sl()
  //     )
  // );
  // debug version
  sl.registerLazySingleton<TrainerDeviceUseCases>(
    () {
      debug('[Injector] TrainerDeviceController');
      return TrainerDeviceController(sl());
    }
  );

  // sl.registerLazySingleton<HeartRateDeviceUseCases>(
  //         () => HeartRateDeviceController(
  //         sl()
  //     )
  // );
  // debug version
  sl.registerLazySingleton<HeartRateDeviceUseCases>(
    () {
      debug('[Injector] HeartRateDeviceController');
      return HeartRateDeviceController(sl());
    }
  );

  // sl.registerLazySingleton<LinkingUseCases>(
  //   () => LinkingController(
  //     sl(),
  //     sl(),
  //     sl(),
  //   )
  // );
  // debug version
  sl.registerLazySingleton<LinkingUseCases>(
    () {
      debug('[Injector] LinkingController');
      return LinkingController(sl(),  sl(), sl());
    }
  );

  // sl.registerLazySingleton<DBProvider>(
  //   () => SQFLiteProvider()
  // );
  // debug version
  sl.registerLazySingleton<DBProvider>(
    () {
      debug('[Injector] SQFLiteProvider');
      return SQFLiteProvider();
    }
  );

  // sl.registerLazySingleton<BluetoothUseCases>(
  //   () => BluetoothController(sl(), sl())
  // );
  // debug version
  sl.registerLazySingleton<BluetoothUseCases>(
    () {
      debug('[Injector] BluetoothController');
      return BluetoothController(sl(), sl());
    }
  );

  // sl.registerLazySingleton<BluetoothProvider>(
  //   () => FlutterBlueProvider()
  // );
  // debug version
  sl.registerLazySingleton<BluetoothProvider>(
    () {
      debug('[Injector] FlutterBlueProvider');
      return FlutterBlueProvider();
    }
  );

  // sl.registerLazySingleton<DBDeviceFactory>(
  //   () => DefaultDBDeviceFactory()
  // );
  // debug version
  sl.registerLazySingleton<DBDeviceFactory>(
    () {
      debug('[Injector] DefaultDBDeviceFactory');
      return DefaultDBDeviceFactory();
    }
  );

  // sl.registerLazySingleton<BTDeviceCheckUseCases>(
  //   () => BTDeviceCheckController(sl())
  // );
  // debug version
  sl.registerLazySingleton<BTDeviceCheckUseCases>(
    () {
      debug('[Injector] BTDeviceCheckController');
      return BTDeviceCheckController(sl());
    }
  );



}