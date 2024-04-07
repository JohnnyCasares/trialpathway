import 'package:flutter/material.dart';
import 'package:hti_trialpathway/services/file_storage.dart';
import '../../widgets/multiple_selection.dart';

class GeneralData{

  final path = 'lib/class_models/database_models/savedData';
  Future<List<String>> getCountries()async{
    final countries = await FileStorageService().readFile(fileName: 'countries', format: 'csv', customPath: path);
    List<String> fileToList = countries.split('\n');
    fileToList.sort();
    return fileToList.sublist(1);
  }

  Future<List<String>> getConditions()async{
    final conditions = await FileStorageService().readFile(fileName: 'conditions', format: 'csv',customPath: path);
    List<String> fileToList = conditions.split('\n');
    fileToList.sort();
    return fileToList.sublist(1);
  }

  Future<void> countriesDialog(BuildContext context) async{
    List<String> tmp = await GeneralData().getCountries();
    return showDialog(context: context, builder: (c){
      return MultipleSelectionDialog(title: 'Countries',elements: tmp);

    });
  }

  Future<void> conditionsDialog(BuildContext context) async{
    List<String> tmp = await GeneralData().getConditions();
    return showDialog(context: context, builder: (c){
      return MultipleSelectionDialog(title: 'Conditions',elements: tmp );

    });
  }


}