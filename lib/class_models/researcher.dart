import 'package:hti_trialpathway/class_models/clinical_trial.dart';
import 'package:hti_trialpathway/class_models/patient.dart';
import 'package:hti_trialpathway/researcher/views/pathway.dart';

import '../researcher/views/new_step.dart';

class Researcher {
  ClinicalTrial clinicalTrial;
  List<Patient>? patients = [];
  List<List<StepPathway>> pathWays = [];
  Researcher(this.clinicalTrial, this.patients);

  //todo create method to update a patient's path

  static Researcher mockResearcher() {
    return Researcher(
        ClinicalTrial(
            nctID: 'NCT123456',
            status: 'ACTIVE',
            title: 'Test Clinical Trial',
            officialTitle:
                'Full Clinical Trial Title for the Purpose of debugging',
            description: '',
            detailedDescription:
                '''Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Consectetur adipiscing elit pellentesque habitant. Dolor morbi non arcu risus quis varius quam quisque. Aliquet sagittis id consectetur purus ut faucibus. Vitae semper quis lectus nulla at volutpat diam ut venenatis. At lectus urna duis convallis convallis tellus id interdum velit. Sagittis id consectetur purus ut faucibus pulvinar elementum integer enim. Mi bibendum neque egestas congue quisque egestas diam in arcu. Morbi non arcu risus quis varius quam quisque id. Euismod lacinia at quis risus sed. Donec adipiscing tristique risus nec. Vivamus at augue eget arcu dictum varius duis at. Scelerisque viverra mauris in aliquam sem fringilla ut morbi. Rhoncus aenean vel elit scelerisque mauris pellentesque pulvinar pellentesque. Aliquam purus sit amet luctus venenatis. Sodales ut eu sem integer vitae justo eget magna fermentum. Curabitur vitae nunc sed velit.

Aenean pharetra magna ac placerat vestibulum lectus. Sed viverra tellus in hac habitasse platea dictumst vestibulum. Diam vel quam elementum pulvinar etiam non quam. Arcu dictum varius duis at consectetur lorem donec. Vel elit scelerisque mauris pellentesque. Dui nunc mattis enim ut tellus. Sollicitudin ac orci phasellus egestas tellus rutrum tellus pellentesque. Amet luctus venenatis lectus magna fringilla urna. Aliquam etiam erat velit scelerisque in dictum. Ultricies lacus sed turpis tincidunt id. Praesent semper feugiat nibh sed pulvinar proin gravida hendrerit lectus. Duis tristique sollicitudin nibh sit amet commodo nulla facilisi. Eu turpis egestas pretium aenean pharetra magna ac placerat. Scelerisque purus semper eget duis. Maecenas pharetra convallis posuere morbi leo urna molestie at elementum. Pharetra magna ac placerat vestibulum lectus mauris ultrices. Eu tincidunt tortor aliquam nulla. Orci nulla pellentesque dignissim enim sit amet venenatis. Massa placerat duis ultricies lacus. Bibendum enim facilisis gravida neque convallis a cras semper auctor.

Et ultrices neque ornare aenean euismod elementum. Felis bibendum ut tristique et egestas quis. Sit amet nisl purus in. Mi eget mauris pharetra et ultrices. Aliquet nibh praesent tristique magna sit amet purus gravida quis. Dictum non consectetur a erat nam at lectus urna. In nulla posuere sollicitudin aliquam ultrices sagittis. In nibh mauris cursus mattis molestie a iaculis at. Dictumst vestibulum rhoncus est pellentesque elit ullamcorper dignissim cras tincidunt. Aliquam etiam erat velit scelerisque in. Risus nec feugiat in fermentum posuere urna. Sit amet risus nullam eget felis eget nunc. In arcu cursus euismod quis viverra. Imperdiet massa tincidunt nunc pulvinar sapien. A erat nam at lectus urna duis convallis convallis tellus. Viverra suspendisse potenti nullam ac tortor vitae purus faucibus ornare.

Vitae tempus quam pellentesque nec nam aliquam sem et. Aenean vel elit scelerisque mauris pellentesque pulvinar pellentesque habitant. Gravida rutrum quisque non tellus orci. Sollicitudin ac orci phasellus egestas tellus rutrum tellus. Nisl suscipit adipiscing bibendum est ultricies integer. Orci sagittis eu volutpat odio facilisis mauris sit amet. Feugiat scelerisque varius morbi enim nunc faucibus a pellentesque. Amet facilisis magna etiam tempor orci eu lobortis elementum nibh. Sit amet tellus cras adipiscing enim. Id cursus metus aliquam eleifend mi in. A iaculis at erat pellentesque adipiscing commodo elit at imperdiet. Amet mauris commodo quis imperdiet massa tincidunt. Dolor sit amet consectetur adipiscing. Viverra vitae congue eu consequat ac felis donec et odio. Enim tortor at auctor urna nunc id cursus metus. Pellentesque eu tincidunt tortor aliquam. At elementum eu facilisis sed. Molestie a iaculis at erat pellentesque adipiscing. Vitae et leo duis ut diam quam nulla porttitor massa.

Ultrices eros in cursus turpis. Vivamus at augue eget arcu. Posuere ac ut consequat semper viverra nam libero justo. Eget felis eget nunc lobortis mattis aliquam. Nulla at volutpat diam ut venenatis tellus in. Turpis massa tincidunt dui ut ornare lectus. Ultricies lacus sed turpis tincidunt id. Leo duis ut diam quam nulla porttitor massa id neque. Natoque penatibus et magnis dis parturient montes nascetur ridiculus. Vitae sapien pellentesque habitant morbi tristique senectus et. Eget lorem dolor sed viverra ipsum nunc aliquet bibendum enim.'''),
        [Patient.generateMockPatient(), Patient.generateMockPatient()]);
  }
}
