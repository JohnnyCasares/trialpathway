import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hti_trialpathway/patient/new_patient/new_patient_main.dart';
import 'package:hti_trialpathway/providers/db_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/custom_textformfield.dart';

class AACTLogin extends StatefulWidget {
  const AACTLogin({super.key});

  @override
  State<AACTLogin> createState() => _AACTLoginState();
}

class _AACTLoginState extends State<AACTLogin> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Login'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              child: SizedBox(
                width: 600,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                        'This login requires an account in The Clinical Trials Transformation Initiative (CTTI) enhanced AACT'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account yet?"),
                        SizedBox(width: 15,),
                        TextButton(onPressed: ()async{
                          final Uri url = Uri.parse('https://aact.ctti-clinicaltrials.org');
                          if (!await launchUrl(
                              mode: LaunchMode.inAppBrowserView,
                              url)) {
                          throw Exception('Could not launch $url');
                          }
                        }, child: Text('Sign Up')),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    CustomTextFormField(
                      hintText: 'Username',
                      controller: usernameController,
                    ),
                    CustomTextFormField(
                      hintText: 'Password',
                      controller: passwordController,
                      isPassword: true,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ElevatedButton(
                          onPressed: () async {
                            try {
                              await context
                                  .read<DBProvider>()
                                  .setUpConnection(usernameController.text,
                                      passwordController.text);
                              if (context.mounted) {
                                Navigator.of(context).pushReplacement(MaterialPageRoute(
                                    builder: (_) => SearchMain()));
                              }
                            } catch (e) {
                              print(e);
                              const snackBar = SnackBar(
                                content: Text('Authentication Failed'),
                              );
                              if (context.mounted) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            }
                          },
                          child: const Text('Login')),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
