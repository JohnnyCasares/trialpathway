import 'package:hti_trialpathway/class_models/brief_clinical_trial.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:postgres/postgres.dart';

part 'full_clinical_trial.g.dart';

@JsonSerializable()
class ClinicalTrialModel extends BriefClinicalTrial {
  static final List<String> columns = [
    'nctID',
    'lastDateUpdate',
    'status',
    'title',
    'startDate',
    'startDateType',
    'description',
    'locations',
    'interventionType',
    'conditions',
    'studyPlans',
    'outcomeMeasures',
    'contactsLocations',
    'contactInformation'
  ];

  //Study plan
  //armsInterventionsModule -> contains: armGroups and interventions 1:1 relationship
  final Map<String, dynamic> studyPlan;

  //outcomesModule-> may contain: primaryOutcomes and secondaryOutcomes
  final Map<String, dynamic> outcomeMeasures;
  final ContactLocation contactsLocations;
  final ContactInformation contactInformation; //pointOfContact

  ClinicalTrialModel(this.studyPlan, this.outcomeMeasures,
      this.contactsLocations, this.contactInformation,
      {required super.nctID,
      required super.lastDateUpdate,
      required super.status,
      required super.title,
      required super.startDate,
      required super.startDateType,
      required super.description});

  factory ClinicalTrialModel.fromJson(Map<String, dynamic> json) =>
      _$ClinicalTrialModelFromJson(json);

  Map<String, dynamic> toJson() => _$ClinicalTrialModelToJson(this);
}

@JsonSerializable()
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

  factory ContactLocation.fromJson(Map<String, dynamic> json) =>
      _$ContactLocationFromJson(json);

  Map<String, dynamic> toJson() => _$ContactLocationToJson(this);
}

@JsonSerializable()
class ContactInformation {
  String title;
  String organization;
  String email;
  String phone;

  ContactInformation(
      {required this.title,
      required this.organization,
      required this.email,
      required this.phone});

  factory ContactInformation.fromJson(Map<String, dynamic> json) =>
      _$ContactInformationFromJson(json);

  Map<String, dynamic> toJson() => _$ContactInformationToJson(this);
}

class FullClinicalTrialQueries {
  Sql getFullDescription = Sql.named("""
    """);
}
