import 'package:flutter/material.dart';
import 'package:hti_trialpathway/researcher/views/info.dart';
import 'package:hti_trialpathway/researcher/views/messaging.dart';
import 'package:hti_trialpathway/researcher/views/pathway.dart';
import 'package:hti_trialpathway/widgets/my_appbar.dart';

class ResearchMain extends StatefulWidget {
  const ResearchMain({super.key});

  @override
  State<ResearchMain> createState() => _ResearchMainState();
}

class _ResearchMainState extends State<ResearchMain> {
  int pageIndex = 0;
  List<Widget> views = [Info(), Pathway(), Messaging() ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: views[pageIndex],
      bottomNavigationBar: bottomNavBar(),
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
        BottomNavigationBarItem(icon: Icon(Icons.info_outline), label: 'Info'),
        BottomNavigationBarItem(icon: Icon(Icons.polyline_outlined), label: 'Pathway'),
        BottomNavigationBarItem(icon: Icon(Icons.mail_outline), label: 'Inbox'),
      ],
    );
  }
}
