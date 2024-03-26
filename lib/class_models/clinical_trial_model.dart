class ClinicalTrialModel {
  String lastUpdated;
  String status;
  String fullTitle;
  String startDate;
  String estimatedCompletionDate;
  String description;
  String studyPlan;
  List<String> outcomeMeasures;
  List<ContactLocation> contactsLocations;

  ClinicalTrialModel({
    required this.lastUpdated,
    required this.status,
    required this.fullTitle,
    required this.startDate,
    required this.estimatedCompletionDate,
    required this.description,
    required this.studyPlan,
    required this.outcomeMeasures,
    required this.contactsLocations,
  });
}

class ContactLocation {
  String name;
  String affiliation;
  String role;
  String facility;
  String city;
  String state;
  String zip;
  String country;

  ContactLocation({
    required this.name,
    required this.affiliation,
    required this.role,
    required this.facility,
    required this.city,
    required this.state,
    required this.zip,
    required this.country,
  });
}
