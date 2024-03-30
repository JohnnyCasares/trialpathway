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
    'city',
    'country',
    'intervention_type'
  ];
  Future<List<Map>> getBriefStudies() async {
    Sql sqlQuery = Sql("""
    SELECT DISTINCT S.NCT_ID,
    S.LAST_UPDATE_SUBMITTED_DATE,
    S.OVERALL_STATUS,
    S.BRIEF_TITLE,
    S.START_DATE,
    S.START_DATE_TYPE,
    B.DESCRIPTION,
    F.CITY, 
    F.COUNTRY,
    I.INTERVENTION_TYPE
    FROM CTGOV.STUDIES AS S
    INNER JOIN CTGOV.BRIEF_SUMMARIES AS B ON S.NCT_ID = B.NCT_ID
    INNER JOIN CTGOV.FACILITIES AS F ON S.NCT_ID = F.NCT_ID
    INNER JOIN CTGOV.INTERVENTIONS AS I ON S.NCT_ID = I.NCT_ID
    WHERE S.OVERALL_STATUS IN ('Recruiting', 'Not yet recruiting' )
    LIMIT 10;
    """
    );
    Result rows = await getIt<Connection>().execute(sqlQuery);
    List<Map> result = [];
    for (int i = 0; i < 10; i++) {
      result.add(Map.fromIterables(columnsBriefStudy, rows[i]));
    }
    return result;
  }
}
