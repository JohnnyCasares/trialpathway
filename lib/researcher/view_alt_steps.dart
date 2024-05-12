import 'package:flutter/material.dart';
import 'package:hti_trialpathway/researcher/new_step.dart';

import '../class_models/pathway.dart';
import '../widgets/custom_textformfield.dart';

class ViewAlternativeStep extends StatefulWidget {
  const ViewAlternativeStep({super.key, required this.initAltSteps});

  final List<StepPathway> initAltSteps;

  @override
  State<ViewAlternativeStep> createState() => _ViewAlternativeStepState();
}

class _ViewAlternativeStepState extends State<ViewAlternativeStep> {
  late List<StepPathway> altSteps;
  bool displayForm = false;

  @override
  void initState() {
    altSteps = widget.initAltSteps;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alternative Steps'),
      ),
      body: Center(
        child: SizedBox(
          width: 500,
          child: ListView(padding: EdgeInsets.all(15), children: [
            ...altSteps.map((e) => Card(
                    child: ListTile(
                  onTap: () async {
                    StepPathway? tmp = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => NewStep(
                                  title: 'Edit alternative step',
                                  step: e,
                                ))) as StepPathway?;

                    if (tmp != null) {
                      setState(() {
                        altSteps[altSteps.indexOf(e)] = tmp;
                      });
                    }
                  },
                  title: Text(e.title),
                  subtitle: Text(e.description),
                  trailing: IconButton(
                    icon: Icon(Icons.delete_outline),
                    onPressed: () {
                      setState(() {
                        altSteps.remove(e);
                      });
                    },
                  ),
                ))),
            if (displayForm)
              Card(
                child: NewStepQuickForm(
                  addAltPathWay: (val) {
                    if (val == null) {
                      setState(() {
                        displayForm = false;
                      });
                    } else {
                      setState(() {
                        altSteps.add(val);
                        displayForm = false;
                      });
                    }
                  },
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    displayForm = true;
                  });
                },
                icon: Icon(Icons.add),
                label: Text('Add step'),
              ),
            )
          ]),
        ),
      ),
    );
  }
}

class NewStepQuickForm extends StatefulWidget {
  const NewStepQuickForm({
    super.key,
    required this.addAltPathWay,
  });

  final Function(StepPathway?) addAltPathWay;

  @override
  State<NewStepQuickForm> createState() => _NewStepQuickFormState();
}

class _NewStepQuickFormState extends State<NewStepQuickForm> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  List<TextEditingController> sources = [];

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text('New Alternative Step'),
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
            Text('Sources'),
            ...sources.map((e) => buildSourceInput(sources.indexOf(e), e)),
            Card(
                child: ListTile(
              title: Text('Add source'),
              trailing: Icon(Icons.add),
              onTap: () {
                setState(() {
                  sources.add(new TextEditingController());
                });
              },
            )),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () {
                      widget.addAltPathWay(null);
                    },
                    child: Text('Cancel')),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Add logic to handle adding the step
                      // You can handle the data here, such as saving it or passing it back to the parent widget
                      StepPathway step = StepPathway(
                          title: _nameController.text,
                          description: _descriptionController.text,
                          sources: sources.isNotEmpty
                              ? List.from(sources.map((e) => e.text))
                              : null);

                      widget.addAltPathWay(step);
                    }
                  },
                  child: Text('Save'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Row buildSourceInput(int index, TextEditingController textEditingController) {
    return Row(
      children: [
        Expanded(
          child: CustomTextFormField(
            controller: textEditingController,
            hintText: 'Source ${index + 1}',
          ),
        ),
        IconButton(
            onPressed: () {
              setState(() {
                sources.removeAt(index);
              });
            },
            icon: Icon(Icons.delete_outline))
      ],
    );
  }
}
