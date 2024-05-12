import 'package:flutter/material.dart';
import 'package:hti_trialpathway/main.dart';
import 'package:hti_trialpathway/researcher/view_alt_steps.dart';
import 'package:hti_trialpathway/researcher/views/view_patient.dart';

import '../../class_models/pathway.dart';
import '../../class_models/patient.dart';
import '../../class_models/researcher.dart';
import '../new_step.dart';

class ViewPathway extends StatefulWidget {
  const ViewPathway({super.key});

  @override
  State<ViewPathway> createState() => _ViewPathwayState();
}

class _ViewPathwayState extends State<ViewPathway> {
  ValueNotifier<bool> isDialOpen = ValueNotifier(false);
  final Researcher _researcher = getIt<Researcher>();
  late List<Pathway> pathways;

  late List<Patient>? patients;
  int pathwaysIndex = 0;

  @override
  void initState() {
    pathways = _researcher.pathways;
    patients = _researcher.patients;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        floatingActionButton: FloatingActionButton(
          tooltip: 'New Pathway',
          onPressed: () async {
            Pathway? tmp = await showDialog(
                context: context, builder: (_) => Pathway.newPathway(context));
            if (tmp != null)
              setState(() {
                _researcher.pathways.add(tmp);
              });
          },
          child: Icon(Icons.polyline_outlined),
        ),
        drawer: drawer(),
        body: Center(
          child: SizedBox(
            width: 500,
            child: Builder(builder: (context) {
              if (pathways.isNotEmpty) {
                return buildPathwayView(context, pathways[pathwaysIndex].steps);
              } else {
                return ElevatedButton(
                  child: Text('Add Pathway'),
                  onPressed: () async {
                    Pathway? tmp = await showDialog(
                        context: context,
                        builder: (_) => Pathway.newPathway(context));
                    if (tmp != null) {
                      setState(() {
                        _researcher.pathways.add(tmp);
                      });
                    }
                  },
                );
              }
            }),
          ),
        ));
  }

  ReorderableListView buildPathwayView(
      BuildContext context, List<StepPathway>? steps) {
    return ReorderableListView(
        header: Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Wrap(
            spacing: 10,
            children: _researcher.pathways
                .map((e) => ElevatedButton(
                    onLongPress: () {
                      showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                                title: Text('Delete Pathway'),
                                content: Text(
                                    'Are you sure you wish to delete this pathway?'),
                                actions: [
                                  ElevatedButton.icon(
                                    icon: Icon(Icons.cancel_outlined),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    label: Text('Cancel'),
                                  ),
                                  ElevatedButton.icon(
                                    icon: Icon(Icons.delete_outline),
                                    onPressed: () {
                                      setState(() {
                                        _researcher.pathways.remove(e);
                                      });
                                      Navigator.pop(context);
                                    },
                                    label: Text('Delete'),
                                  )
                                ],
                              ));
                    },
                    onPressed: () {
                      setState(() {
                        pathwaysIndex = _researcher.pathways.indexOf(e);
                      });
                    },
                    child: Text(e.name)))
                .toList(),
          ),
        ),
        buildDefaultDragHandles: false,
        onReorder: (int oldIndex, int newIndex) {
          setState(() {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            final StepPathway item = steps.removeAt(oldIndex);
            steps.insert(newIndex, item);
          });
        },
        children:
            steps!.map((e) => buildStep((steps.indexOf(e)), e, steps)).toList(),
        footer: Card(
          key: Key('${steps.length}'),
          child: ListTile(
            title: Text('New Step'),
            leading: Icon(Icons.add),
            onTap: () async {
              StepPathway? newStep = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => NewStep(
                            title: 'New Step',
                          ))) as StepPathway?;

              if (newStep != null) {
                // print('${newStep.title} ${newStep.description}');
                setState(() {
                  steps.add(newStep);
                });
              }
            },
          ),
        ));
  }

  Widget buildStep(int step, StepPathway stepObject, List<StepPathway> steps) {
    return Padding(
      key: Key(stepObject.title),
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        children: [
          Expanded(
            child: Card(
              child: ListTile(
                leading: ReorderableDragStartListener(
                  index: step,
                  child: Icon(Icons.drag_handle),
                ),
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
                      steps[step] = tmp;
                    });
                  }
                },
                onLongPress: () {
                  showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                            title: Text('Delete Step'),
                            content: Text(
                                'Are you sure you wish to delete this step?'),
                            actions: [
                              ElevatedButton.icon(
                                icon: Icon(Icons.cancel_outlined),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                label: Text('Cancel'),
                              ),
                              ElevatedButton.icon(
                                icon: Icon(Icons.delete_outline),
                                onPressed: () {
                                  setState(() {
                                    steps.removeAt(step);
                                  });
                                  Navigator.pop(context);
                                },
                                label: Text('Delete'),
                              )
                            ],
                          ));
                },
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          if (steps[step].altSteps.isEmpty)
            Tooltip(
                message: 'Add alternative step',
                child: ElevatedButton(
                  onPressed: () async {
                    StepPathway? altStep = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>
                                NewStep(title: 'Alternative Step')));

                    if (altStep != null) {
                      setState(() {
                        steps[step].altSteps.add(altStep);
                      });
                    }
                  },
                  child: Icon(Icons.add),
                )),
          if (steps[step].altSteps.isNotEmpty)
            Tooltip(
                message: 'View alternative steps',
                child: ElevatedButton(
                  onPressed: () async {
                    List<StepPathway>? altSteps = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => ViewAlternativeStep(
                                initAltSteps: steps[step].altSteps)));
                    print(altSteps);
                    print(steps[step].altSteps);
                  },
                  child: Icon(Icons.keyboard_arrow_right),
                )),
        ],
      ),
    );
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
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => ViewPatient(patient: patient)));
      },
      leading: Icon(Icons.person_outline),
      title: Text(patient.name),
    );
  }
}
