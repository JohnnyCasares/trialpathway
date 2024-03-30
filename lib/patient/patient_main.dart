import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hti_trialpathway/services/database.dart';
import '../widgets/my_appbar.dart';

class PatientMain extends StatefulWidget {
  const PatientMain({super.key});

  @override
  State<PatientMain> createState() => _PatientMainState();
}

class _PatientMainState extends State<PatientMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MyAppBar(),
        body: FutureBuilder(
            future: DatabaseQueries().getBriefStudies(),
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
                            city: result.data![index]['city'],
                            country: result.data![index]['country'],
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
            }));

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
    required this.city, required this.country,
    required this.interventionType, this.conditions,
  });
  final String nctID;
  final DateTime? lastDateUpdate;
  final String status;
  final String title;
  final DateTime? startDate;
  final String? startDateType;
  final String description;
  final String city;
  final String country;
  final String interventionType;
  final List? conditions;

  @override
  Widget build(BuildContext context) {
    print(conditions);
    return Card(
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

              Text('Type of intervention: $interventionType'),
              const Divider(),
              if(conditions!=null)
               Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   const Text('Conditions', style: TextStyle(fontWeight: FontWeight.bold),),
                   Wrap(
                       direction: Axis.horizontal,
                       children: conditions!.map((item) {
                         return Card(
                             color: Colors.white70,
                             child: Padding(
                               padding: const EdgeInsets.all(3.0),
                               child: Text(item[0]),
                             ));
                       }
                       ).toList()
                   ),
                 ],
               ),
              const Divider(),
              Text('Location: $city, $country'),
            ],
          ),
        ),
      ),
    );
  }
}
