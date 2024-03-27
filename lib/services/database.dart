import 'package:postgres/postgres.dart';

class DataBaseService {

  Future<Connection> initializeDatabase() async {
    final conn = await Connection.open(
      Endpoint(
          host: 'aact-db.ctti-clinicaltrials.org',
          database: 'aact',
          username: 'jonini',
          password: 'Heronation1!'),
      settings: const ConnectionSettings(sslMode: SslMode.verifyFull),
    );
    print('has connection!');
    return conn;
  }

  // closeDatabase(){
  //
  // }
}
