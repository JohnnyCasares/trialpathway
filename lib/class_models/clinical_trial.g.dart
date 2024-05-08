// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clinical_trial.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClinicalTrial _$ClinicalTrialFromJson(Map<String, dynamic> json) =>
    ClinicalTrial(
      nctID: json['nctID'] as String,
      lastDateUpdate: json['lastDateUpdate'] == null
          ? null
          : DateTime.parse(json['lastDateUpdate'] as String),
      status: json['status'] as String,
      title: json['title'] as String,
      officialTitle: json['officialTitle'] as String,
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      startDateType: json['startDateType'] as String?,
      description: json['description'] as String,
      locations: json['locations'] as List<dynamic>?,
      interventionType: json['interventionType'] as List<dynamic>?,
      conditions: json['conditions'] as List<dynamic>?,
      eligibility: json['eligibility'] == null
          ? null
          : Eligibility.fromJson(json['eligibility'] as Map<String, dynamic>),
      detailedDescription: json['detailedDescription'] as String?,
      interventions: (json['interventions'] as List<dynamic>?)
          ?.map((e) => Intervention.fromJson(e as Map<String, dynamic>))
          .toList(),
      outcomeMeasures: (json['outcomeMeasures'] as List<dynamic>?)
          ?.map((e) => Outcome.fromJson(e as Map<String, dynamic>))
          .toList(),
      contactsLocations: (json['contactsLocations'] as List<dynamic>?)
          ?.map((e) => ContactLocation.fromJson(e as Map<String, dynamic>))
          .toList(),
      contactInformation: (json['contactInformation'] as List<dynamic>?)
          ?.map((e) => ContactInformation.fromJson(e as Map<String, dynamic>))
          .toList(),
      sponsors: (json['sponsors'] as List<dynamic>?)
          ?.map((e) => Sponsors.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ClinicalTrialToJson(ClinicalTrial instance) =>
    <String, dynamic>{
      'nctID': instance.nctID,
      'lastDateUpdate': instance.lastDateUpdate?.toIso8601String(),
      'status': instance.status,
      'title': instance.title,
      'startDate': instance.startDate?.toIso8601String(),
      'startDateType': instance.startDateType,
      'description': instance.description,
      'interventionType': instance.interventionType,
      'conditions': instance.conditions,
      'locations': instance.locations,
      'eligibility': instance.eligibility,
      'officialTitle': instance.officialTitle,
      'detailedDescription': instance.detailedDescription,
      'interventions': instance.interventions,
      'outcomeMeasures': instance.outcomeMeasures,
      'contactsLocations': instance.contactsLocations,
      'contactInformation': instance.contactInformation,
      'sponsors': instance.sponsors,
    };
