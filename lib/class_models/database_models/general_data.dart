import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../../widgets/multiple_selection.dart';

class GeneralData {
  Future<List<String>> getCountries() async {
    final String countries =
        await rootBundle.loadString('assets/savedData/countries.csv');
    List<String> fileToList =
        countries.split('\n').map((e) => e.trim()).toList();
    return fileToList.sublist(1);
  }

  Future<List<String>> getConditions() async {
    final conditions =
        await rootBundle.loadString('assets/savedData/conditions.csv');
    List<String> fileToList =
        conditions.split('\n').map((e) => e.trim()).toList();
    return fileToList.sublist(1);
  }

  Future<String?> countriesSearch(BuildContext context,
      {bool multipleSelection = false}) async {
    List<String> tmp = await GeneralData().getCountries();
    String? selection;
    if (context.mounted) {
      selection = await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => MultipleSelectionDialog(
                  title: 'Countries',
                  elements: tmp,
                  isMultipleSelection: multipleSelection)));
    }

    return selection;
  }

  Future<String?> conditionsSearch(BuildContext context,
      {List<String>? initialSelection}) async {
    List<String> tmp = await GeneralData().getConditions();
    String? selection;
    if (context.mounted) {
      selection = await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => MultipleSelectionDialog(
                    title: 'Conditions',
                    elements: tmp,
                    initialSelection: initialSelection,
                  )));
    }
    return selection;
  }
}
