
import 'package:trainerapp/features/domain/entities/db_device.dart';

// Interface
abstract class DataProvider {

  Future<DBDevice> getTrainerDevice();

}