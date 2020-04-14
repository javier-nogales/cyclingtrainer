import 'package:flutter/material.dart';
import 'injection_container.dart' as di;

import 'package:trainerapp/trainer_app.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  runApp(TrainerApp());
}