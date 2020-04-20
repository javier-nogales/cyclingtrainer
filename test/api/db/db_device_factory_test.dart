import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:trainerapp/api/bluetooth/bt_device.dart';
import 'package:trainerapp/api/bluetooth/const_service_uuid.dart';
import 'package:trainerapp/api/db/db_device.dart';
import 'package:trainerapp/api/db/db_device_factory.dart';
import 'package:trainerapp/api/device/device_package.dart';
import 'package:trainerapp/api/device/identifiers.dart';

class MockBTDevice extends Mock 
  implements BTDevice {}

void main() {

  DBDeviceFactory dbDeviceFactory;
  BTDevice btDevice;
  List<ServiceUUID> serviceUUIDs;
  DBDevice expectedDBDevice;

  group('DBDeviceFactory', () {

    setUp(() {
      dbDeviceFactory = DefaultDBDeviceFactory();
      btDevice = MockBTDevice();

      
    });

    test('Return create correct DeviceType & DeviceClass (org_bluetooth_service__heart_rate)', () async {
        
      serviceUUIDs = [org_bluetooth_service__heart_rate];
      expectedDBDevice = DBDevice("fakeId", "fakeName", DeviceType.heartRate, DeviceClass.standardHeartRate);

      when(btDevice.btId)
        .thenReturn(DeviceID("fakeId"));
      when(btDevice.btName)
        .thenReturn("fakeName");
      when(btDevice.fetchServiceUUIDs())
        .thenAnswer((_) async => serviceUUIDs);

      final result = await dbDeviceFactory.fromBTDevice(btDevice);

      expect(result, expectedDBDevice);

    });

    test('Return create correct DeviceType & DeviceClass ()', () async {
        
      serviceUUIDs = [bkool_custom_service__cycling_power];
      expectedDBDevice = DBDevice("fakeId", "fakeName", DeviceType.trainer, DeviceClass.bkoolTrainer);

      when(btDevice.btId)
        .thenReturn(DeviceID("fakeId"));
      when(btDevice.btName)
        .thenReturn("fakeName");
      when(btDevice.fetchServiceUUIDs())
        .thenAnswer((_) async => serviceUUIDs);

      final result = await dbDeviceFactory.fromBTDevice(btDevice);

      expect(result, expectedDBDevice);

    });


  });

}