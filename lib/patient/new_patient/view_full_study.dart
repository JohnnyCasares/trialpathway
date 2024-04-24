import 'package:flutter/material.dart';
import 'package:hti_trialpathway/class_models/clinical_trial.dart';
import 'package:hti_trialpathway/widgets/my_appbar.dart';

import '../../services/database.dart';

class ViewFullStudy extends StatelessWidget {
  const ViewFullStudy({super.key, required this.clinicalTrial});
  final ClinicalTrial clinicalTrial;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: FutureBuilder(
        future: DatabaseQueries().getFullClinicalTrial(clinicalTrial),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            return ListView(
              children:  [
                Text(clinicalTrial.officialTitle, style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                Text(clinicalTrial.detailedDescription??clinicalTrial.description),
                Divider(),
                Text(clinicalTrial.interventions?.length.toString()??'Nada'),
                Divider(),
                Text(clinicalTrial.outcomeMeasures?.length.toString()??'Nada'),
                Divider(),
                Text(clinicalTrial.contactInformation?.length.toString()??'Nada'),
                Divider(),
                Text(clinicalTrial.contactsLocations?.length.toString()??'Nada'),
              ],
            );
          }else{
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
