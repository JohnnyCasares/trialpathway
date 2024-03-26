import 'package:hti_trialpathway/class_models/super_models/clinical_trial_model.dart';

class ClinicalTrialModel extends ClinicalTrial {
  //Study plan
  //armsInterventionsModule -> contains: armGroups and interventions 1:1 relationship
  Map<String, dynamic> studyPlan;
  //outcomesModule-> may contain: primaryOutcomes and secondaryOutcomes
  Map<String, dynamic> outcomeMeasures;
  ContactLocation contactsLocations;

  ClinicalTrialModel({

    required this.studyPlan,
    required this.outcomeMeasures,
    required this.contactsLocations,
    required super.nctId,
    required super.lastUpdated,
    required super.status,
    required super.title,
    required super.startDate,
    required super.estimatedCompletionDate,
    required super.description,
    required super.eligibility,
  });
}

class ContactLocation {
  String facility;
  String city;
  String state;
  String zip;
  String country;
  Map<String, double> geoPoint;

  ContactLocation(
      {required this.facility,
      required this.city,
      required this.state,
      required this.zip,
      required this.country,
      required this.geoPoint});
}
