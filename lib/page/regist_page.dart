// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:money_flow/controller/user_controller.dart';
import 'package:money_flow/models/user_models.dart';
import 'package:money_flow/page/login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController usernameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  ApiUser apiUser = ApiUser();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: usernameController,
              decoration: const InputDecoration(
                  hintText: 'username',
                  hintStyle: TextStyle(
                    fontSize: 10,
                  )),
            ),
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                  hintText: 'email',
                  hintStyle: TextStyle(
                    fontSize: 10,
                  )),
            ),
            TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(
                  hintText: 'password',
                  hintStyle: TextStyle(
                    fontSize: 10,
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              child: const Text("Submit"),
              onPressed: () async {
                final account = Users(
                  username: usernameController.text,
                  email: emailController.text,
                  password: passwordController.text,
                );

                try {
                  await ApiUser().createAccount(account);
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Success'),
                        content: const Text('Registration Successful'),
                        actions: [
                          TextButton(
                            onPressed: () =>
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                      builder: (context) => const LoginPage(),
                                    ),
                                    (route) => false),
                            child: const Text("OK"),
                          )
                        ],
                      );
                    },
                  );
                } catch (e) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Error"),
                          content: Text(e.toString()),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("OK"),
                            ),
                          ],
                        );
                      });
                }
              },
            ),
            const SizedBox(height: 50),
            TextButton(
                onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                    (route) => false),
                child: const Text("Login Account"))
          ],
        ),
      ),
    );
  }
}
