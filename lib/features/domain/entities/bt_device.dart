
import 'bt_device_state.dart';

abstract class BTDevice {

  Stream<BTDeviceState> get state;

}