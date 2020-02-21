


import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:trainerapp/features/domain/entities/trainer_device.dart';
import 'package:trainerapp/features/domain/repositories/devices_repository.dart';
import 'package:trainerapp/features/domain/usecases/get_trainer_device.dart';

class MockDevicesRepository extends Mock 
  implements DevicesRepository {

}

void main() {
  GetTrainerDevice usecase;
  MockDevicesRepository mockDevicesRepository;

  setUp((){
    mockDevicesRepository = MockDevicesRepository();
    usecase = GetTrainerDevice(mockDevicesRepository);
  });

  Stream<TrainerDevice> trainerDeviceStream;

  test(
    '', 
    () async {
      when(mockDevicesRepository.getTrainerDevice())
        .thenAnswer((_) => Right(trainerDeviceStream));
      final result = usecase.execute();
      expect(result, Right(trainerDeviceStream));
      verify(mockDevicesRepository.getTrainerDevice());
      verifyNoMoreInteractions(mockDevicesRepository);
    }
  );
}