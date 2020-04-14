import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:trainerapp/api/use_cases/bluetooth_use_cases.dart';

part 'bluetooth_is_scanning_event.dart';

class BluetoothIsScanningBloc extends Bloc<BluetoothIsScanningEvent, bool> {

  final BluetoothUseCases _bluetoothUseCases;

  BluetoothIsScanningBloc({@required BluetoothUseCases useCases}) 
    : this._bluetoothUseCases = useCases {
      final result = _bluetoothUseCases.isScanning();
      result.fold(
        (failure) {
          // TODO: not implemented!!!!
        }, 
        (isScanningStream) {
          isScanningStream.listen((isScanning) {
            if (isScanning)
              add(BluetoothIsScanningEvent.started);
            else
              add(BluetoothIsScanningEvent.stoped);
            
          });
        });
    }

  @override
  bool get initialState => false;

  @override
  Stream<bool> mapEventToState(
    BluetoothIsScanningEvent event,
  ) async* {
    switch (event) {
      case BluetoothIsScanningEvent.started:
        yield true;
        break;
      case BluetoothIsScanningEvent.stoped:
        yield false;
        break;
    }
  }
}
