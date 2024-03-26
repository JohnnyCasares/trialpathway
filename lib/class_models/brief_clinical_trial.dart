import 'package:hti_trialpathway/class_models/super_models/clinical_trial_model.dart';

class SimpleClinicalTrialModel extends ClinicalTrial {
  SimpleClinicalTrialModel({
    required super.nctId,
    required super.lastUpdated,
    required super.status,
    required super.title,
    required super.startDate,
    required super.estimatedCompletionDate,
    required super.description,
    required super.eligibility,
  });
}
