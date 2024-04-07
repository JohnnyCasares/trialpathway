import 'package:json_annotation/json_annotation.dart';
import 'package:postgres/postgres.dart';
part 'brief_summary.g.dart';
@JsonSerializable()
class BriefSummary {

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

class BriefSummaryQueries{
  Sql getBriefStudy= Sql.named("""
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
    """
    );


  Sql conditions = Sql.named(
      """
      SELECT DISTINCT C.NAME
      FROM CTGOV.CONDITIONS as C
      WHERE NCT_ID = @nct_id
      """
  );

  Sql locations = Sql.named(
      """
      SELECT DISTINCT F.CITY, F.COUNTRY
      FROM CTGOV.FACILITIES as F
      WHERE NCT_ID = @nct_id
      """
  );

  Sql interventions = Sql.named(
      """
      SELECT DISTINCT I.INTERVENTION_TYPE
      FROM CTGOV.INTERVENTIONS as I
      WHERE NCT_ID = @nct_id
      """
  );
}
