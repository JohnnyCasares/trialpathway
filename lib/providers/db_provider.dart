import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

import '../services/database.dart';

class DBProvider extends ChangeNotifier {
  late Connection dbConnection;
  DBProvider();

  setUpConnection(String username, String password) async {
    dbConnection = await DataBaseService()
        .initializeDatabase(username: username, password: password);
    notifyListeners();
  }

  getConnection() {
    return dbConnection;
  }
}
