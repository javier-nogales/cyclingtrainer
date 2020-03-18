
import 'package:meta/meta.dart';
import 'package:trainerapp/features/domain/entities/device_base.dart';
import 'package:trainerapp/features/domain/providers/bluetooth_provider.dart';
import 'package:trainerapp/features/domain/providers/data_provider.dart';
import 'package:trainerapp/features/domain/repositories/device_repository.dart';

abstract class DeviceRepositoryBase<T extends DeviceBase>
                                   implements DeviceRepository<T> {

  @protected
  final DataProvider dataProvider;
  @protected
  final BluetoothProvider bluetoothProvider;

  @protected
  T device;

  DeviceRepositoryBase(this.dataProvider, this.bluetoothProvider);

}