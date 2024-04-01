import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hti_trialpathway/class_models/database_models/brief_summary.dart';
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
                              return BriefSummaryCard(
                                  briefSummary: result.data![index]
                              );
                            });
                      }
                      else{
                        return const Center(child: Text('An error occurred'),);
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

class BriefSummaryCard extends StatelessWidget {
  const BriefSummaryCard({
    super.key,
   required this.briefSummary
  });
  final BriefSummary briefSummary;

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
                    Text(briefSummary.status, textAlign: TextAlign.left,),//TODO show color based on teh status
                    Text(briefSummary.nctID),
                  ],
                ),
                Center(child: Text(briefSummary.title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
                Text(briefSummary.description),
                if(briefSummary.interventionType!=null && briefSummary.interventionType!.isNotEmpty)
                  Row(
                    children: [
                      const Text('Type of intervention:\t'),
                      Wrap(
                          direction: Axis.horizontal,
                          children: briefSummary.interventionType!.map((intervention)
                          => Text(intervention[0])
                          ).toList()
                      ),
                    ],
                  ),

                const Divider(),
                if(briefSummary.conditions!=null)
                 Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     const Text('Conditions', style: TextStyle(fontWeight: FontWeight.bold),),
                     Wrap(
                         direction: Axis.horizontal,
                         children: briefSummary.conditions!.map((item)
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
