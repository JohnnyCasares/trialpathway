import 'dart:convert';

import 'package:hti_trialpathway/class_models/clinical_trial.dart';

import 'package:postgres/postgres.dart';

import '../class_models/clinical_trial_objects.dart';
import '../class_models/database_models/clinical_trial_queries.dart';
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

      Result briefStudyRows = await getIt<Connection>().execute(briefStudy,
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
        result[i].conditions = await getIt<Connection>().execute(conditions,
            parameters: {
              'nct_id': result[i].nctID
            }); //get conditions of the study
        result[i].locations =
            await getIt<Connection>().execute(locations, parameters: {
          'nct_id': result[i].nctID,
        }); //get locations of the study
        result[i].interventionType = await getIt<Connection>()
            .execute(interventions, parameters: {
          'nct_id': result[i].nctID
        }); //get locations of the study
        Result eligibilityQuery = await getIt<Connection>()
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
    String file = await FileStorageService()
        .readFile(fileName: clinicalTrial.nctID, format: 'json');
    // if (file.isNotEmpty) {
    //   final jsonFile = jsonDecode(file);
    //   return ClinicalTrial.fromJson(jsonFile);
    // } else {
      FullClinicalTrialQueries query = FullClinicalTrialQueries();
      ClinicalTrial result = clinicalTrial;

      Result queryDetailedDescription = await getIt<Connection>().execute(
          query.getDetailedDescription,
          parameters: {'nct_id': clinicalTrial.nctID});
      result.detailedDescription =
          queryDetailedDescription.first.first.toString();

      Result queryIntervention = await getIt<Connection>().execute(
          query.getIntervention,
          parameters: {'nct_id': clinicalTrial.nctID});

      Result queryDesignOutcomes = await getIt<Connection>().execute(
          query.getDesignOutcomes,
          parameters: {'nct_id': clinicalTrial.nctID});

      Result queryContactInformation = await getIt<Connection>().execute(
          query.getContactInformation,
          parameters: {'nct_id': clinicalTrial.nctID});

      Result queryContactLocations = await getIt<Connection>().execute(
          query.getContactLocations,
          parameters: {'nct_id': clinicalTrial.nctID});

      Result querySponsors = await getIt<Connection>().execute(
          query.getSponsors,
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

      return result;
    // }
  }

  Map<String, dynamic> toJson(List<String> columns, Iterable queryResult) {
    return Map.fromIterables(columns, queryResult);
  }
}
