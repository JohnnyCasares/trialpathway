import 'package:json_annotation/json_annotation.dart';

part 'clinical_trial_objects.g.dart';

@JsonSerializable()
class ContactLocation {
  static final List<String> columns = [
    'name',
    'city',
    'state',
    'zip',
    'country',
  ];

  String? name;
  String? city;
  String? state;
  String? zip;
  String? country;

  ContactLocation({
    required this.name,
    required this.city,
    required this.state,
    required this.zip,
    required this.country,
  });

  factory ContactLocation.fromJson(Map<String, dynamic> json) =>
      _$ContactLocationFromJson(json);

  Map<String, dynamic> toJson() => _$ContactLocationToJson(this);
}

@JsonSerializable()
class ContactInformation {
  static final List<String> columns = [
    'name',
    'phone',
    'email',
  ];

  String? name;
  String? phone;
  String? email;

  ContactInformation({
    required this.name,
    required this.phone,
    required this.email,
  });

  factory ContactInformation.fromJson(Map<String, dynamic> json) =>
      _$ContactInformationFromJson(json);

  Map<String, dynamic> toJson() => _$ContactInformationToJson(this);
}

@JsonSerializable()
class Intervention{
  static final List<String> columns = [
    'name',
    'type',
    'description'
  ];
 final String? name;
 final String? type;
 final String? description;

  Intervention({required this.name, required this.type, required this.description});

  factory Intervention.fromJson(Map<String, dynamic> json) =>
      _$InterventionFromJson(json);

  Map<String, dynamic> toJson() => _$InterventionToJson(this);
}
@JsonSerializable()
class Outcome{
  static final List<String> columns = [
    'outComeType',
    'outComeDescription'
  ];
  String? outComeType;
  String? outComeDescription;

  Outcome({required this.outComeType, required this.outComeDescription});


  factory Outcome.fromJson(Map<String, dynamic> json) =>
      _$OutcomeFromJson(json);

  Map<String, dynamic> toJson() => _$OutcomeToJson(this);

}

class Sponsors{
  String? agencyClass;
  String? leadOrCollaborator;
  String? name;

  Sponsors(this.agencyClass, this.leadOrCollaborator, this.name);


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
