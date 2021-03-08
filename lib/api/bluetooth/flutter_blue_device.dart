
import 'dart:async';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:trainerapp/api/bluetooth/bt_device.dart';
import 'package:trainerapp/api/device/identifiers.dart';
import 'package:rxdart/rxdart.dart';


class FlutterBlueDevice implements BTDevice {

  final BluetoothDevice _device;
  final _btState = BehaviorSubject<BTDeviceState>();

  FlutterBlueDevice(this._device) {
    if (this._device != null) {
      _device.state.listen((bluetoothDeviceState) {
        _btState.add(_transformDeviceState(bluetoothDeviceState));
      });
    }
  }

  @override
  DeviceID get btId => DeviceID(_device.id.toString());

  @override
  String get btName => _device.name;

  @override
  Future<void> connect() => _device.connect();

  @override
  ensureConnection({
    Function onConnect, 
    Function onConnectionLost
  }) {
    _device.connect()
      .then((_) {
        onConnect();
      });
    Timer.periodic(
      Duration(seconds: 5), 
      (timer) {
        _device.connect()
                  .then((_) {
                    print('[DEBUG] [${DateTime.now()}] [${this.runtimeType}] Device continue connected');
                  })
                  .timeout(
                    Duration(milliseconds: 2000), 
                    onTimeout: () {
                      print('[DEBUG] [${DateTime.now()}] [${this.runtimeType}] Device connection timeout');
                      _btState.add(BTDeviceState.disconnected);
                      timer.cancel();
                      onConnectionLost();
                    }
                  )
                  .catchError((err) {
                    print('[DEBUG] [${DateTime.now()}] [${this.runtimeType}]Error connecting device');
                      _btState.add(BTDeviceState.disconnected);
                      timer.cancel();
                      onConnectionLost();
                  });
      }
    );
  }
  
  @override
  Stream<BTDeviceState> get btState => _btState;

  @override
  Future<List<ServiceUUID>> fetchServiceUUIDs() async {
    //if (await this.btState.last == BTDeviceState.disconnected) {
      await _device.connect();
    //}

    List<BluetoothService> services = await _device.discoverServices();

    _device.disconnect();

    return services.map((service) => ServiceUUID(service.uuid.toString()))
                   .toList();
  }

////////////////////////////////////////////////////////////
// private methods
////////////////////////////////////////////////////////////
  BTDeviceState _transformDeviceState(BluetoothDeviceState bluetoothDeviceState) {
    switch(bluetoothDeviceState) {
      case BluetoothDeviceState.disconnected:
        return BTDeviceState.disconnected;
        break;
      case BluetoothDeviceState.connecting:
        return BTDeviceState.connecting;
        break;
      case BluetoothDeviceState.connected:
        return BTDeviceState.connected;
        break;
      case BluetoothDeviceState.disconnecting:
        return BTDeviceState.disconnecting;
        break;
      default:
      // TODO: throw especific error.
        throw Exception("Unsuported device state");
      break;
    }

  }

}