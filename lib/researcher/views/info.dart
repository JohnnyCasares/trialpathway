import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hti_trialpathway/services/hugging_face.dart';

import '../../class_models/clinical_trial.dart';
import '../../class_models/database_models/general_data.dart';
import '../../widgets/custom_textformfield.dart';

class Info extends StatefulWidget {
  @override
  _InfoState createState() => _InfoState();
}

class _InfoState extends State<Info> {
  final TextEditingController _nctIDController =
      TextEditingController(text: 'NCT123456');
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _officialTitleController =
      TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _briefDescriptionController =
      TextEditingController();
  final TextEditingController _conditionsController = TextEditingController();
  final TextEditingController _countriesController = TextEditingController();

  // Add controllers for other attributes as needed
  final GeneralData _generalData = GeneralData();

  // Method to save form data into a ClinicalTrial object
  ClinicalTrial _saveFormData() {
    return ClinicalTrial(
      nctID: _nctIDController.text,
      title: _titleController.text,
      officialTitle: _officialTitleController.text,
      lastDateUpdate: null,
      status: '',
      startDate: null,
      startDateType: '',
      description: '',
      // Assign other attributes here
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            child: SizedBox(
              width: 800,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextFormField(
                      controller: _nctIDController,
                      hintText: 'NCT ID',
                      readOnly: true,
                    ),
                    CustomTextFormField(
                      controller: _titleController,
                      hintText: 'Title',
                    ),
                    CustomTextFormField(
                      controller: _officialTitleController,
                      hintText: 'Official Title',
                    ),
                    Text(
                        'Use the summarize button to create a brief description based on this field'),

                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: CustomTextFormField(
                            keyboardType: TextInputType.multiline,
                            controller: _descriptionController,
                            hintText: 'Description',
                            multiLine: true,
                            validator: (val) => ((val!.length < 2000))
                                ? 'Please provide more details'
                                : null,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Tooltip(
                          message: 'Summarize',
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_descriptionController.text.isNotEmpty &&
                                  (_descriptionController.text.length >=
                                      2000)) {
                                String summary = await BartSummarize()
                                    .summarizeText(
                                        text: _descriptionController.text,
                                        minLength: 200,
                                        maxLength: 300);
                                setState(() {
                                  _briefDescriptionController.text = summary;
                                });
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        'Please provide more details in your description')));
                              }
                            },
                            child: Icon(Icons.summarize_outlined),
                          ),
                        )
                      ],
                    ),
                    CustomTextFormField(
                      keyboardType: TextInputType.multiline,
                      controller: _briefDescriptionController,
                      hintText: 'Brief Description',
                      multiLine: true,
                    ),

                    CustomTextFormField(
                      readOnly: true,
                      controller: _conditionsController,
                      onSaved: (value) {},
                      onTap: () async {
                        String? tmp =
                            await _generalData.conditionsDialog(context);
                        setState(() {
                          _conditionsController.text = tmp.toString();
                        });
                      },
                      hintText: 'Conditions and/or illnesses related to trial',
                    ),
                    CustomTextFormField(
                      readOnly: true,
                      controller: _countriesController,
                      onSaved: (value) {},
                      onTap: () async {
                        String? tmp =
                        await _generalData.countriesDialog(context, multipleSelection: true);
                        setState(() {
                          _countriesController.text = tmp.toString();
                        });
                      },
                      hintText: 'Countries',
                    ),
                    //Eligibility criteria
                    //ContactInformation
                    //ContactLocation
                    //Intervention
                    //Outcome
                    //Sponsors
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        // Save the form data and navigate to the next screen
                        ClinicalTrial clinicalTrial = _saveFormData();
                        // Navigate to the next screen or perform other actions
                      },
                      child: Text('Save'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose of controllers when the widget is disposed
    _nctIDController.dispose();
    _titleController.dispose();
    _officialTitleController.dispose();
    super.dispose();
  }
}
