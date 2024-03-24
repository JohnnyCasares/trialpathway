import 'package:flutter/material.dart';
import 'package:hti_trialpathway/researcher/research_main.dart';

class ResearchLogin extends StatefulWidget {
  const ResearchLogin({super.key});

  @override
  State<ResearchLogin> createState() => _ResearchLoginState();
}

class _ResearchLoginState extends State<ResearchLogin> {
  var key = GlobalKey<FormState>();
  bool valid = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Form(
          key: key,
          onChanged: (){
            if(key.currentState!=null && key.currentState!.validate()){
              setState(() {
                valid = true;
              });
            }
          },
          child: Column(
            children: [
              /*org (One-word organization name assigned by PRS (sent via email when account was created)),
               username,
               password*/
              TextFormField(

              ),
              ElevatedButton(onPressed: valid?(){
                Navigator.of(context).push(MaterialPageRoute(builder: (_)=>ResearchMain()));
              }:null, child: const Text('Login'))
            ],
          ),
        ),
      ),
    );
  }
}
