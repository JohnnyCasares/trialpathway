import 'dart:convert';

import 'package:hti_trialpathway/class_models/clinical_trial.dart';

import 'package:postgres/postgres.dart';

import '../class_models/clinical_trial_objects.dart';
import '../class_models/database_models/clinical_trial_queries.dart';
import '../class_models/patient.dart';
import '../main.dart';
import 'file_storage.dart';

const _username = String.fromEnvironment('DB_USERNAME');
const _password = String.fromEnvironment('DB_PASSWORD');

class DataBaseService {
  final dbEndPoint = Endpoint(
      host: 'aact-db.ctti-clinicaltrials.org',
      database: 'aact_alt',
      username: _username,
      password: _password);

  final connectionSetting = const ConnectionSettings(sslMode: SslMode.require);

  Future<Connection> initializeDatabase({String? username, String? password}) async {
    return Connection.open(userCredentials(username, password), settings: connectionSetting);
  }

  Endpoint userCredentials(String? username, String? password){
    if(username==null || username.isEmpty){
      username = _username;
    }
    if(password==null || password.isEmpty){
      password = _password;
    }
    return Endpoint(
        host: 'aact-db.ctti-clinicaltrials.org',
        database: 'aact_alt',
        username: username,
        password: password);
  }

}

class DatabaseQueries {
  Connection connection;

  
  DatabaseQueries(this.connection);
  
  Future<List<ClinicalTrial>> getBriefStudies(int offset) async {
    String file = await FileStorageService()
        .readFile(fileName: '$offset', format: 'json');
    if (file.isNotEmpty) {
      final jsonFile = jsonDecode(file);
      List<ClinicalTrial> briefSummaries = [];
      for (var savedStudies in jsonFile) {
        briefSummaries.add(ClinicalTrial.fromJson(savedStudies));
      }
      return briefSummaries;
    } else {
      BriefSummaryQueries query = BriefSummaryQueries();
      Sql briefStudy = query.getBriefStudy;
      Sql conditions = query.conditions;
      Sql locations = query.locations;
      Sql interventions = query.interventions;
      Sql eligibility = query.eligibility;

      Result briefStudyRows = await connection.execute(briefStudy,
          parameters: {
            'offset': offset,
            'country_list': getIt<Patient>().country
          });

      List<ClinicalTrial> result = [];
      for (int i = 0; i < 10; i++) {
        Map<String, dynamic> columns = Map.fromIterables(
            ClinicalTrial.columns.getRange(0, 8), briefStudyRows[i]);
        result.add(ClinicalTrial(
          nctID: columns['nctID'],
          lastDateUpdate: columns['lastDateUpdate'],
          status: columns['status'],
          title: columns['title'],
          startDate: columns['startDate'],
          startDateType: columns['startDateType'],
          description: columns['description'],
          officialTitle: columns['officialTitle'],
        ));
        result[i].conditions = await connection.execute(conditions,
            parameters: {
              'nct_id': result[i].nctID
            }); //get conditions of the study
        result[i].locations =
            await connection.execute(locations, parameters: {
          'nct_id': result[i].nctID,
        }); //get locations of the study
        result[i].interventionType = await connection
            .execute(interventions, parameters: {
          'nct_id': result[i].nctID
        }); //get locations of the study
        Result eligibilityQuery = await connection
            .execute(eligibility, parameters: {'nct_id': result[i].nctID});

        result[i].eligibility = Eligibility.fromJson(
            toJson(Eligibility.columns, eligibilityQuery[0]));
      }

      List briefSummaries = [];
      for (ClinicalTrial r in result) {
        briefSummaries.add(r.toJson());
      }
      FileStorageService().writeFile('$offset', json.encode(briefSummaries));
      return result;
    }
  }

  Future<ClinicalTrial> getFullClinicalTrial(
      ClinicalTrial clinicalTrial) async {
    // String file = await FileStorageService()
    //     .readFile(fileName: clinicalTrial.nctID, format: 'json');
    // if (file.isNotEmpty) {
    //   final jsonFile = jsonDecode(file);
    //   return ClinicalTrial.fromJson(jsonFile);
    // } else {
    FullClinicalTrialQueries query = FullClinicalTrialQueries();
    ClinicalTrial result = clinicalTrial;

    Result queryDetailedDescription = await connection.execute(
        query.getDetailedDescription,
        parameters: {'nct_id': clinicalTrial.nctID});
    if(queryDetailedDescription.isNotEmpty) {
      result.detailedDescription =
          queryDetailedDescription.first.first.toString();
    }

    Result queryIntervention = await connection.execute(
        query.getIntervention,
        parameters: {'nct_id': clinicalTrial.nctID});

    Result queryDesignOutcomes = await connection.execute(
        query.getDesignOutcomes,
        parameters: {'nct_id': clinicalTrial.nctID});

    Result queryContactInformation = await connection.execute(
        query.getContactInformation,
        parameters: {'nct_id': clinicalTrial.nctID});

    Result queryContactLocations = await connection.execute(
        query.getContactLocations,
        parameters: {'nct_id': clinicalTrial.nctID});

    Result querySponsors = await connection.execute(query.getSponsors,
        parameters: {'nct_id': clinicalTrial.nctID});

    result.interventions = List.generate(
        queryIntervention.length,
        (index) => Intervention.fromJson(
            toJson(Intervention.columns, queryIntervention[index])));

    result.outcomeMeasures = List.generate(
        queryDesignOutcomes.length,
        (index) => Outcome.fromJson(
            toJson(Outcome.columns, queryDesignOutcomes[index])));

    result.contactInformation = List.generate(
        queryContactInformation.length,
        (index) => ContactInformation.fromJson(
            toJson(ContactInformation.columns, queryContactInformation[0])));

    result.contactsLocations = List.generate(
        queryContactLocations.length,
        (index) => ContactLocation.fromJson(
            toJson(ContactLocation.columns, queryContactLocations[index])));

    result.sponsors = List.generate(
        querySponsors.length,
        (index) =>
            Sponsors.fromJson(toJson(Sponsors.columns, querySponsors[index])));

    return result;
    // }
  }

  Map<String, dynamic> toJson(List<String> columns, Iterable queryResult) {
    return Map.fromIterables(columns, queryResult);
  }
}
