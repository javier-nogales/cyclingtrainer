


import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:trainerapp/features/domain/entities/trainer_device.dart';
import 'package:trainerapp/features/domain/repositories/trainer_device_repository.dart';
import 'package:trainerapp/features/domain/usecases/get_trainer_device.dart';

class MockTrainerDevicesRepository extends Mock 
                                implements TrainerDeviceRepository {
}

void main() {
  GetTrainerDevice usecase;
  MockTrainerDevicesRepository mockDevicesRepository;

  setUp((){
    mockDevicesRepository = MockTrainerDevicesRepository();
    usecase = GetTrainerDevice(mockDevicesRepository);
  });

  Stream<TrainerDevice> trainerDeviceStream;

  test(
    'Should get Trainer Device from the repository', 
    () async {
      when(mockDevicesRepository.getTrainerDevice())
        .thenAnswer((_) => Right(trainerDeviceStream));
      final result = usecase();
      expect(result, Right(trainerDeviceStream));
      verify(mockDevicesRepository.getTrainerDevice());
      verifyNoMoreInteractions(mockDevicesRepository);
    }
  );
}