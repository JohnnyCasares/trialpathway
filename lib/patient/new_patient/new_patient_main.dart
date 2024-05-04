import 'package:flutter/material.dart';
import 'package:hti_trialpathway/patient/new_patient/profile.dart';
import 'package:hti_trialpathway/patient/new_patient/search.dart';
import 'package:provider/provider.dart';

import '../../providers/patient_profile_provider.dart';
import '../../widgets/my_appbar.dart';

class SearchMain extends StatefulWidget {
  const SearchMain({super.key,});

  @override
  State<SearchMain> createState() => _SearchMainState();
}

class _SearchMainState extends State<SearchMain> {
  int pageIndex = 0;
  List<Widget> views = [PatientSearch(), Profile()];

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider<PatientProfileProvider>(
      create: (_)=>PatientProfileProvider(),
      child: Scaffold(
        appBar:  const MyAppBar(),
        body: views[pageIndex],
        bottomNavigationBar: bottomNavBar(),

      ),
    );
  }

  BottomNavigationBar bottomNavBar() {
    return BottomNavigationBar(
      currentIndex: pageIndex,
      onTap: (int index){
        setState(() {
          pageIndex = index;
        });
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.search_outlined), label: 'Search'),
        BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),

      ],
    );
  }
}
