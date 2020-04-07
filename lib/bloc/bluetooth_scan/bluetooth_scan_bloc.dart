import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:trainerapp/api/bluetooth/bt_device.dart';
import 'package:trainerapp/api/use_cases/bluetooth_use_cases.dart';
import './bloc.dart';

class BluetoothScanBloc extends Bloc<BluetoothScanEvent, BluetoothScanState> {

  final BluetoothUseCases _useCases;

  StreamSubscription streamSubscription;

  BluetoothScanBloc({@required BluetoothUseCases useCases}) : this._useCases = useCases {
//    add(BluetoothScanStarted());
  }

  @override
  BluetoothScanState get initialState => InitialBluetoothScanState();

  void _init()  {
    final result = _useCases.fetchDevices();
    result.fold(
            (failure) {
              add(BluetoothScanFailed());
            },
            (btDeviceStream) {
              streamSubscription = btDeviceStream.listen(
                      (btDevices) {
                        add(BluetoothScanUpdated(btDevices));
                      },
                      onDone: () {
                        add(BluetoothScanDone());
                      },
                      onError: (e) {
                        add(BluetoothScanFailed());
                      }
              );
            }
    );
  }

//  Future<dynamic> _cancelSubscription() {
//    return streamSubscription.cancel();
//  }

  @override
  Stream<BluetoothScanState> mapEventToState(
    BluetoothScanEvent event,
  ) async* {
    if (event is BluetoothScanStarted) {
      _init();
      print(':::::> Emits BluetoothScanLoadInProgress(): ** ${event.hashCode}');
      yield BluetoothScanLoadInProgress();
    } else if (event is BluetoothScanUpdated) {
      final List<BTDevice> btDeviceList = event.btDevices.map((btDevice) => btDevice).toList();
      final result = BluetoothScanListenInProgress(btDeviceList);
      print(':::::> Emits BluetoothScanListenInProgress(): $result ** ${event.hashCode}');
      yield result;
    } else if (event is BluetoothScanDone) {
      print(':::::> Emits BluetoothScanDone: ** ${event.hashCode}');
      // await _cancelSubscription();
      yield BluetoothScanFinishSuccess();
    } else if (event is BluetoothScanFailed) {
      print(':::::> Emits BluetoothScanFailed:');
      yield BluetoothScanFailure();
    }
  }

}