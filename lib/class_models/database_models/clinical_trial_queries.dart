import 'package:postgres/postgres.dart';

class BriefSummaryQueries {
  Sql getBriefStudy = Sql.named("""
    SELECT DISTINCT S.NCT_ID,
    S.LAST_UPDATE_SUBMITTED_DATE,
    S.OVERALL_STATUS,
    S.BRIEF_TITLE,
    S.START_DATE,
    S.START_DATE_TYPE,
    B.DESCRIPTION,
    S.OFFICIAL_TITLE
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

class FullClinicalTrialQueries {
  Sql getDetailedDescription = Sql.named('''
    SELECT D.DESCRIPTION AS DESCRIPTION
    FROM CTGOV.DETAILED_DESCRIPTIONS AS D
    WHERE D.NCT_ID = @nct_id
    ''');

  Sql getIntervention = Sql.named('''
    SELECT I.NAME AS INTERVENTION_NAME,
		I.INTERVENTION_TYPE,
		I.DESCRIPTION AS INTERVENTION_DESCRIPTION
	  FROM CTGOV.INTERVENTIONS AS I WHERE I.NCT_ID = @nct_id;
    ''');

  Sql getDesignOutcomes = Sql.named('''
    SELECT O.OUTCOME_TYPE,
  	O.DESCRIPTION AS OUTCOME_DESCRIPTION
    FROM CTGOV.DESIGN_OUTCOMES AS O
    WHERE O.NCT_ID = @nct_id ;
    
  ''');

  Sql getContactInformation = Sql.named('''
	  SELECT CC.NAME,
	  CC.PHONE,
	  CC.EMAIL
	  FROM CTGOV.CENTRAL_CONTACTS AS CC WHERE CC.NCT_ID = @nct_id;
  ''');

  Sql getContactLocations = Sql.named('''
  SELECT DISTINCT 
  FC.NAME,
  F.CITY,
	F.STATE,
	F.ZIP,
	F.COUNTRY
  FROM CTGOV.FACILITIES AS F
  LEFT JOIN CTGOV.FACILITY_CONTACTS AS FC ON FC.NCT_ID = F.NCT_ID
  WHERE F.NCT_ID = @nct_id
''');
  Sql getSponsors = Sql.named('''
  	SELECT SP.AGENCY_CLASS,
		SP.LEAD_OR_COLLABORATOR,
		SP.NAME
	  FROM CTGOV.SPONSORS AS SP WHERE SP.NCT_ID = @nct_id;
  ''');


}
