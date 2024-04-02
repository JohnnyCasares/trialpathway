enum Sex { male, female }
class Patient {
  String name;
  int age;
  Sex sex;
  bool healthy;
  List<String> conditions;
  bool pregnant;

  Patient({
    required this.name,
    required this.age,
    required this.sex,
    required this.healthy,
    required this.conditions,
    required this.pregnant,
  });
}
