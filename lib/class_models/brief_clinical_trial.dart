import 'dart:math';

import 'package:json_annotation/json_annotation.dart';
import 'package:postgres/postgres.dart';

part 'brief_clinical_trial.g.dart';

@JsonSerializable()
class BriefClinicalTrial {
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
    'conditions'
  ];

  final String nctID;
  final DateTime? lastDateUpdate;
  final String status;
  final String title;
  final DateTime? startDate;
  final String? startDateType;
  final String description;
  List? locations;
  List? interventionType;
  List? conditions;
  Eligibility? eligibility;

  BriefClinicalTrial(
      {required this.nctID,
      required this.lastDateUpdate,
      required this.status,
      required this.title,
      required this.startDate,
      required this.startDateType,
      required this.description,
      this.locations,
      this.interventionType,
      this.conditions,
      this.eligibility});

  factory BriefClinicalTrial.fromJson(Map<String, dynamic> json) =>
      _$BriefClinicalTrialFromJson(json);

  Map<String, dynamic> toJson() => _$BriefClinicalTrialToJson(this);

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

class BriefSummaryQueries {
  Sql getBriefStudy = Sql.named("""
    SELECT DISTINCT S.NCT_ID,
    S.LAST_UPDATE_SUBMITTED_DATE,
    S.OVERALL_STATUS,
    S.BRIEF_TITLE,
    S.START_DATE,
    S.START_DATE_TYPE,
    B.DESCRIPTION
    FROM CTGOV.STUDIES AS S
    INNER JOIN CTGOV.BRIEF_SUMMARIES AS B ON S.NCT_ID = B.NCT_ID
    WHERE S.NCT_ID IN(SELECT DISTINCT F.NCT_ID
    FROM CTGOV.FACILITIES as F
    WHERE F.COUNTRY IN(@country_list))
    AND S.OVERALL_STATUS IN ('Recruiting', 'Not yet recruiting' )
    ORDER BY S.LAST_UPDATE_SUBMITTED_DATE DESC
    LIMIT 10
    OFFSET @offset;
    """);

  Sql conditions = Sql.named("""
      SELECT DISTINCT C.NAME
      FROM CTGOV.CONDITIONS as C
      WHERE NCT_ID = @nct_id
      """);

  Sql locations = Sql.named("""
      SELECT DISTINCT F.CITY, F.COUNTRY
      FROM CTGOV.FACILITIES as F
      WHERE NCT_ID = @nct_id
      """);

  Sql interventions = Sql.named("""
      SELECT DISTINCT I.INTERVENTION_TYPE
      FROM CTGOV.INTERVENTIONS as I
      WHERE NCT_ID = @nct_id
      """);
  Sql eligibility = Sql.named('''
SELECT 
  E.SAMPLING_METHOD,
	E.GENDER,
	E.MINIMUM_AGE,
	E.MAXIMUM_AGE,
	E.HEALTHY_VOLUNTEERS,
	E.POPULATION,
	E.CRITERIA,
	E.ADULT,
	E.CHILD,
	E.OLDER_ADULT
FROM CTGOV.ELIGIBILITIES AS E
WHERE E.NCT_ID = @nct_id;
    ''');
}

@JsonSerializable()
class Eligibility {
  static final List<String> columns = [
    'samplingMethod',
    'gender',
    'minAge',
    'maxAge',
    'healthyVolunteers',
    'population',
    'criteria',
    'isAdult',
    'isChild',
    'isOlderAdult'
  ];

  String? samplingMethod;
  String? gender;
  String? minAge;
  String? maxAge;
  String? healthyVolunteers;
  String? population;
  String? criteria;
  bool? isChild;
  bool? isAdult;
  bool? isOlderAdult;

  Eligibility(
      this.samplingMethod,
      this.gender,
      this.minAge,
      this.maxAge,
      this.healthyVolunteers,
      this.population,
      this.criteria,
      this.isChild,
      this.isAdult,
      this.isOlderAdult);

  factory Eligibility.fromJson(Map<String, dynamic> json) =>
      _$EligibilityFromJson(json);

  Map<String, dynamic> toJson() => _$EligibilityToJson(this);

  bool ageEligibility(int age) {
    //use age to determine age group of patient
    if (isChild != null && age < 18 && isChild!) {
      return isChild! && (0 <= age && age < 18);
    } else if (isAdult != null && age <= 65 && isAdult!) {
      return isAdult! && (18 <= age && age <= 65);
    } else if (isOlderAdult != null) {
      return isOlderAdult! && (age > 65);
    }
    //if these params are null then try using min and max age

    if ((minAge != 'N/A' && minAge != null) ||
        (minAge != 'N/A' && maxAge != null)) {
      List<String> minAgeAndMetric = minAge!.split(' ');
      List<String> maxAgeAndMetric = maxAge!.split(' ');
      int minA = minAge != 'N/A'
          ? int.parse(minAgeAndMetric[0])
          : age + 1; //if N/A, then I provide age+1, making minA>age
      int maxA = maxAge != 'N/A'
          ? int.parse(maxAgeAndMetric[0])
          : age - 1; //if N/A, then I provide age-1, making maxA<age

      print(minA < age && age < maxA);

      if ((minAgeAndMetric.length == 2 && minAgeAndMetric[1] == 'Years') ||
          (maxAgeAndMetric.length == 2 && maxAgeAndMetric[1] == 'Years')) {
        // print(minA <= age && age <= maxA);
        // print('here');
        return minA <= age && age <= maxA;
      }
    }
    return false;
  }
}
