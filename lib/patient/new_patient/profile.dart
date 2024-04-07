import 'package:flutter/material.dart';
import 'package:hti_trialpathway/class_models/patient.dart';
import 'package:hti_trialpathway/main.dart';
import 'package:hti_trialpathway/widgets/custom_textformfield.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Patient patient = getIt<Patient>();
  late Sex _selectedSex;
  late TextEditingController name;
  late TextEditingController age;
  late TextEditingController country;
  late TextEditingController state;
  //clinical info
  late bool healthy;
  late TextEditingController conditions;
  bool pregnant = false;
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

                      controller: name,
                    )),
                ProfileTile(
                    title: 'Age',
                    field: CustomTextFormField(

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
                    field: CustomTextFormField(

                      controller: country,
                    )),
                ProfileTile(
                    title: 'State',
                    field: CustomTextFormField(

                      controller: state,
                    )),
                //clinical info: health? conditions, pregnancy,
                const Text('Clinical and Medical Information',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                CheckboxListTile(
                    title: const Text('Healthy'),
                    value: healthy,
                    onChanged: (val) {}),
                ProfileTile(
                    title: 'Conditions',
                    field: CustomTextFormField(
                      hintText: 'Choose any condition or illness you may have',
                      controller: conditions,
                    )),
                //only show if women
                if (_selectedSex == Sex.female)
                  CheckboxListTile(
                      title: const Text('Pregnant'),
                      value: pregnant,
                      onChanged: (val) {}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileTile extends StatelessWidget {
  const ProfileTile({super.key, required this.title, required this.field});
  final String title;
  final Widget field;
  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: SizedBox(width: 60, child: Text(title)), title: field);
  }
}
