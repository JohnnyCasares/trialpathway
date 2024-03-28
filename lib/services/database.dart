import 'package:postgres/postgres.dart';
const username = String.fromEnvironment('DB_USERNAME');
const password = String.fromEnvironment('DB_PASSWORD');
class DataBaseService {

  final dbEndPoint = Endpoint(
      host: 'aact-db.ctti-clinicaltrials.org',
      database: 'aact_alt',
      username: username,
      password: password);

  final connectionSetting =
      const ConnectionSettings(sslMode: SslMode.disable);

  Future<Connection> initializeDatabase() async {
    return Connection.open(
        dbEndPoint,
        settings: connectionSetting
    );
  }
}