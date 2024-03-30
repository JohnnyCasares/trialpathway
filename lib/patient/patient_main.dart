import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hti_trialpathway/services/database.dart';
import 'package:hti_trialpathway/widgets/custom_textformfield.dart';
import '../widgets/my_appbar.dart';

class PatientMain extends StatefulWidget {
  const PatientMain({super.key});

  @override
  State<PatientMain> createState() => _PatientMainState();
}

class _PatientMainState extends State<PatientMain> {
  int page = 0;
late TextEditingController pageNumberController;
@override
  void initState() {
    pageNumberController = TextEditingController(text: '$page');
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MyAppBar(),
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                  future: DatabaseQueries().getBriefStudies(page),
                  builder: (context, result) {
                    if(result.connectionState == ConnectionState.done) {
                      if (result.hasData) {
                        return ListView.builder(
                            itemCount: result.data!.length,
                            itemBuilder: (context, index) {
                              return BriefSummary(
                                  nctID: result.data![index]['nct_id'],
                                  lastDateUpdate: result.data![index]['last_date_update'],
                                  status: result.data![index]['status'],
                                  title: result.data![index]['title'],
                                  startDate: result.data![index]['start_date'],
                                  startDateType: result.data![index]['start_date_type'],
                                  description: result.data![index]['description'],
                                  locations: result.data![index]['locations'],
                                  interventionType: result.data![index]['intervention_type'],
                                conditions: result.data![index]['conditions'],
                              );
                            });
                      }
                      else{
                        return const Center(child: Text('An error ocurred'),);
                      }
                    } else if(result.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: Center(child: CircularProgressIndicator(),),
                      );
                    }else{
                      return const Center(child: Text('Check your internet connection'),);}
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(onPressed: page!=0?(){
                    setState(() {
                      page--;
                      pageNumberController.text = '$page';
                    });
                  }:null, child: const Text('Previous')),
                  SizedBox(
                      width: 100,
                      child: CustomTextFormField(controller: pageNumberController, textAlign: TextAlign.center, keyboardType: TextInputType.number,)),
                      ElevatedButton(onPressed: (){
                        setState(() {
                          page++;
                          pageNumberController.text = '$page';
                        });},
                          child: const Text('Next'))
                ],
              ),
            ),
          ],
        ));

    // bottomNavigationBar: bottomNavBar(),
  }
}

class BriefSummary extends StatelessWidget {
  const BriefSummary({
    super.key,
    required this.nctID,
    required this.lastDateUpdate,
    required this.status,
    required this.title,
    required this.startDate,
    required this.startDateType,
    required this.description,
    required this.locations,
    required this.interventionType, this.conditions,
  });
  final String nctID;
  final DateTime? lastDateUpdate;
  final String status;
  final String title;
  final DateTime? startDate;
  final String? startDateType;
  final String description;
  final List locations;
  final List interventionType;
  final List? conditions;

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(status, textAlign: TextAlign.left,),//TODO show color based on teh status
                    Text(nctID),
                  ],
                ),
                Center(child: Text(title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
                Text(description),
                if(interventionType.isNotEmpty)
                  Row(
                    children: [
                      const Text('Type of intervention:\t'),
                      Wrap(
                          direction: Axis.horizontal,
                          children: interventionType.map((intervention)
                          => Text(intervention[0])
                          ).toList()
                      ),
                    ],
                  ),

                const Divider(),
                if(conditions!=null)
                 Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     const Text('Conditions', style: TextStyle(fontWeight: FontWeight.bold),),
                     Wrap(
                         direction: Axis.horizontal,
                         children: conditions!.map((item)
                           => Card(
                               color: Colors.white70,
                               child: Padding(
                                 padding: const EdgeInsets.all(3.0),
                                 child: Text(item[0]),
                               ))

                         ).toList()
                     ),
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
