

import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:trainerapp/features/domain/entities/trainer_device.dart';
import 'package:trainerapp/features/domain/repositories/devices_repository.dart';
import 'package:trainerapp/features/domain/repositories/trainer_device_repository_imp.dart';

////////////////////////////////////////////////////////////
// Mocks
////////////////////////////////////////////////////////////
class MockDevicesRepository extends Mock
                         implements DevicesRepository {}
class MockTrainerDevice extends Mock
                     implements TrainerDevice{}

void main() {

  MockDevicesRepository mockDevicesRepository;
  MockTrainerDevice mockTrainerDevice;
  TrainerDeviceRepositoryImp repository;
  StreamController controller;

  setUp((){
    mockDevicesRepository = MockDevicesRepository();
    mockTrainerDevice = MockTrainerDevice();
    repository = TrainerDeviceRepositoryImp(mockDevicesRepository);
    controller = StreamController.broadcast();
  });

  tearDown(() {
    controller.close();
  });

  Stream<TrainerDevice> trainerDeviceStream;

  test('Stream listen test', () {

    //var stream = controller.stream;
    
    repository.trainerDevice.listen(
      expectAsync1(
        (event) {
          expect(event, mockTrainerDevice);
        },
      ),
    );

    repository.sink(mockTrainerDevice);

  });

}