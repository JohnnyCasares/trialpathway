import 'package:flutter/material.dart';

import '../class_models/pathway.dart';
import '../widgets/custom_textformfield.dart';

class NewStep extends StatefulWidget {
  const NewStep({super.key, required this.title, this.step});
  final String title;
  final StepPathway? step;
  @override
  State<NewStep> createState() => _NewStepState();
}

class _NewStepState extends State<NewStep> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late List<TextEditingController> sources;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.step?.title);
    _descriptionController = TextEditingController(text: widget.step?.description);
    sources = List.from(widget.step?.sources?.map((e) => TextEditingController(text: e)) ??[]);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: SizedBox(
          width: 550,
          child: Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(20),
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


                      Navigator.of(context).pop(step);
                    }
                  },
                  child: Text('Save'),
                ),
              ],
            ),
          ),
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


