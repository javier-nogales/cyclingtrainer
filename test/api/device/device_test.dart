
import 'package:test/test.dart';
import 'package:trainerapp/api/bluetooth/bt_device.dart';
import 'package:trainerapp/api/db/db_device.dart';
import 'package:trainerapp/api/device/device_factory.dart';
import 'package:trainerapp/api/device/device_package.dart';

import '../bluetooth/mock_blue_device.dart';

void main (){

  DBDevice dbDevice;
  MockBlueDevice btDevice;


  group('TrainerDevice tests', () {

    setUp((){
      dbDevice = DBDevice("fakeID", "fakeName", DeviceType.trainer, DeviceClass.bkoolTrainer);
      btDevice = MockBlueDevice();
    });

    group('TrainerDevice state tests', ()  {

      Device device;

      setUp((){
        device = TrainerDeviceFactory().from(dbDevice);
      });

      test('Device emits notFound when created', () {
        final result = device.state;
        expect(result, emits(emits(DeviceState.notFound)));
      });

      test('Device emits notFound when DBDevice is not found', () {
        device.btDevice = null;
        final result = device.state;
        expect(result, emits(emits(DeviceState.notFound)));
      });

      test('Device emits disconected when DBDevice is found but is disconnected', () {
        device.btDevice = btDevice;
        btDevice.addState(BTDeviceState.disconnected);
        final result = device.state;
        expect(result, emitsThrough(DeviceState.disconnected));
      });

      test('Device emits disconnected when DBDevice is found but is connecting', () {
        device.btDevice = btDevice;
        btDevice.addState(BTDeviceState.connecting);
        final result = device.state;
        expect(result, emitsThrough(DeviceState.disconnected));
      });

      test('Device emits connected when DBDevice is found and is connected', () {
        device.btDevice = btDevice;
        btDevice.addState(BTDeviceState.connected);
        final result = device.state;
        expect(result, emitsThrough(DeviceState.connected));
      });

      test('Device emits disconnected when DBDevice is found but is disconnecting', () {
        device.btDevice = btDevice;
        btDevice.addState(BTDeviceState.disconnecting);
        final result = device.state;
        expect(result, emitsThrough(DeviceState.disconnected));
      });

      test('Device emits all state events in order', () {
        device.btDevice = btDevice;
        btDevice.addState(BTDeviceState.disconnected);
        btDevice.addState(BTDeviceState.connecting);
        btDevice.addState(BTDeviceState.connected);
        btDevice.addState(BTDeviceState.disconnecting);
        btDevice.addState(BTDeviceState.disconnected);
        final result = device.state;
        expect(result, emitsInOrder([DeviceState.notFound,
          DeviceState.disconnected,
          DeviceState.disconnected,
          DeviceState.connected,
          DeviceState.disconnected,
          DeviceState.disconnected]));
      });

    });

  });
  group('HeartRateDevice tests', () {

    setUp((){
      dbDevice = DBDevice("fakeID", "fakeName", DeviceType.heartRate, DeviceClass.standardHeartRate);
      btDevice = MockBlueDevice();
    });

    group('HeartRateDevice state tests', ()  {

      Device device;

      setUp((){
        device = HeartRateDeviceFactory().from(dbDevice);
      });

      test('Device emits notFound when created', () {
        final result = device.state;
        expect(result, emits(emits(DeviceState.notFound)));
      });

      test('Device emits notFound when DBDevice is not found', () {
        device.btDevice = null;
        final result = device.state;
        expect(result, emits(emits(DeviceState.notFound)));
      });

      test('Device emits disconected when DBDevice is found but is disconnected', () {
        device.btDevice = btDevice;
        btDevice.addState(BTDeviceState.disconnected);
        final result = device.state;
        expect(result, emitsThrough(DeviceState.disconnected));
      });

      test('Device emits disconnected when DBDevice is found but is connecting', () {
        device.btDevice = btDevice;
        btDevice.addState(BTDeviceState.connecting);
        final result = device.state;
        expect(result, emitsThrough(DeviceState.disconnected));
      });

      test('Device emits connected when DBDevice is found and is connected', () {
        device.btDevice = btDevice;
        btDevice.addState(BTDeviceState.connected);
        final result = device.state;
        expect(result, emitsThrough(DeviceState.connected));
      });

      test('Device emits disconnected when DBDevice is found but is disconnecting', () {
        device.btDevice = btDevice;
        btDevice.addState(BTDeviceState.disconnecting);
        final result = device.state;
        expect(result, emitsThrough(DeviceState.disconnected));
      });

      test('Device emits all state events in order', () {
        device.btDevice = btDevice;
        btDevice.addState(BTDeviceState.disconnected);
        btDevice.addState(BTDeviceState.connecting);
        btDevice.addState(BTDeviceState.connected);
        btDevice.addState(BTDeviceState.disconnecting);
        btDevice.addState(BTDeviceState.disconnected);
        final result = device.state;
        expect(result, emitsInOrder([DeviceState.notFound,
          DeviceState.disconnected,
          DeviceState.disconnected,
          DeviceState.connected,
          DeviceState.disconnected,
          DeviceState.disconnected]));
      });

    });

  });

}