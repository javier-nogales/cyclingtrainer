
import 'package:rxdart/rxdart.dart';
import 'package:trainerapp/api/bluetooth/bt_device.dart';

import 'mock_blue_device.dart';

class MockFlutterBlueProvider {

  Stream<List<BTDevice>> getDeviceList() async* {
    final List<BTDevice> devices = [];
    for (int i = 0; i < 3; i++) {
      final btDevice = MockBlueDevice();
      devices.add(btDevice);
      yield devices;
    }
  }

}