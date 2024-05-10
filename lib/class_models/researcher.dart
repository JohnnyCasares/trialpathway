import 'package:hti_trialpathway/class_models/clinical_trial.dart';
import 'package:hti_trialpathway/class_models/pathway.dart';
import 'package:hti_trialpathway/class_models/patient.dart';

class Researcher {
  ClinicalTrial clinicalTrial;
  List<Patient> patients = [];
  List<Pathway> pathways = [];

  Researcher(this.clinicalTrial, this.patients);

  //todo create method to update a patient's path

  static Researcher mockResearcher() {
    Pathway mockPathway = Pathway('Test pathway');
    mockPathway.steps.addAll([
      StepPathway(
          title: 'Weight yourself',
          description:
              'Step on a scale and measure your weight in kilograms or pounds'),
      StepPathway(
          title: 'Measure food',
          description:
              'Place your food on a scale and measure the weight of your food in grams or ounces'),
      StepPathway(title: 'Drink water', description: 'Access potable water'),
    ]);
    Researcher researcher = Researcher(
      ClinicalTrial(
          nctID: 'NCT123456',
          status: 'ACTIVE',
          title: 'Test Clinical Trial',
          officialTitle:
              'Full Clinical Trial Title for the Purpose of debugging',
          description: '',
          detailedDescription:
              '''The Full Clinical Trial Title for the Purpose of Debugging is a groundbreaking study aimed at evaluating the effectiveness and safety of a novel intervention in a controlled clinical setting. This trial represents a significant step forward in our understanding of debugging methods and their potential impact on various aspects of human health. 

The primary objective of this trial is to assess the efficacy of the debugging intervention in mitigating errors and improving overall system performance. Additionally, the trial aims to evaluate the safety profile of the intervention and explore its potential side effects.

The trial employs a randomized, double-blind, placebo-controlled design to ensure the reliability and validity of the results. Participants are randomly assigned to either the intervention group, where they receive the debugging treatment, or the control group, where they receive a placebo. Both groups undergo regular assessments and follow-up evaluations to monitor their progress throughout the trial.

The trial aims to enroll a diverse group of participants representing various demographics and backgrounds. Eligible participants must meet specific inclusion criteria and have a documented history of encountering errors in their respective systems. Participants are carefully screened to ensure their suitability for the trial and to minimize potential confounding variables.

The debugging intervention consists of a tailored approach designed to identify and rectify errors within the system. It incorporates state-of-the-art debugging techniques and tools to address a wide range of issues effectively. Participants in the intervention group receive personalized debugging sessions administered by trained professionals, whereas those in the control group receive inert placebo treatments.

The trial evaluates multiple outcome measures to assess the impact of the intervention comprehensively. Key endpoints include error rates, system performance metrics, user satisfaction scores, and adverse events. These measures are systematically collected and analyzed throughout the trial to provide robust insights into the effectiveness and safety of the debugging intervention.

Statistical analysis of the trial data is conducted using advanced methodologies to ensure accuracy and reliability. Comparative analyses between the intervention and control groups are performed to determine any significant differences in outcome measures. Additionally, subgroup analyses may be conducted to explore potential associations between participant characteristics and treatment effects.

The trial adheres to the highest ethical standards and is conducted in accordance with relevant regulatory guidelines and principles. Participant confidentiality and privacy are strictly maintained throughout the trial, and informed consent is obtained from all participants before their enrollment. Additionally, independent ethics committees oversee the conduct of the trial to safeguard the rights and well-being of participants.

The Full Clinical Trial Title for the Purpose of Debugging represents a pioneering effort to advance the field of debugging and enhance the reliability and performance of systems. By rigorously evaluating the efficacy and safety of a novel intervention, this trial aims to provide valuable insights that can inform future debugging practices and improve overall system functionality.
                '''),
      [Patient.generateMockPatient(), Patient.generateMockPatient()],
    );
    researcher.pathways.add(mockPathway);
    return researcher;
  }
}
