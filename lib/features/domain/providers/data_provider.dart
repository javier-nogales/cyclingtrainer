
import 'package:trainerapp/features/domain/entities/trainer_device.dart';

// Interface
abstract class DataProvider {

  Future<TrainerDevice> getTrainerDevice();

}