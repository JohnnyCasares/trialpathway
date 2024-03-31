
import 'package:hti_trialpathway/class_models/database_models/brief_summary.dart';
import 'package:hti_trialpathway/services/database_queries/queries.dart';

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
    'nctID',
    'lastDateUpdate',
    'status',
    'title',
    'startDate',
    'startDateType',
    'description',
  ];
  Future<List<BriefSummary>> getBriefStudies(int offset) async {
    //if file exists use it
    // FileStorageService().readFile(fileName: '$offset');
    //else run query and write file for next time

    Sql briefStudy = MyQueries().getBriefStudy(offset);
    Sql conditions = MyQueries().conditions;
    Sql locations = MyQueries().locations;
    Sql interventions = MyQueries().interventions;

    Result briefStudyRows = await getIt<Connection>().execute(briefStudy);

    List<BriefSummary> result = [];
    for (int i = 0; i < 10; i++) {
      Map<String, dynamic> columns = Map.fromIterables(columnsBriefStudy, briefStudyRows[i]);
      result.add(BriefSummary(
        nctID: columns['nctID'],
        lastDateUpdate: columns['lastDateUpdate'],
        status: columns['status'],
        title: columns['title'],
        startDate: columns['startDate'],
        startDateType: columns['startDateType'],
        description: columns['description'],
      ));
      result[i].conditions = await getIt<Connection>().execute(conditions, parameters: {'nct_id' : result[i].nctID}); //get conditions of the study
      result[i].locations = await getIt<Connection>().execute(locations, parameters: {'nct_id' : result[i].nctID}); //get locations of the study
      result[i].interventionType = await getIt<Connection>().execute(interventions, parameters: {'nct_id' : result[i].nctID}); //get locations of the study

    }
    List briefSummaries = [];
    for(BriefSummary r in result){
      briefSummaries.add(r.toJson());
    }
    // print(await FileStorageService().readFile(fileName: '$offset', content: briefSummaries.toString()));
    return result;
  }
}
