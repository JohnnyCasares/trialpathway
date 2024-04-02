import 'package:flutter/material.dart';
import 'package:hti_trialpathway/widgets/custom_textformfield.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //personal info: name, age, sex
          const Text('Personal Information', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          const ListTile(leading: Text('Name'),title:  CustomTextFormField(
              hintText: 'Full Name',
            ),
          ),
          const ListTile(leading: Text('Age'),title: CustomTextFormField(
              hintText: 'Age',
            ),
          ),
          ListTile(
            leading: const Text('Sex'),
            title: Column(
              children: [
                CheckboxListTile(
                    title: const Text('Male'), value: false, onChanged: (val) {}),
                CheckboxListTile(
                    title: const Text('Female'), value: false, onChanged: (val) {}),
              ],
            ),
          ),

          //clinical info: health? conditions, pregnancy,
          const Text('Clinical and Medical Information', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          CheckboxListTile(
              title: const Text('Healthy'), value: false, onChanged: (val) {}),
          const ListTile(leading: Text('Conditions'),title: CustomTextFormField()),
          //only show if women
          CheckboxListTile(
              title: const Text('Pregnant'), value: false, onChanged: (val) {}),
        ],
      ),
    );
  }
}
