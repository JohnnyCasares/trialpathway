import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hti_trialpathway/researcher/research_main.dart';
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
              Navigator.of(context).push(MaterialPageRoute(builder: (_)=>ResearchMain()));
            }, child: Text('Researcher')),
            ElevatedButton(onPressed: (){}, child: Text('Patient')),
          ],
                ),
        ),
    );
  }
}
