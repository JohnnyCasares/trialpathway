import 'package:flutter/material.dart';
import 'package:hti_trialpathway/class_models/clinical_trial.dart';
import 'package:hti_trialpathway/class_models/patient.dart';
import 'package:hti_trialpathway/patient/new_patient/view_full_study.dart';
import 'package:hti_trialpathway/services/database.dart';
import 'package:hti_trialpathway/services/file_storage.dart';
import 'package:hti_trialpathway/widgets/custom_textformfield.dart';
import 'package:postgres/postgres.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import '../../providers/db_provider.dart';

class PatientSearch extends StatefulWidget {
  const PatientSearch({super.key});

  @override
  State<PatientSearch> createState() => _PatientSearchState();
}

class _PatientSearchState extends State<PatientSearch> {
  int page = 1;
  late Connection connection;
  late TextEditingController pageNumberController;
  late DatabaseQueries databaseQueries;

  Future refresh(int page) async {
    setState(() {
      try {
        FileStorageService().delete('${page - 1}', format: 'json');
      } on Exception catch (e) {
        print(e);
      }
    });
  }

  @override
  void initState() {
    pageNumberController = TextEditingController(text: '$page');
    connection = context.read<DBProvider>().getConnection();
    databaseQueries = DatabaseQueries(connection);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> listOfStudies = [];
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [refreshButton()],
        leading: Builder(builder: (context) {
          return IconButton(
            onPressed: () => Scaffold.of(context).openDrawer(),
            icon: const Icon(Icons.filter_list_outlined),
          );
        }),
      ),
      drawer: drawer(),
      body: FutureBuilder(
          future: databaseQueries.getBriefStudies(page - 1),
          builder: (context, result) {
            if (result.connectionState == ConnectionState.done) {
              if (result.hasData) {
                listOfStudies.addAll(result.data!.map((e) => BriefSummaryCard(
                      briefSummary: e,
                    )));
                listOfStudies.add(pageController());
                return RefreshIndicator(
                    onRefresh: () async {
                      refresh(page);
                    },
                    child: Center(
                      child: SizedBox(
                        width: 1000,
                        child: ListView(
                          key: const PageStorageKey(0),
                          children: listOfStudies,
                        ),
                      ),
                    ));
              } else {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text('An error occurred'), refreshButton()],
                  ),
                );
              }
            } else if (result.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Check your internet connection'),
                    refreshButton()
                  ],
                ),
              );
            }
          }),
    );

    // bottomNavigationBar: bottomNavBar(),
  }

  Widget drawer() {
    return Drawer(
      child: ListView(
        children: const [
          Text('Filters here'),
        ],
      ),
    );
  }

  IconButton refreshButton() => IconButton(
      onPressed: () async {
        refresh(page);
      },
      icon: const Icon(Icons.refresh));

  Widget pageController() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
            onPressed: page != 1
                ? () {
                    setState(() {
                      page--;
                      pageNumberController.text = '$page';
                    });
                  }
                : null,
            child: const Text('Previous')),
        SizedBox(
            width: 100,
            child: CustomTextFormField(
              controller: pageNumberController,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
            )),
        ElevatedButton(
            onPressed: () {
              setState(() {
                page++;
                pageNumberController.text = '$page';
              });
            },
            child: const Text('Next'))
      ],
    );
  }
}

class BriefSummaryCard extends StatelessWidget {
  const BriefSummaryCard({super.key, required this.briefSummary});

  final ClinicalTrial briefSummary;

  @override
  Widget build(BuildContext context) {
    bool isEligible =
        briefSummary.eligibility!.ageEligibility(getIt<Patient>().age) &&
            briefSummary.conditionEligibility(getIt<Patient>().conditions);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 5,
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                if (isEligible) patientQualifies(isEligible, context),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Row(
                          children: [
                            const Icon(
                              Icons.circle,
                              color: Colors.green,
                              size: 10,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              briefSummary.status,
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                      ),
                      SelectableText(briefSummary.nctID),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) =>
                            ViewFullStudy(clinicalTrial: briefSummary)));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                          child: Text(
                        briefSummary.title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )),
                      Text(briefSummary.description),
                      if (briefSummary.interventionType != null &&
                          briefSummary.interventionType!.isNotEmpty)
                        Column(
                          children: [
                            const Divider(),
                            Row(
                              children: [
                                const Text(
                                  'Type of intervention:\t',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Wrap(
                                    direction: Axis.horizontal,
                                    children: briefSummary.interventionType!
                                        .map((intervention) =>
                                            Text(intervention[0]))
                                        .toList()),
                              ],
                            ),
                          ],
                        ),
                      const Divider(),
                      if (briefSummary.conditions != null)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Conditions',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Wrap(
                                direction: Axis.horizontal,
                                children: briefSummary.conditions!
                                    .map((item) => Card(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primaryContainer,
                                        child: Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Text(
                                            item[0],
                                          ),
                                        )))
                                    .toList()),
                          ],
                        ),
                      if (briefSummary.locations != null)
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Divider(),
                              const Text('Location:',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              Wrap(direction: Axis.horizontal, children: [
                                ...briefSummary.locations!.take(5).map(
                                    (location) => Card(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .surfaceVariant,
                                        child: Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Text(
                                              '${location[0]}, ${location[1]}'),
                                        ))),
                                if (briefSummary.locations!.length > 5)
                                  const Padding(
                                    padding: EdgeInsets.all(3.0),
                                    child: Text('...'),
                                  ),
                              ]),
                            ])
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Card patientQualifies(bool isEligible, BuildContext context) {
    return Card(
      elevation: 0,
      color:
          isEligible ? Theme.of(context).colorScheme.tertiaryContainer : null,
      child: const Row(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.keyboard_double_arrow_right_outlined),
          ),
          Text(
            'You may qualify for this clinical trial',
            style: TextStyle(
                fontStyle: FontStyle.italic, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
