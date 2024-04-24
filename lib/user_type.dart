import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hti_trialpathway/patient/aact_login.dart';
import 'package:hti_trialpathway/researcher/login_research.dart';
import 'package:hti_trialpathway/widgets/my_appbar.dart';

class UserType extends StatelessWidget {
  const UserType({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

          children: [
            ElevatedButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (_)=>const ResearchLogin()));
            }, child: const Text('Researcher')),
            ElevatedButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (_)=>const AACTLogin()));
            }, child: const Text('Patient')),
          ],
                ),
        ),
    );
  }
}
