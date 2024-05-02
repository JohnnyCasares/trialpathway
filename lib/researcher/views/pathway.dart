import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hti_trialpathway/widgets/custom_textformfield.dart';

class Pathway extends StatefulWidget {
  const Pathway({super.key});

  @override
  State<Pathway> createState() => _PathwayState();
}

class _PathwayState extends State<Pathway> {
  late List<Widget> steps;

  @override
  void initState() {
    steps = [
      buildStep(
          1,
          Step(
              title: 'Weight yourself',
              description:
                  'Step on a scale and measure your weight in kilograms or pounds')),
      buildStep(
          2,
          Step(
              title: 'Measure food',
              description:
                  'Place your food on a scale and measure the weight of your food in grams or ounces')),
      buildStep(
          3, Step(title: 'Drink water', description: 'Access potable water')),
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
            child: ListView(
              children: [
                ...steps,
                Card(
                  child: ListTile(
                    title: Text('New Step'),
                    leading: Icon(Icons.add),
                    onTap: () async{
                      Step? newStep = await showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: NewStep(),
                            );
                          }) as Step?;

                      if (newStep != null) {
                        print('${newStep.title} ${newStep.description}');
                        setState(() {
                          steps.add(buildStep(4, newStep));
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget buildStep(int step, Step stepObject) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Card(
              child: ListTile(
                title: Text('Step $step: ${stepObject.title}'),
                trailing: Icon(Icons.info),
              ),
            ),
          ),
          ElevatedButton(onPressed: () {}, child: Icon(Icons.add)),
        ],
      ),
    );
  }

  Widget drawer() {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            title: Text('Gregor Samsa'),
          ),
          ListTile(
            title: Text('Yukio Mishima'),
          )
        ],
      ),
    );
  }
}

class NewStep extends StatefulWidget {
  const NewStep({super.key});

  @override
  State<NewStep> createState() => _NewStepState();
}

class _NewStepState extends State<NewStep> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
            alignment: Alignment.topRight,
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.close))),
        Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            children: [
              CustomTextFormField(
                controller: _nameController,
                hintText: 'Title',
              ),
              SizedBox(height: 16),
              CustomTextFormField(
                controller: _descriptionController,
                hintText: 'Description',
                multiLine: true,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Add logic to handle adding the step
                    // You can handle the data here, such as saving it or passing it back to the parent widget
                    Step step = Step(title: _nameController.text, description: _descriptionController.text);
                    Navigator.of(context)
                        .pop(step);
                  }
                },
                child: Text('Add'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Step {
  String title;
  String description;

  Step({required this.title, required this.description});
}
