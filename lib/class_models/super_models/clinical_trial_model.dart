class ClinicalTrial{
  String nctId;
  //Updates and statuses
  String lastUpdated;
  String status;
  //General information
  String title; //briefTitle
  String startDate;
  String estimatedCompletionDate;
  String description; //brief description
  //Eligibility
  Map<String, dynamic> eligibility; // eligibilityModule

  ClinicalTrial(
      {required this.nctId,
        required this.lastUpdated,
        required this.status,
        required this.title,
        required this.startDate,
        required this.estimatedCompletionDate,
        required this.description,
        required this.eligibility});
}