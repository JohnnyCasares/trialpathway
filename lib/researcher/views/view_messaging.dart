import 'package:flutter/material.dart';
import 'package:hti_trialpathway/widgets/custom_textformfield.dart';
import 'package:hti_trialpathway/widgets/multiple_selection.dart';

import '../../class_models/patient.dart';
import '../../class_models/researcher.dart';
import '../../main.dart';

class Messaging extends StatefulWidget {
  const Messaging({super.key});

  @override
  State<Messaging> createState() => _MessagingState();
}

class _MessagingState extends State<Messaging> {
  final Researcher _researcher = getIt<Researcher>();
  late List<Patient>? patients;

  @override
  void initState() {
    patients = _researcher.patients;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        child: Form(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Compose a message",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                CustomTextFormField(
                  readOnly: true,
                  hintText: "Pick patient",
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => MultipleSelectionDialog(
                                title: 'Pick recipients',
                                elements: _researcher.patients
                                    .map((e) => e.name)
                                    .toList())));
                  },
                ),
                CustomTextFormField(
                  hintText: "Subject",
                  validator: (subject) =>
                      subject!.isEmpty ? "Please enter a subject" : null,
                ),
                CustomTextFormField(
                  multiLine: true,
                  hintText: "Message",
                  validator: (body) =>
                      body!.isEmpty ? "Please type your message" : null,
                ),
                ElevatedButton(
                    onPressed: () async {}, child: const Text("Send"))
              ],
            ),
          ),
        ),
      ),
    ));
  }

  Widget drawer() {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Patients'),
          if (patients != null && patients!.length > 0)
            Expanded(
              child: ListView.builder(
                itemCount: patients!.length,
                itemBuilder: (BuildContext context, int index) {
                  return buildPatientListTile(patients![index]);
                },
              ),
            )
        ],
      ),
    );
  }

  ListTile buildPatientListTile(Patient patient) {
    return ListTile(
      onTap: () {},
      leading: Icon(Icons.person_outline),
      title: Text(patient.name),
    );
  }
}
