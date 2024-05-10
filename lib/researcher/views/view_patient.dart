import 'package:flutter/material.dart';
import 'package:hti_trialpathway/class_models/patient.dart';
import 'package:hti_trialpathway/class_models/researcher.dart';
import 'package:hti_trialpathway/main.dart';

import '../../class_models/pathway.dart';

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
        body: Builder(builder: (_) {
          return Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: 500,
              child: widget.patient.pathway!.isEmpty
                  ? Card(
                      key: Key('${widget.patient.pathway!.length}'),
                      child: ListTile(
                        title: Text('Assign Pathway'),
                        leading: Icon(Icons.polyline_outlined),
                        onTap: () async {
                          List<StepPathway>? tmp = await showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                    title: Text('Pick a path to assign'),
                                    content: SizedBox(
                                      width: 500,
                                      height: 700,
                                      child: ListView(
                                        shrinkWrap: true,
                                        children: getIt<Researcher>()
                                            .pathways
                                            .map((e) => Card(
                                                  child: ListTile(
                                                    onTap: () {
                                                      Navigator.pop(
                                                          context, e.steps);
                                                    },
                                                    title: Text(e.name),
                                                  ),
                                                ))
                                            .toList(),
                                      ),
                                    ),
                                  ));
                          if (tmp != null) {
                            setState(() {
                              widget.patient.pathway = tmp;
                            });
                          }
                        },
                      ),
                    )
                  : ListView(
                      children: widget.patient.pathway!
                          .map((e) => buildStep(
                              (widget.patient.pathway!.indexOf(e)), e))
                          .toList(),
                    ),
            ),
          );
        }));
  }

  Widget buildStep(int step, StepPathway stepObject) {
    return Padding(
      key: Key(stepObject.title),
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Card(
        child: ListTile(
          title: Text('Step ${step + 1}: ${stepObject.title}'),
          trailing: Icon(Icons.info),
          onTap: () async {
            // StepPathway? tmp = await Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (_) => NewStep(
            //               title: 'Edit step',
            //               step: stepObject,
            //             ))) as StepPathway?;
            //
            // if (tmp != null) {
            //   setState(() {
            //     widget.patient.pathway![step] = tmp;
            //   });
            // }
          },
        ),
      ),
    );
  }
}
