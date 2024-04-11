import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hti_trialpathway/class_models/patient.dart';
import 'package:hti_trialpathway/main.dart';
import 'package:hti_trialpathway/widgets/custom_textformfield.dart';
import '../../class_models/database_models/general_data.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Patient patient = getIt<Patient>();
  final _formKey = GlobalKey<FormState>();
  bool _formChange = false;
  late Sex _selectedSex;
  late TextEditingController name;
  late TextEditingController age;
  late TextEditingController country;
  late TextEditingController state;
  //clinical info
  late bool healthy;
  late TextEditingController conditions;
  bool pregnant = false;
  GeneralData generalData = GeneralData();
  @override
  void initState() {
    name = TextEditingController(text: patient.name);
    age = TextEditingController(text: patient.age.toString());
    _selectedSex = patient.sex;
    country = TextEditingController(text: patient.country);
    state = TextEditingController(text: patient.state);
    healthy = patient.healthy;
    conditions = TextEditingController(
        text: patient.conditions.isNotEmpty
            ? patient.conditions
                .toString()
                .substring(1, patient.conditions.toString().length - 1)
            : null);
    pregnant = patient.pregnant;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Center(
          child: SizedBox(
            width: 600,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //personal info: name, age, sex
                  const Text(
                    'Personal Information',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  ProfileTile(
                      title: 'Name',
                      field: CustomTextFormField(
                        onChanged: (value) {
                          onChangeProfileField(value, patient.name);
                        },
                        onSaved: (value) {
                          setState(() {
                            patient.name = value!;
                          });
                        },
                        controller: name,
                      )),
                  ProfileTile(
                      title: 'Age',
                      field: CustomTextFormField(
                        onChanged: (value) {
                          onChangeProfileField(value, patient.age.toString());
                        },
                        onSaved: (value) {
                          if (value != null) {
                            setState(() {
                              patient.age = int.parse(value);
                            });
                          }
                        },
                        controller: age,
                      )),
                  ProfileTile(
                    title: 'Sex',
                    field: Row(
                      children: <Widget>[
                        Radio(
                          value: Sex.male,
                          groupValue: _selectedSex,
                          onChanged: (value) {
                            setState(() {
                              _selectedSex = value as Sex;
                            });
                          },
                        ),
                        const Text('Male'),
                        Radio(
                          value: Sex.female,
                          groupValue: _selectedSex,
                          onChanged: (value) {
                            setState(() {
                              _selectedSex = value as Sex;
                            });
                          },
                        ),
                        const Text('Female'),
                      ],
                    ),
                  ),
                  ProfileTile(
                      title: 'Country',
                      onTap: () async {
                        await chooseCountry(context);
                      },
                      field: CustomTextFormField(
                        readOnly: true,
                        controller: country,
                        onSaved: (value) {
                          setState(() {
                            patient.country = value!;
                          });
                        },
                        onTap: () async {
                          await chooseCountry(context);
                        },
                      )),
                  if (country.text == 'United States')
                    ProfileTile(
                        title: 'State',
                        field: CustomTextFormField(
                          controller: state,
                          onChanged: (value) {
                            onChangeProfileField(value, patient.state);
                          },
                        )),
                  //clinical info: health? conditions, pregnancy,
                  const Text('Clinical and Medical Information',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  CheckboxListTile(
                      title: const Text('Healthy'),
                      value: healthy,
                      onChanged: (val) {}),
                  ProfileTile(
                      title: 'Conditions',
                      onTap: () async {
                        await chooseCondition(context);
                      },

                      field: CustomTextFormField(
                        readOnly: true,
                        controller: conditions,
                        onSaved: (value) {
                          setState(() {
                            patient.conditions = value!.split(',');
                          });
                        },
                        onTap: () async {
                          await chooseCondition(context);
                        },

                        hintText:
                            'Choose any condition or illness you may have',


                      )),
                  //only show if women
                  if (_selectedSex == Sex.female)
                    CheckboxListTile(
                        title: const Text('Pregnant'),
                        value: pregnant,
                        onChanged: (val) {}),

                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                        child: ActionChip(
                      label: const Text('Save'),
                      onPressed: _formChange
                          ? () {
                              saveChanges();
                            }
                          : null,
                    )),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void saveChanges() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _formChange = false;
      });
    } else {
      setState(() {
        _formChange = false;
      });
    }
  }

  Future<void> chooseCountry(BuildContext context) async {
     String tmp =
        (await generalData.countriesDialog(context) ??
                country.text)
            .trim();
    setState(() {
      country.text = tmp;
    });
    onChangeProfileField(tmp, patient.country);
  }

  Future<void> chooseCondition(BuildContext context) async {
    String oldValue = patient.conditions
        .toString()
        .substring(1, patient.conditions.toString().length - 1);
    String tmp = (await generalData.conditionsDialog(context,
            initialSelection: conditions.text.split(',')) ??
        conditions.text).trim();


    setState(() {
      conditions.text = tmp;
    });
    onChangeProfileField(tmp, oldValue);
  }

  void onChangeProfileField(String value, String oldValue) {
    if (!_formKey.currentState!.validate()) {
      setState(() {
        _formChange = false;
      });
    } else {
      if (value != oldValue) {
        setState(() {
          _formChange = true;
        });
      } else {
        setState(() {
          _formChange = false;
        });
      }
    }
  }
}

class ProfileTile extends StatelessWidget {
  const ProfileTile(
      {super.key,
      required this.title,
      required this.field,
      this.onTap,
      this.textChanged = false});
  final String title;
  final Widget field;
  final Function()? onTap;
  final bool textChanged;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(width: 60, child: Text(title)),
      title: field,
      onTap: onTap,
    );
  }
}
