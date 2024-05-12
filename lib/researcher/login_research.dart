import 'package:flutter/material.dart';
import 'package:hti_trialpathway/researcher/research_main.dart';

import '../widgets/custom_textformfield.dart';

class ResearchLogin extends StatefulWidget {
  const ResearchLogin({super.key});

  @override
  State<ResearchLogin> createState() => _ResearchLoginState();
}

class _ResearchLoginState extends State<ResearchLogin> {
  final _formKey = GlobalKey<FormState>();
  bool valid = false;
  late TextEditingController organizationController;
  late TextEditingController usernameController;
  late TextEditingController passwordController;

  @override
  void initState() {
    organizationController = TextEditingController(text: 'test');
    usernameController = TextEditingController(text: 'test');
    passwordController = TextEditingController(text: 'test');
    valid = true;
    super.initState();
  }

  @override
  void dispose() {
    organizationController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Researcher Login'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              onChanged: () {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    valid = true;
                  });
                } else {
                  setState(() {
                    valid = false;
                  });
                }
              },
              key: _formKey,
              child: SizedBox(
                width: 600,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                        'This login page intents to use the Protocol Registration and Results System'),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                      hintText: 'Organization',
                      controller: organizationController,
                      helperText:
                          'One-word organization name assigned by PRS (sent via email when account was created)',
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
                          onPressed: valid
                              ? () {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              const ResearchMain()));
                                }
                              : null,
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
