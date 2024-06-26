import 'package:flutter/material.dart';
import 'package:hti_trialpathway/class_models/patient.dart';
import 'package:hti_trialpathway/main.dart';
import 'package:hti_trialpathway/providers/patient_profile_provider.dart';
import 'package:hti_trialpathway/widgets/custom_textformfield.dart';
import 'package:provider/provider.dart';

import '../../class_models/database_models/general_data.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final Patient _patient = getIt<Patient>();
  final _formKey = GlobalKey<FormState>();
  late Sex _selectedSex;
  late ProfileVisibility _visibility;
  late TextEditingController _name;
  late TextEditingController _age;
  late TextEditingController _country;
  late TextEditingController _state;

  //clinical info
  late bool _healthy;
  late TextEditingController _conditions;
  bool _pregnant = false;
  final GeneralData _generalData = GeneralData();

  @override
  void initState() {
    _name = TextEditingController(text: _patient.name);
    _age = TextEditingController(text: _patient.age.toString());
    _selectedSex = _patient.sex;
    _country = TextEditingController(text: _patient.country);
    _state = TextEditingController(text: _patient.state);
    _healthy = _patient.healthy;
    _conditions = TextEditingController(
        text: _patient.conditions.isNotEmpty
            ? _patient.conditions
                .toString()
                .substring(1, _patient.conditions.toString().length - 1)
            : null);
    _pregnant = _patient.pregnant;
    _visibility = _patient.visibility;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PatientProfileProvider>(
        builder: (context, profileProvider, _) {
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
                    Text(
                      'Personal Information',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    ProfileTile(
                        title: 'Name',
                        field: CustomTextFormField(
                          onChanged: (value) {
                            if (value != _patient.name) {
                              profileProvider.didNameChange(true);
                            } else {
                              context
                                  .read<PatientProfileProvider>()
                                  .didNameChange(false);
                            }
                            // // Update profileChange whenever any field changes
                            profileProvider.didProfileChange();
                          },
                          onSaved: (value) {
                            setState(() {
                              _patient.name = value!;
                            });
                          },
                          controller: _name,
                        )),
                    ProfileTile(
                        title: 'Age',
                        field: CustomTextFormField(
                          onChanged: (value) {
                            if (value != _patient.age.toString()) {
                              profileProvider.didAgeChange(true);
                            } else {
                              profileProvider.didAgeChange(false);
                            }
                            profileProvider.didProfileChange();
                          },
                          onSaved: (value) {
                            if (value != null) {
                              setState(() {
                                _patient.age = int.parse(value);
                              });
                            }
                          },
                          controller: _age,
                        )),
                    ProfileTile(
                      title: 'Sex',
                      field: Row(
                        children: <Widget>[
                          Radio(
                            // initialValue: _selectedSex,
                            value: Sex.male,
                            groupValue: _selectedSex,
                            onChanged: (value) {
                              setState(() {
                                _selectedSex = value!;
                              });
                              if (value != _patient.sex) {
                                profileProvider.didSexChange(true);
                              } else {
                                profileProvider.didSexChange(false);
                              }
                              profileProvider.didProfileChange();
                            },
                          ),
                          const Text('Male'),
                          Radio(
                            // initialValue: _selectedSex,
                            value: Sex.female,
                            groupValue: _selectedSex,
                            onChanged: (value) {
                              setState(() {
                                _selectedSex = value!;
                              });
                              if (value != _patient.sex) {
                                profileProvider.didSexChange(true);
                              } else {
                                profileProvider.didSexChange(false);
                              }
                              profileProvider.didProfileChange();
                            },
                          ),
                          const Text('Female'),
                        ],
                      ),
                    ),
                    ProfileTile(
                        title: 'Country',
                        onTap: () async {
                          await chooseCountry(context, profileProvider);
                        },
                        field: CustomTextFormField(
                          readOnly: true,
                          controller: _country,
                          onSaved: (value) {
                            setState(() {
                              _patient.country = value!;
                            });
                          },
                          onTap: () async {
                            await chooseCountry(context, profileProvider);
                          },
                        )),
                    if (_country.text == 'United States')
                      ProfileTile(
                          title: 'State',
                          field: CustomTextFormField(
                            controller: _state,
                            onChanged: (value) {
                              if (value != _patient.state) {
                                profileProvider.didStateChange(true);
                              } else {
                                profileProvider.didStateChange(false);
                              }
                              profileProvider.didProfileChange();
                            },
                          )),
                    //clinical info: health? conditions, pregnancy,
                    Text(
                      'Clinical and Medical Information',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    CheckboxListTile(
                        title: const Text('Healthy'),
                        value: _healthy,
                        onChanged: (val) {
                          setState(() {
                            _healthy = val!;
                          });
                          if (val != _patient.healthy) {
                            profileProvider.didHealthyChange(true);
                          } else {
                            profileProvider.didHealthyChange(false);
                          }
                          profileProvider.didProfileChange();
                        }),
                    ProfileTile(
                        title: 'Conditions',
                        onTap: () async {
                          await chooseCondition(context, profileProvider);
                        },
                        field: CustomTextFormField(
                          readOnly: true,
                          controller: _conditions,
                          onSaved: (value) {
                            setState(() {
                              _patient.conditions = value!.split(',');
                            });
                          },
                          onTap: () async {
                            await chooseCondition(context, profileProvider);
                          },
                          hintText:
                              'Choose any condition or illness you may have',
                        )),
                    //only show if women
                    if (_selectedSex == Sex.female)
                      CheckboxListTile(
                          title: const Text('Pregnant'),
                          value: _pregnant,
                          onChanged: (val) {
                            setState(() {
                              _pregnant = val!;
                            });
                            if (val != _patient.pregnant) {
                              context
                                  .read<PatientProfileProvider>()
                                  .didPregnantChange(true);
                            } else {
                              context
                                  .read<PatientProfileProvider>()
                                  .didPregnantChange(false);
                            }
                            profileProvider.didProfileChange();
                          }),
                    Text(
                      'Profile Visibility',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    ProfileTile(
                      title: 'Visibility',
                      field: DropdownMenu(
                        initialSelection: _visibility,
                        dropdownMenuEntries: [
                          DropdownMenuEntry(
                              value: ProfileVisibility.Private,
                              label: 'Private'),
                          DropdownMenuEntry(
                              value: ProfileVisibility.Public, label: 'Public')
                        ],
                        onSelected: (value) async {
                          setState(() {
                            _visibility = value!;
                          });
                          if (_visibility == ProfileVisibility.Public) {
                            await showDialog(
                                context: context, builder: (_) => disclaimer());
                          }
                          if (_visibility != _patient.visibility) {
                            context
                                .read<PatientProfileProvider>()
                                .didVisibilityChange(true);
                          } else {
                            context
                                .read<PatientProfileProvider>()
                                .didVisibilityChange(false);
                          }
                          profileProvider.didProfileChange();
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Center(
                          child: ActionChip(
                        label: const Text('Save'),
                        onPressed: context
                                .watch<PatientProfileProvider>()
                                .profileChange
                            ? () {
                                saveChanges(profileProvider);
                              }
                            : null,
                      )),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  void saveChanges(PatientProfileProvider profileProvider) {
    if (_formKey.currentState!.validate()) {
      if (profileProvider.sex) {
        _patient.sex = _selectedSex;
      }
      if (profileProvider.healthy) {
        _patient.healthy = _healthy;
      }
      if (profileProvider.pregnant) {
        _patient.pregnant = _pregnant;
      }
      if (profileProvider.visibility) {
        _patient.visibility = _visibility;
      }
      _formKey.currentState!.save();
      profileProvider.didProfileChange();
      profileProvider.resetProfileProvider();
    }
  }

  Future<void> chooseCountry(
      BuildContext context, PatientProfileProvider profileProvider) async {
    String tmp =
        (await _generalData.countriesSearch(context) ?? _country.text).trim();
    setState(() {
      _country.text = tmp;
    });
    if (context.mounted) {
      if (tmp != _patient.country) {
        profileProvider.didCountryChange(true);
      } else {
        profileProvider.didCountryChange(false);
      }
      profileProvider.didProfileChange();
    }
  }

  Future<void> chooseCondition(
      BuildContext context, PatientProfileProvider profileProvider) async {
    String oldValue = _patient.conditions
        .toString()
        .substring(1, _patient.conditions.toString().length - 1);
    String tmp = (await _generalData.conditionsSearch(context,
                initialSelection: _conditions.text.split(',')) ??
            _conditions.text)
        .trim();

    setState(() {
      _conditions.text = tmp;
    });
    if (context.mounted) {
      if (oldValue != tmp) {
        profileProvider.didConditionsChange(true);
      } else {
        profileProvider.didConditionsChange(false);
      }
      profileProvider.didProfileChange();
    }
  }

  Widget disclaimer() {
    return AlertDialog(
      title: Text(
        'Profile Privacy Disclaimer',
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'By making your profile public, you agree to share the following information with researchers:',
          ),
          SizedBox(height: 10),
          Text('- Name'),
          Text('- Sex'),
          Text('- Country'),
          Text('- Conditions/Illness'),
          Text('- Age'),
          Text('- Health Status'),
          SizedBox(height: 10),
          Text(
            'Researchers may reach out to you based on this information to invite you to participate in their research studies.',
          ),
        ],
      ),
      actions: [
        ElevatedButton(
            onPressed: () {
              setState(() {
                _visibility = ProfileVisibility.Private;
              });
              Navigator.pop(context);
            },
            child: Text('Cancel')),
        ElevatedButton(
            onPressed: () => Navigator.pop(context), child: Text('Accept')),
      ],
    );
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
