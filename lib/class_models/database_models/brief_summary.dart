import 'package:json_annotation/json_annotation.dart';
part 'brief_summary.g.dart';
@JsonSerializable()
class BriefSummary {
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

  BriefSummary(
      {required this.nctID,
      required this.lastDateUpdate,
      required this.status,
      required this.title,
      required this.startDate,
      required this.startDateType,
      required this.description,
       this.locations,
       this.interventionType,
       this.conditions});

  factory BriefSummary.fromJson(Map<String, dynamic> json) => _$BriefSummaryFromJson(json);

  Map<String, dynamic> toJson() => _$BriefSummaryToJson(this);

}
