import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hti_trialpathway/services/database.dart';
import 'package:hti_trialpathway/user_type.dart';
import 'package:postgres/postgres.dart';

GetIt getIt = GetIt.instance;

void main() async{
  getIt.registerSingletonAsync<Connection>(()async => await DataBaseService().initializeDatabase());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trial Pathway',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: Login(),
    );
  }
}

