class ClinicalTrialModel{
  //Study plan
  //armsInterventionsModule -> contains: armGroups and interventions 1:1 relationship
  final Map<String, dynamic> studyPlan;
  //outcomesModule-> may contain: primaryOutcomes and secondaryOutcomes
  final Map<String, dynamic> outcomeMeasures;
  final ContactLocation contactsLocations;
  final ContactInformation contactInformation; //pointOfContact

  ClinicalTrialModel(
      this.studyPlan, this.outcomeMeasures, this.contactsLocations, this.contactInformation);
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
}
