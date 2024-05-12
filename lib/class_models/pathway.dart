import 'package:flutter/material.dart';
import 'package:hti_trialpathway/widgets/custom_textformfield.dart';

class Pathway {
  String name;
  List<StepPathway> steps = [];

  Pathway(this.name);

  static Widget newPathway(BuildContext context) {
    TextEditingController name = TextEditingController();
    return AlertDialog(
      title: Text('New Pathway'),
      content: CustomTextFormField(
        hintText: 'Name your pathway',
        controller: name,
      ),
      actions: [
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel')),
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context, Pathway(name.text.trim()));
            },
            child: Text('Create Pathway'))
      ],
    );
  }
}

class StepPathway {
  String title;
  String description;
  List<String>? sources;
  List<StepPathway> altSteps = [];

  StepPathway({required this.title, required this.description, this.sources});
}
