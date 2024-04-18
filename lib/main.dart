import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hti_trialpathway/services/database.dart';
import 'package:hti_trialpathway/theme/color_schemes.g.dart';
import 'package:hti_trialpathway/user_type.dart';
import 'package:postgres/postgres.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'class_models/patient.dart';

GetIt getIt = GetIt.instance;

void main() async{
  getIt.registerSingletonAsync<Connection>(()async => await DataBaseService().initializeDatabase());
  getIt.registerSingleton<Patient>(Patient.generateMockPatient());
  getIt.registerSingletonAsync<SharedPreferences>(() =>  SharedPreferences.getInstance());
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState? of(BuildContext context)=> context.findAncestorStateOfType<_MyAppState>();
}

class _MyAppState extends State<MyApp> {
  final SharedPreferences _prefs = getIt<SharedPreferences>();
  late ThemeMode themeMode;

  void toggleTheme(ThemeMode value) async{

    setState(() {
      themeMode = value;
      if (themeMode.name == ThemeMode.light.name){
        _prefs.setBool('isDarkMode', false);
      }else{
        _prefs.setBool('isDarkMode', true);
      }
    });
  }

  @override
  void initState() {
  if(_prefs.getBool('isDarkMode')!=null) {
      themeMode = _prefs.getBool('isDarkMode')!
          ? ThemeMode.dark
          : ThemeMode.light;
    }else {
    themeMode = ThemeMode.system;
  }
    super.initState();
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

