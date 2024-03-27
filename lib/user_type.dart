import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hti_trialpathway/patient/patient_main.dart';
import 'package:hti_trialpathway/researcher/login_research.dart';
import 'package:hti_trialpathway/widgets/my_appbar.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

          children: [
            ElevatedButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (_)=>ResearchLogin()));
            }, child: Text('Researcher')),
            ElevatedButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (_)=>PatientMain()));
            }, child: Text('Patient')),
          ],
                ),
        ),
    );
  }
}
