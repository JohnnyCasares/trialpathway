import 'package:flutter/material.dart';
import 'package:hti_trialpathway/services/file_storage.dart';
import '../../widgets/multiple_selection.dart';

class GeneralData {
  final path = 'lib/class_models/database_models/savedData';

  Future<List<String>> getCountries() async {
    final countries = await FileStorageService()
        .readFile(fileName: 'countries', format: 'csv', customPath: path);
    List<String> fileToList = countries.split('\n');
    fileToList.sort();
    return fileToList.sublist(1);
  }

  Future<List<String>> getConditions() async {
    final conditions = await FileStorageService()
        .readFile(fileName: 'conditions', format: 'csv', customPath: path);
    List<String> fileToList = conditions.split('\n');
    fileToList.sort();
    return fileToList.sublist(1);
  }

  Future<String?> countriesDialog(BuildContext context) async {
    List<String> tmp = await GeneralData().getCountries();
    String? selection;
    if (context.mounted) {
      selection = await showDialog(
          context: context,
          builder: (c) {
            return MultipleSelectionDialog(
                title: 'Countries', elements: tmp, isMultipleSelection: false);
          });
    }

    return selection;
  }

  Future<String?> conditionsDialog(BuildContext context,
      {List<String>? initialSelection}) async {
    List<String> tmp = await GeneralData().getConditions();
    String? selection;
    if (context.mounted) {
      selection = await showDialog(
          context: context,
          builder: (c) {
            return MultipleSelectionDialog(title: 'Conditions', elements: tmp, initialSelection: initialSelection,);
          });
    }
    return selection;
  }
}
