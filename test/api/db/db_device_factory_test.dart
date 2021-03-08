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
        
      serviceUUIDs = [ServiceUUID('0000180d-0000-1000-8000-00805f9b34fb')];
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

    test('Return create correct DeviceType & DeviceClass (bkool_custom_service__cycling_power)', () async {
        
      serviceUUIDs = [ServiceUUID('f03eee01-4910-473c-be46-960948c2f59c')];
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