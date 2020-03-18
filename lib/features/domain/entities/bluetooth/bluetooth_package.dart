

abstract class BTDevice {

  Stream<BTDeviceState> get state;

}

enum BTDeviceState {
  disconnected,
  connecting,
  connected,
  disconnecting,
}