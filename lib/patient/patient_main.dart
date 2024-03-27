import 'package:flutter/material.dart';

import '../main.dart';
import '../services/database.dart';
import '../widgets/my_appbar.dart';

class PatientMain extends StatefulWidget {
  const PatientMain({super.key});

  @override
  State<PatientMain> createState() => _PatientMainState();
}

class _PatientMainState extends State<PatientMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: FutureBuilder(
          future: getIt<DataBaseService>().initializeDatabase(),
          builder: (context, snapshot) {
            if(snapshot.data != null) {
              snapshot.data!.execute(
                r'SELECT COUNT(*) FROM studies',
                // parameters: ['example row'],
              ).then((value) =>   print('Inserted ${value.first.toColumnMap()} rows'));

            }
            return Text('Still working on it');
          }
      ),
      // bottomNavigationBar: bottomNavBar(),
    );
  }
}
