import 'package:flutter/material.dart';

class PatientProfileProvider extends ChangeNotifier {
  bool sex;
  bool name;
  bool age;
  bool country;
  bool state;
  bool healthy;
  bool conditions;
  bool pregnant;
  bool profileChange;
  bool visibility;

  PatientProfileProvider(
      {this.sex = false,
      this.name = false,
      this.age = false,
      this.country = false,
      this.state = false,
      this.healthy = false,
      this.conditions = false,
      this.pregnant = false,
      this.profileChange = false,
      this.visibility = false});

  void didSexChange(bool value) {
    sex = value;
    notifyListeners();
  }

  void didNameChange(bool value) {
    name = value;
    notifyListeners();
  }

  void didAgeChange(bool value) {
    age = value;
    notifyListeners();
  }

  void didCountryChange(bool value) {
    country = value;
    notifyListeners();
  }

  void didStateChange(bool value) {
    state = value;
    notifyListeners();
  }

  void didHealthyChange(bool value) {
    healthy = value;
    notifyListeners();
  }

  void didConditionsChange(bool value) {
    conditions = value;
    notifyListeners();
  }

  void didPregnantChange(bool value) {
    pregnant = value;
    notifyListeners();
  }

  void didVisibilityChange(bool value) {
    visibility = value;
    notifyListeners();
  }

  void didProfileChange() {
    profileChange = sex ||
        name ||
        age ||
        country ||
        state ||
        healthy ||
        conditions ||
        pregnant ||
        visibility;

    notifyListeners();
  }

  void resetProfileProvider() {
    sex = false;
    name = false;
    age = false;
    country = false;
    state = false;
    healthy = false;
    conditions = false;
    pregnant = false;
    profileChange = false;
    visibility = false;
    notifyListeners();
  }
}
