import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hti_trialpathway/class_models/brief_clinical_trial.dart';
import 'package:hti_trialpathway/services/database.dart';
import 'package:hti_trialpathway/services/file_storage.dart';
import 'package:hti_trialpathway/widgets/custom_textformfield.dart';

class PatientSearch extends StatefulWidget {
  const PatientSearch({super.key});

  @override
  State<PatientSearch> createState() => _PatientSearchState();
}

class _PatientSearchState extends State<PatientSearch> {
  int page = 1; //TODO: REMEMBER LAST PAGE VISITED
  late TextEditingController pageNumberController;
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
          future: DatabaseQueries().getBriefStudies(page - 1),
          builder: (context, result) {
            if (result.connectionState == ConnectionState.done) {
              if (result.hasData) {
                listOfStudies.addAll(
                    result.data!.map((e) => BriefSummaryCard(briefSummary: e)));
                listOfStudies.add(pageController());
                return RefreshIndicator(
                    onRefresh: () async {
                      refresh(page);
                    },
                    child: ListView(
                      key: PageStorageKey(0),
                      children: listOfStudies,
                    ));
              } else {
                print(result.error.toString());
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text('An error occurred'), refreshButton()],
                  ),
                );
              }
            } else if (result.connectionState == ConnectionState.waiting) {
              return const Center(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
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
    return  Drawer(

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
  final BriefClinicalTrial briefSummary;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
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
                      Text(briefSummary.nctID),
                    ],
                  ),
                ),
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
                                  .map((intervention) => Text(intervention[0]))
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
                // const Divider(),
                // const Text('Location:',style: TextStyle(fontWeight: FontWeight.bold)),
                // Wrap(
                //   direction: Axis.horizontal,
                //   children: locations.map((location)
                //   => Card(
                //       color: Colors.white70,
                //       child: Padding(
                //     padding: const EdgeInsets.all(3.0),
                //     child: Text('${location[0]}, ${location[1]}'),
                //   ))
                //   ).toList()
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
