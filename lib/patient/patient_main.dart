import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

import '../main.dart';

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
        appBar: const MyAppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Server is ready',
              ),
              ElevatedButton(
                  onPressed: () async {
                    final result = await getIt<Connection>().execute(
                      r'SELECT COUNT(*) FROM ctgov.studies',
                      // parameters: ['example row'],
                    );
                    print(result);
                  },
                  child: Text('QUERY'))
            ],
          ),
        ));

    // bottomNavigationBar: bottomNavBar(),
  }
}
