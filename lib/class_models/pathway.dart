class Pathway {
  String name;
  List<StepPathway> steps = [];

  Pathway(this.name);

}

class StepPathway {
  String title;
  String description;
  List<String>? sources;
  List<StepPathway> altSteps = [];

  StepPathway({required this.title, required this.description, this.sources});
}
