import 'dart:convert';

import 'package:hti_trialpathway/class_models/brief_clinical_trial.dart';

import 'package:postgres/postgres.dart';

import '../class_models/patient.dart';
import '../main.dart';
import 'file_storage.dart';

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

  Future<List<BriefClinicalTrial>> getBriefStudies(int offset) async {
    String file = await FileStorageService().readFile(fileName: '$offset', format: 'json');
    if (file.isNotEmpty) {
      final jsonFile = jsonDecode(file);
      List<BriefClinicalTrial> briefSummaries = [];
      for (var savedStudies in jsonFile) {
        briefSummaries.add(BriefClinicalTrial.fromJson(savedStudies));
      }
      return briefSummaries;
    } else {
      BriefSummaryQueries query = BriefSummaryQueries();
      Sql briefStudy = query.getBriefStudy;
      Sql conditions = query.conditions;
      Sql locations = query.locations;
      Sql interventions = query.interventions;
      Sql eligibility = query.eligibility;

      Result briefStudyRows = await getIt<Connection>().execute(briefStudy, parameters: {'offset':offset, 'country_list':getIt<Patient>().country});

      List<BriefClinicalTrial> result = [];
      for (int i = 0; i < 10; i++) {
        Map<String, dynamic> columns = Map.fromIterables(
            BriefClinicalTrial.columns.getRange(0, 7), briefStudyRows[i]);
        result.add(BriefClinicalTrial(
          nctID: columns['nctID'],
          lastDateUpdate: columns['lastDateUpdate'],
          status: columns['status'],
          title: columns['title'],
          startDate: columns['startDate'],
          startDateType: columns['startDateType'],
          description: columns['description'],
        ));
        result[i].conditions = await getIt<Connection>().execute(conditions,
            parameters: {
              'nct_id': result[i].nctID
            }); //get conditions of the study
        result[i].locations = await getIt<Connection>().execute(locations,
            parameters: {
              'nct_id': result[i].nctID,
            }); //get locations of the study
        result[i].interventionType = await getIt<Connection>()
            .execute(interventions, parameters: {
          'nct_id': result[i].nctID
        }); //get locations of the study
        Result test = await getIt<Connection>()
            .execute(eligibility, parameters: {
          'nct_id': result[i].nctID
        });
        Map<String, dynamic> test1 = Map.fromIterables(Eligibility.columns, test[0]);
        result[i].eligibility = Eligibility.fromJson(test1);
      }


      List briefSummaries = [];
      for (BriefClinicalTrial r in result) {
        briefSummaries.add(r.toJson());
      }
      FileStorageService().writeFile('$offset', json.encode(briefSummaries));
      return result;
    }
  }
}
