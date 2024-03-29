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
  static Future<List<Map>> getBriefStudies() async {
    final List<String> columns = [
      'nct_id',
      'status',
      'title',
      'last_date_update',
      'start_date',
      'start_date_type',
      'description',
      'location',
      'intervention_type'
    ];
    Result rows = await getIt<Connection>().execute(
        r"SELECT S.NCT_ID, S.LAST_UPDATE_SUBMITTED_DATE, S.OVERALL_STATUS, S.BRIEF_TITLE, S.START_DATE, S.START_DATE_TYPE, B.DESCRIPTION AS DESCRIPTION, (F.CITY,F.COUNTRY) AS STUDY_LOCATION, I.INTERVENTION_TYPE FROM CTGOV.STUDIES AS S INNER JOIN CTGOV.BRIEF_SUMMARIES AS B ON S.NCT_ID = B.NCT_ID INNER JOIN CTGOV.FACILITIES AS F ON S.NCT_ID = F.NCT_ID INNER JOIN CTGOV.INTERVENTIONS AS I ON S.NCT_ID = I.NCT_ID WHERE S.OVERALL_STATUS NOT LIKE 'Terminated' LIMIT 10");
    List<Map> result = [];
    for (int i = 0; i < 10; i++) {
      result.add(Map.fromIterables(columns, rows[i]));
    }
    return result;
  }
}
