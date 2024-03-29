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
            future: DatabaseQueries.getBriefStudies(),
            builder: (context, result) {
              print(result.data);
              return BriefSummary();
            }));

    // bottomNavigationBar: bottomNavBar(),
  }
}

class BriefSummary extends StatelessWidget {
  const BriefSummary({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Card(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('STATUS'),
                Text('TITLE PLACEHOLDER LEMAO'),
                Text('NCT ID OF THE STUDY'),
                Text('STUDY TYPE'),
                SizedBox(
                    height: 20,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      children: [
                        Text('leukemia'),
                        Text('another condition'),
                        Text('chamo'),
                        Text('test')
                      ],
                    )),
                Text('city, country'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
