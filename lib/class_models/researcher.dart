import 'package:hti_trialpathway/class_models/clinical_trial.dart';
import 'package:hti_trialpathway/class_models/patient.dart';

class Researcher{
  ClinicalTrial clinicalTrial;
  List<Patient>? patients;
  Researcher(this.clinicalTrial, this.patients);

}