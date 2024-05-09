import 'package:flutter/material.dart';
import 'package:hti_trialpathway/class_models/patient.dart';

import '../../class_models/pathway.dart';
import '../new_step.dart';

class ViewPatient extends StatefulWidget {
  const ViewPatient({super.key, required this.patient});

  final Patient patient;

  @override
  State<ViewPatient> createState() => _ViewPatientState();
}

class _ViewPatientState extends State<ViewPatient> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.patient.name),
      ),
      body:Builder(builder: (_){
        return Align(
          alignment: Alignment.topCenter,
          child: SizedBox(width: 500,
          child:  widget.patient.pathway == null || widget.patient.pathway!.isEmpty
              ? Card(
            key: Key('${widget.patient.pathway!.length}'),
            child: ListTile(
              title: Text('Assign Pathway'),
              leading: Icon(Icons.polyline_outlined),
              onTap: () async {
                //TODO: GO TO A VIEW THAT SHOWS AVAILABLE PATHS
              },
            ),
          )
              : ListView(
            children:
            //todo if  widget.patient.pathway is null, then show option to assign path way
            widget.patient.pathway!
                .map((e) =>
                buildStep((widget.patient.pathway!.indexOf(e)), e))
                .toList(),
          ),),
        );
      })

    );
  }

  Widget buildStep(int step, StepPathway stepObject) {
    return Padding(
      key: Key(stepObject.title),
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Expanded(
        child: Card(
          child: ListTile(
            title: Text('Step ${step + 1}: ${stepObject.title}'),
            trailing: Icon(Icons.info),
            onTap: () async {
              StepPathway? tmp = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => NewStep(
                            title: 'Edit step',
                            step: stepObject,
                          ))) as StepPathway?;

              if (tmp != null) {
                setState(() {
                  widget.patient.pathway![step] = tmp;
                });
              }
            },
          ),
        ),
      ),
    );
  }
}
