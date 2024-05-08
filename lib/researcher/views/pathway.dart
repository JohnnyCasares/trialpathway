import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hti_trialpathway/researcher/views/view_alt_steps.dart';
import 'package:hti_trialpathway/researcher/views/view_patient.dart';
import '../../class_models/patient.dart';
import 'new_step.dart';

class ViewPathway extends StatefulWidget {
  const ViewPathway({super.key});

  @override
  State<ViewPathway> createState() => _ViewPathwayState();
}

class _ViewPathwayState extends State<ViewPathway> {
  late List<StepPathway> steps;
  List<Patient> patients = [
    Patient.generateMockPatient(),
    Patient.generateMockPatient()
  ];

  @override
  void initState() {
    steps = [
      StepPathway(
          title: 'Weight yourself',
          description:
              'Step on a scale and measure your weight in kilograms or pounds'),
      StepPathway(
          title: 'Measure food',
          description:
              'Place your food on a scale and measure the weight of your food in grams or ounces'),
      StepPathway(title: 'Drink water', description: 'Access potable water'),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        drawer: drawer(),
        body: Center(
          child: SizedBox(
            width: 500,
            child: ReorderableListView(
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
                  steps.map((e) => buildStep((steps.indexOf(e)), e)).toList(),
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
              ),
            ),
          ),
        ));
  }

  Widget buildStep(int step, StepPathway stepObject) {
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
          Expanded(
            child: ListView.builder(
              itemCount: patients.length,
              itemBuilder: (BuildContext context, int index) {
                return buildPatientListTile(patients[index]);
              },
            ),
          )
        ],
      ),
    );
  }

  ListTile buildPatientListTile(Patient patient) {
    return ListTile(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (_)=>ViewPatient(patient: patient)));
      },
      leading: Icon(Icons.person_outline),
      title: Text(patient.name),
    );
  }
}

