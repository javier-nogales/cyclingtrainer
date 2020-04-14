import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:trainerapp/api/bluetooth/bt_device.dart';
import 'package:trainerapp/api/use_cases/bluetooth_use_cases.dart';

part 'bluetooth_scan_event.dart';
part 'bluetooth_scan_state.dart';

class BluetoothScanBloc extends Bloc<BluetoothScanEvent, BluetoothScanState> {

  final BluetoothUseCases _useCases;

  StreamSubscription streamSubscription;

  BluetoothScanBloc({@required BluetoothUseCases useCases}) 
    : this._useCases = useCases;

  @override
  BluetoothScanState get initialState => InitialBluetoothScanState();

  void _init() {
    final result = _useCases.fetchDevices();
    result.fold(
            (failure) {
              add(BluetoothScanFailed());
            },
            (btDeviceStream) {
              if (streamSubscription == null) {
                streamSubscription = btDeviceStream.listen(
                      (btDevices) {
                        add(BluetoothScanUpdated(btDevices));
                      },
                      onError: (e) {
                        add(BluetoothScanFailed());
                      },
                );
              }
            }
    );
  }

  @override
  Stream<BluetoothScanState> mapEventToState(
    BluetoothScanEvent event,
  ) async* {
    if (event is BluetoothScanStarted) {
      _init();
      yield BluetoothScanLoadInProgress();
    } else if (event is BluetoothScanUpdated) {
      final List<BTDevice> btDeviceList = event.btDevices.map((btDevice) => btDevice).toList();
      final result = BluetoothScanListenInProgress(btDeviceList);
      yield result;
    } else if (event is BluetoothScanFailed) {
      yield BluetoothScanFailure();
    }
  }

  @override
  Future<void> close() async {
    if (streamSubscription != null) {
      streamSubscription.cancel();
      super.close();
    }    
  }

}