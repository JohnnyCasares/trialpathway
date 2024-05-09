import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:hti_trialpathway/class_models/clinical_trial.dart';
import 'package:hti_trialpathway/class_models/clinical_trial_objects.dart';
import 'package:hti_trialpathway/services/hugging_face.dart';
import 'package:hti_trialpathway/widgets/my_appbar.dart';
import 'package:provider/provider.dart';

import '../../providers/db_provider.dart';
import '../../services/database.dart';

class ViewFullStudy extends StatefulWidget {
  const ViewFullStudy({super.key, required this.clinicalTrial});

  final ClinicalTrial clinicalTrial;

  @override
  State<ViewFullStudy> createState() => _ViewFullStudyState();
}

class _ViewFullStudyState extends State<ViewFullStudy> {
  String? summary;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    DatabaseQueries databaseQueries =
        DatabaseQueries(Provider.of<DBProvider>(context).getConnection());
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          setState(() {
            loading=true;
          });
          String tmp = await BartSummarize().summarizeText(text:widget.clinicalTrial.detailedDescription ??
              widget.clinicalTrial.description);
          setState(() {
            loading = false;
            summary = tmp;
          });
        },
        tooltip: 'Summarize',
        child: const Icon(Icons.summarize_outlined),
      ),
      appBar: const MyAppBar(),
      body: FutureBuilder(
        future: databaseQueries.getFullClinicalTrial(widget.clinicalTrial),
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
                        widget.clinicalTrial.officialTitle,
                        style: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      if(loading||summary!=null)
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Summary'),
                            if(loading)
                              const CircularProgressIndicator(),
                            if(summary!=null)
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Theme.of(context).colorScheme.primary),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: AnimatedTextKit(
                                isRepeatingAnimation: false,
                                animatedTexts: [
                                  TyperAnimatedText(summary!)
                                ],
                              ),),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SelectableText(
                        widget.clinicalTrial.nctID,
                        style: const TextStyle(fontStyle: FontStyle.italic),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SelectableText(widget.clinicalTrial.detailedDescription ??
                          widget.clinicalTrial.description),
                      const SizedBox(
                        height: 30,
                      ),
                      if (widget.clinicalTrial.interventions != null &&
                          widget.clinicalTrial.interventions!.isNotEmpty)
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
                                    ...widget.clinicalTrial.interventions!
                                        .map((e) => intervention(e))
                                  ],
                                )
                              ]),
                        ),
                      if (widget.clinicalTrial.outcomeMeasures != null &&
                          widget.clinicalTrial.outcomeMeasures!.isNotEmpty)
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
                                    ...widget.clinicalTrial.outcomeMeasures!
                                        .map((e) => outcome(e))
                                  ],
                                  dataRowMaxHeight: 150,
                                )
                              ]),
                        ),
                      if (widget.clinicalTrial.contactInformation != null &&
                          widget.clinicalTrial.contactInformation!.isNotEmpty)
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
                                  ...widget.clinicalTrial.contactInformation!
                                      .map((e) => contactInformation(e))
                                ],
                              )
                            ],
                          ),
                        ),
                      if (widget.clinicalTrial.contactsLocations != null &&
                          widget.clinicalTrial.contactsLocations!.isNotEmpty)
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
                                  ...widget.clinicalTrial.contactsLocations!
                                      .map((e) => locationsAndContacts(e))
                                ],
                              )
                            ],
                          ),
                        ),
                      if (widget.clinicalTrial.sponsors != null &&
                          widget.clinicalTrial.sponsors!.isNotEmpty)
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
                                    ...widget.clinicalTrial.sponsors!
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
  }
 //todo change format in which this is displayed. Emphasize contacts
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
