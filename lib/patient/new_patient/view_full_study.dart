import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hti_trialpathway/class_models/clinical_trial.dart';
import 'package:hti_trialpathway/class_models/clinical_trial_objects.dart';
import 'package:hti_trialpathway/widgets/my_appbar.dart';
import 'package:provider/provider.dart';

import '../../providers/db_provider.dart';
import '../../services/database.dart';

class ViewFullStudy extends StatelessWidget {
  const ViewFullStudy({super.key, required this.clinicalTrial});

  final ClinicalTrial clinicalTrial;

  @override
  Widget build(BuildContext context) {
    DatabaseQueries databaseQueries =
        DatabaseQueries(Provider.of<DBProvider>(context).getConnection());
    return Scaffold(
      appBar: const MyAppBar(),
      body: FutureBuilder(
        future: databaseQueries.getFullClinicalTrial(clinicalTrial),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: SizedBox(
                width: 1000,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(
                    children: [
                      Text(
                        clinicalTrial.officialTitle,
                        style: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SelectableText(
                        clinicalTrial.nctID,
                        style: const TextStyle(fontStyle: FontStyle.italic),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SelectableText(clinicalTrial.detailedDescription ??
                          clinicalTrial.description),
                      const SizedBox(
                        height: 30,
                      ),
                      if (clinicalTrial.interventions != null &&
                          clinicalTrial.interventions!.isNotEmpty)
                        Card(
                          child: ExpansionTile(
                              title: const Text('Interventions'),
                              children: [
                                DataTable(
                                  columns: const [
                                    DataColumn(label: Text('Type')),
                                    DataColumn(label: Text('Name')),
                                    DataColumn(label: Text('Description')),
                                  ],
                                  rows: [
                                    ...clinicalTrial.interventions!
                                        .map((e) => intervention(e))
                                  ],
                                )
                              ]),
                        ),
                      if (clinicalTrial.outcomeMeasures != null &&
                          clinicalTrial.outcomeMeasures!.isNotEmpty)
                        Card(
                          child: ExpansionTile(
                              title: const Text('Outcome Measures'),
                              children: [
                                DataTable(
                                  columns: const [
                                    DataColumn(label: Text('Type')),
                                    DataColumn(label: Text('Description')),
                                  ],
                                  rows: [
                                    ...clinicalTrial.outcomeMeasures!
                                        .map((e) => outcome(e))
                                  ],
                                  dataRowMaxHeight: 150,
                                )
                              ]),
                        ),
                      if (clinicalTrial.contactInformation != null &&
                          clinicalTrial.contactInformation!.isNotEmpty)
                        Card(
                          child: ExpansionTile(
                            title: const Text('Contact Information'),
                            children: [
                              DataTable(
                                columns: const [
                                  DataColumn(label: Text('Name')),
                                  DataColumn(label: Text('Phone')),
                                  DataColumn(label: Text('Email')),
                                ],
                                rows: [
                                  ...clinicalTrial.contactInformation!
                                      .map((e) => contactInformation(e))
                                ],
                              )
                            ],
                          ),
                        ),
                      if (clinicalTrial.contactsLocations != null &&
                          clinicalTrial.contactsLocations!.isNotEmpty)
                        Card(
                          child: ExpansionTile(
                            title: const Text('Locations and Contacts'),
                            children: [
                              DataTable(
                                columns: const [
                                  DataColumn(label: Text('Name')),
                                  DataColumn(label: Text('City')),
                                  DataColumn(label: Text('State')),
                                  DataColumn(label: Text('Zip')),
                                  DataColumn(label: Text('Country')),
                                ],
                                rows: [
                                  ...clinicalTrial.contactsLocations!
                                      .map((e) => locationsAndContacts(e))
                                ],
                              )
                            ],
                          ),
                        ),
                      if (clinicalTrial.sponsors != null &&
                          clinicalTrial.sponsors!.isNotEmpty)
                        Card(
                          child: ExpansionTile(
                              title: const Text('Sponsors'),
                              children: [
                                DataTable(
                                  columns: const [
                                    DataColumn(label: Text('Name')),
                                    DataColumn(label: Text('Agency Class')),
                                    DataColumn(label: Text('Type')),
                                  ],
                                  rows: [
                                    ...clinicalTrial.sponsors!
                                        .map((e) => sponsors(e))
                                  ],
                                )
                              ]),
                        ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            print(snapshot.error);
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  DataRow intervention(Intervention intervention) {
    return DataRow(cells: [
      DataCell(Text('${intervention.type}')),
      DataCell(Text('${intervention.name}')),
      DataCell(Text('${intervention.description}')),
    ]);
  }

  DataRow outcome(Outcome outcome) {
    return DataRow(cells: [
      DataCell(Text('${outcome.outComeType}')),
      DataCell(ConstrainedBox(
          constraints: BoxConstraints(maxHeight: double.infinity),
          child: SelectableText('${outcome.outComeDescription}'))),
    ]);
  }

  DataRow contactInformation(ContactInformation contactInformation) {
    return DataRow(cells: [
      DataCell(Text('${contactInformation.name}')),
      DataCell(Text('${contactInformation.phone}')),
      DataCell(Text('${contactInformation.email}')),
    ]);
  } //todo change format in which this is displayed. Emphasize contacts
  //todo: maybe make contact number, email or stuff selectable to contact
  //todo: on phone maybe launch call app on phone, and email app on email

  DataRow locationsAndContacts(ContactLocation contactLocation) {
    return DataRow(cells: [
      DataCell(Text(contactLocation.name ?? 'N/A')),
      DataCell(Text(contactLocation.city ?? 'N/A')),
      DataCell(Text(contactLocation.state ?? 'N/A')),
      DataCell(Text(contactLocation.zip ?? 'N/A')),
      DataCell(Text(contactLocation.country ?? 'N/A')),
    ]);
  }

  DataRow sponsors(Sponsors sponsors) {
    return DataRow(cells: [
      DataCell(Text('${sponsors.name}')),
      DataCell(Text('${sponsors.agencyClass}')),
      DataCell(Text('${sponsors.leadOrCollaborator}')),
    ]);
  }
}
