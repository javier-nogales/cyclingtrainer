
import 'package:trainerapp/features/domain/entities/database/database_package.dart';

// Interface
abstract class DataProvider {

  Future<DBDevice> getTrainerDevice();

}