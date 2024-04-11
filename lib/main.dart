import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hti_trialpathway/services/database.dart';
import 'package:hti_trialpathway/theme/color_schemes.g.dart';
import 'package:hti_trialpathway/user_type.dart';
import 'package:postgres/postgres.dart';

import 'class_models/patient.dart';

GetIt getIt = GetIt.instance;

void main() async{
  getIt.registerSingletonAsync<Connection>(()async => await DataBaseService().initializeDatabase());
  getIt.registerSingleton<Patient>(Patient.generateMockPatient());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trial Pathway',
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme:darkColorScheme),
      home: Login(),
    );
  }
}

