import 'package:postgres/postgres.dart';

import '../main.dart';

const username = String.fromEnvironment('DB_USERNAME');
const password = String.fromEnvironment('DB_PASSWORD');

class DataBaseService {
  final dbEndPoint = Endpoint(
      host: 'aact-db.ctti-clinicaltrials.org',
      database: 'aact_alt',
      username: username,
      password: password);

  final connectionSetting = const ConnectionSettings(sslMode: SslMode.require);

  Future<Connection> initializeDatabase() async {
    return Connection.open(dbEndPoint, settings: connectionSetting);
  }
}

class DatabaseQueries {
  final List<String> columnsBriefStudy = [
    'nct_id',
    'last_date_update',
    'status',
    'title',
    'start_date',
    'start_date_type',
    'description',
  ];
  Future<List<Map>> getBriefStudies(int offset) async {
    Sql briefStudy = Sql("""
    SELECT DISTINCT S.NCT_ID,
    S.LAST_UPDATE_SUBMITTED_DATE,
    S.OVERALL_STATUS,
    S.BRIEF_TITLE,
    S.START_DATE,
    S.START_DATE_TYPE,
    B.DESCRIPTION
    FROM CTGOV.STUDIES AS S
    INNER JOIN CTGOV.BRIEF_SUMMARIES AS B ON S.NCT_ID = B.NCT_ID
    WHERE S.OVERALL_STATUS IN ('Recruiting', 'Not yet recruiting' )
    ORDER BY S.LAST_UPDATE_SUBMITTED_DATE DESC
    LIMIT 10
    OFFSET $offset;
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
    
    Result briefStudyRows = await getIt<Connection>().execute(briefStudy);

    List<Map<String, dynamic>> result = [];
    for (int i = 0; i < 10; i++) {
      result.add(Map.fromIterables(columnsBriefStudy, briefStudyRows[i]));
      Result studyConditions = await getIt<Connection>().execute(conditions, parameters: {'nct_id' : result[i]['nct_id']}); //get conditions of the study
      Result studyLocations = await getIt<Connection>().execute(locations, parameters: {'nct_id' : result[i]['nct_id']}); //get locations of the study
      Result studyInterventions = await getIt<Connection>().execute(interventions, parameters: {'nct_id' : result[i]['nct_id']}); //get locations of the study
      result[i]['conditions'] = studyConditions;
      result[i]['locations'] = studyLocations;
      result[i]['intervention_type'] = studyInterventions;
    }
    return result;
  }
}
