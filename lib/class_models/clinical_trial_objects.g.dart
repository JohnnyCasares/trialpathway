// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clinical_trial_objects.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactLocation _$ContactLocationFromJson(Map<String, dynamic> json) =>
    ContactLocation(
      name: json['name'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      zip: json['zip'] as String?,
      country: json['country'] as String?,
    );

Map<String, dynamic> _$ContactLocationToJson(ContactLocation instance) =>
    <String, dynamic>{
      'name': instance.name,
      'city': instance.city,
      'state': instance.state,
      'zip': instance.zip,
      'country': instance.country,
    };

ContactInformation _$ContactInformationFromJson(Map<String, dynamic> json) =>
    ContactInformation(
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
    );

Map<String, dynamic> _$ContactInformationToJson(ContactInformation instance) =>
    <String, dynamic>{
      'name': instance.name,
      'phone': instance.phone,
      'email': instance.email,
    };

Intervention _$InterventionFromJson(Map<String, dynamic> json) => Intervention(
      name: json['name'] as String?,
      type: json['type'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$InterventionToJson(Intervention instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': instance.type,
      'description': instance.description,
    };

Outcome _$OutcomeFromJson(Map<String, dynamic> json) => Outcome(
      outComeType: json['outComeType'] as String?,
      outComeDescription: json['outComeDescription'] as String?,
    );

Map<String, dynamic> _$OutcomeToJson(Outcome instance) => <String, dynamic>{
      'outComeType': instance.outComeType,
      'outComeDescription': instance.outComeDescription,
    };

Sponsors _$SponsorsFromJson(Map<String, dynamic> json) => Sponsors(
      json['agencyClass'] as String?,
      json['leadOrCollaborator'] as String?,
      json['name'] as String?,
    );

Map<String, dynamic> _$SponsorsToJson(Sponsors instance) => <String, dynamic>{
      'agencyClass': instance.agencyClass,
      'leadOrCollaborator': instance.leadOrCollaborator,
      'name': instance.name,
    };

Eligibility _$EligibilityFromJson(Map<String, dynamic> json) => Eligibility(
      json['samplingMethod'] as String?,
      json['gender'] as String?,
      json['minAge'] as String?,
      json['maxAge'] as String?,
      json['healthyVolunteers'] as String?,
      json['population'] as String?,
      json['criteria'] as String?,
      json['isChild'] as bool?,
      json['isAdult'] as bool?,
      json['isOlderAdult'] as bool?,
    );

Map<String, dynamic> _$EligibilityToJson(Eligibility instance) =>
    <String, dynamic>{
      'samplingMethod': instance.samplingMethod,
      'gender': instance.gender,
      'minAge': instance.minAge,
      'maxAge': instance.maxAge,
      'healthyVolunteers': instance.healthyVolunteers,
      'population': instance.population,
      'criteria': instance.criteria,
      'isChild': instance.isChild,
      'isAdult': instance.isAdult,
      'isOlderAdult': instance.isOlderAdult,
    };
