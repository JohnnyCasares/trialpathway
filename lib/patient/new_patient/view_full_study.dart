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
            return ListView(
              children: [
                Text(
                  clinicalTrial.officialTitle,
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                Text(clinicalTrial.detailedDescription ??
                    clinicalTrial.description),
                if (clinicalTrial.interventions != null &&
                    clinicalTrial.interventions!.isNotEmpty)
                  Card(
                    child:
                        ExpansionTile(title: const Text('Interventions'), children: [
                      Table(
                        children: [
                          const TableRow(children: [
                            Text('Type'),
                            Text('Name'),
                            Text('Description'),
                          ]),
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
                          Table(
                            children: [
                              const TableRow(children: [
                                Text('Type'),
                                Text('Description'),
                              ]),
                              ...clinicalTrial.outcomeMeasures!
                                  .map((e) => outcome(e))
                            ],
                          )
                        ]),
                  ),
                if (clinicalTrial.contactInformation != null &&
                    clinicalTrial.contactInformation!.isNotEmpty)
                  Card(
                    child: ExpansionTile(
                      title: const Text('Contact Information'),
                      children: [
                        Table(
                          children: [
                            const TableRow(children: [
                              Text('Name'),
                              Text('Phone'),
                              Text('Email'),
                            ]),
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
                        Table(
                          children: [
                            const TableRow(children: [
                              Text('Name'),
                              Text('City'),
                              Text('State'),
                              Text('Zip'),
                              Text('Country'),

                            ]),
                            ...clinicalTrial.contactsLocations!
                                .map((e) => locationsAndContacts(e)
                            )
                          ],
                        )
                      ]
                          ,
                    ),
                  ),
                if (clinicalTrial.sponsors != null &&
                    clinicalTrial.sponsors!.isNotEmpty)
                  Card(
                    child: ExpansionTile(
                      title: const Text('Sponsors'),
                      children: [
                        Table(children: [
                          const TableRow(children: [
                            Text('Name'),
                            Text('Agency Class'),
                            Text('Type'),
                          ]),
                          ...clinicalTrial.sponsors!
                              .map((e) => sponsors(e))
                        ],)
                          ]
                    ),
                  ),
              ],
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

  TableRow intervention(Intervention intervention) {
    return TableRow(children: [
      Text('${intervention.type}'),
      Text('${intervention.name}'),
      Text('${intervention.description}'),
    ]);
  }

  TableRow outcome(Outcome outcome) {
    return TableRow(children: [
      Text('${outcome.outComeType}'),
      Text('${outcome.outComeDescription}'),
    ]);
  }

  TableRow contactInformation(ContactInformation contactInformation) {
    return TableRow(children: [
      Text('${contactInformation.name}'),
      Text('${contactInformation.phone}'),
      Text('${contactInformation.email}'),
    ]);
  }

  TableRow locationsAndContacts(ContactLocation contactLocation) {
    return TableRow(
      children: [
        Text('${contactLocation.name}'),
        Text('${contactLocation.city}'),
        Text('${contactLocation.state}'),
        Text('${contactLocation.zip}'),
        Text('${contactLocation.country}'),
      ]
    );
  }

  TableRow sponsors(Sponsors sponsors) {

    return TableRow(
      children: [
        Text('${sponsors.name}'),
        Text('${sponsors.agencyClass}'),
        Text('${sponsors.leadOrCollaborator}'),
      ]
    );
  }
}
