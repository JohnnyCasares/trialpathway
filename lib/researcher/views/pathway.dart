import 'package:flutter/material.dart';
import 'add_step.dart';

class Pathway extends StatefulWidget {
  const Pathway({super.key});

  @override
  State<Pathway> createState() => _PathwayState();
}

class _PathwayState extends State<Pathway> {
  late List<StepPathway> steps;

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
                      print('${newStep.title} ${newStep.description}');
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
                onTap: () async{
                  StepPathway? tmp = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => NewStep(
                                title: 'Edit step',
                                step: stepObject,
                              ))) as StepPathway?;

                  if(tmp != null){
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
          Tooltip(
              message: 'Add alternative step',
              child: ElevatedButton(
                onPressed: () {},
                child: Icon(Icons.add),
              )),
        ],
      ),
    );
  }

  Widget drawer() {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.polyline_outlined),
            title: Text('Main'),
          ),
          DrawerHeader(
            child: Text('Patients'),
          ),
          ListTile(
            leading: Icon(Icons.person_outline),
            title: Text('Gregor Samsa'),
          ),
          ListTile(
            leading: Icon(Icons.person_outline),
            title: Text('Yukio Mishima'),
          )
        ],
      ),
    );
  }
}
