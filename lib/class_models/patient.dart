import 'dart:math';

import 'package:hti_trialpathway/class_models/pathway.dart';

enum Sex { male, female }

enum ProfileVisibility { Private, Public }

class Patient {
  String name;
  int age;
  Sex sex;
  bool healthy;
  List<String> conditions;
  bool pregnant;
  String country;
  String state;
  ProfileVisibility visibility;
  List<StepPathway>? pathway = [];
  Patient(
      {required this.name,
      required this.age,
      required this.sex,
      required this.healthy,
      required this.conditions,
      required this.pregnant,
      required this.country,
      required this.state,
      this.visibility = ProfileVisibility.Private,
      this.pathway});

  static Patient generateMockPatient() {
    // Generate random age between 18 and 80
    int age = Random().nextInt(63) + 18;

    // Randomly select sex
    Sex sex = Random().nextBool() ? Sex.male : Sex.female;
    // Set patient name
    String name = sex == Sex.male ? 'John Doe' : 'Sofia Dowi';
    // Randomly set healthy status
    bool healthy = Random().nextBool();

    // Randomly select conditions (if any)
    List<String> conditions = ['GM1 Gangliosidosis'];

    List<String> possibleConditions = [
      'Diabetes',
      'Hypertension',
      'Asthma',
      'Arthritis',
      'Depression',
    ];

    int numConditions = Random().nextInt(possibleConditions.length);
    conditions.addAll(List.generate(numConditions, (index) {
      return possibleConditions[index];
    }));

    conditions.sort();
    // Randomly set pregnancy status
    bool pregnant = sex == Sex.female && Random().nextBool();

    // Mock country and state
    String country = 'United States';
    String state = 'California';

    // Return the mock patient
    return Patient(
        name: name,
        age: age,
        sex: sex,
        healthy: healthy,
        conditions: conditions,
        pregnant: pregnant,
        country: country,
        state: state,
        pathway: []);
  }
}
