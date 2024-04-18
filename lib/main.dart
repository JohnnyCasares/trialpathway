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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState? of(BuildContext context)=> context.findAncestorStateOfType<_MyAppState>();
}

class _MyAppState extends State<MyApp> {

  ThemeMode themeMode = ThemeMode.system;

  void toggleTheme(ThemeMode value){
    setState(() {
      themeMode = value;
    });


  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trial Pathway',
      themeMode: themeMode,
      theme: CustomTheme.lightColorScheme,
      darkTheme: CustomTheme.darkColorScheme,
      home: Login(),
    );
  }
}

