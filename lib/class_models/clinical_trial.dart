import 'dart:math';

import 'package:json_annotation/json_annotation.dart';

import 'clinical_trial_objects.dart';

part 'clinical_trial.g.dart';

@JsonSerializable()
class ClinicalTrial {
  static final List<String> columns = [
    'nctID',
    'lastDateUpdate',
    'status',
    'title',
    'startDate',
    'startDateType',
    'description',
    'officialTitle',
    'locations',
    'interventionType',
    'conditions',
    'detailedDescription',
    'studyPlans',
    'outcomeMeasures',
    'contactsLocations',
    'contactInformation'
  ];

  final String nctID;
  final DateTime? lastDateUpdate;
  final String status;
  final String title;
  final DateTime? startDate;
  final String? startDateType;
  final String description;
  List? interventionType;
  List? conditions;
  List? locations;
  Eligibility? eligibility;

  //view full clinical trial
  final String officialTitle;
  String? detailedDescription;

  //Study plan
  //armsInterventionsModule -> contains: armGroups and interventions 1:1 relationship
  List<Intervention>? interventions;

  //outcomesModule-> may contain: primaryOutcomes and secondaryOutcomes
  List<Outcome>? outcomeMeasures;
  List<ContactLocation>? contactsLocations;
  List<ContactInformation>? contactInformation; //pointOfContact
  List<Sponsors>? sponsors;
  ClinicalTrial(
      {required this.nctID,
      this.lastDateUpdate,
      required this.status,
      required this.title,
      required this.officialTitle,
      this.startDate,
      this.startDateType,
      required this.description,
      this.locations,
      this.interventionType,
      this.conditions,
      this.eligibility,
      this.detailedDescription,
      this.interventions,
      this.outcomeMeasures,
      this.contactsLocations,
      this.contactInformation,
      this.sponsors});

  factory ClinicalTrial.fromJson(Map<String, dynamic> json) =>
      _$ClinicalTrialFromJson(json);

  Map<String, dynamic> toJson() => _$ClinicalTrialToJson(this);

  conditionEligibility(List<String> patientConditions) {
    if (conditions == null) {
      return false;
    } else {
      List<String> tmp = conditions!.map((e) => e[0] as String).toList();
      double threshold = 0.3; // You can adjust this threshold as needed
      bool related = _areRelated(tmp, patientConditions, threshold);
      return related;
    }
  }

  int _calculateLevenshteinDistance(String a, String b) {
    int m = a.length, n = b.length;
    List<List<int>> dp =
        List.generate(m + 1, (_) => List<int>.filled(n + 1, 0));

    for (int i = 0; i <= m; i++) {
      for (int j = 0; j <= n; j++) {
        if (i == 0) {
          dp[i][j] = j;
        } else if (j == 0) {
          dp[i][j] = i;
        } else if (a[i - 1] == b[j - 1]) {
          dp[i][j] = dp[i - 1][j - 1];
        } else {
          dp[i][j] = 1 + min(min(dp[i][j - 1], dp[i - 1][j]), dp[i - 1][j - 1]);
        }
      }
    }
    return dp[m][n];
  }

  double _calculateSimilarity(String a, String b) {
    int maxLen = max(a.length, b.length);
    int distance = _calculateLevenshteinDistance(a, b);
    return 1 - (distance / maxLen);
  }

  bool _areRelated(List<String> list1, List<String> list2, double threshold) {
    for (String word1 in list1) {
      for (String word2 in list2) {
        double similarity = _calculateSimilarity(word1, word2);
        if (similarity >= threshold) {
          return true;
        }
      }
    }
    return false;
  }
}
