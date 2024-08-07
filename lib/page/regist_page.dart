// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:money_flow/controller/user_controller.dart';
import 'package:money_flow/models/user_models.dart';
import 'package:money_flow/page/login_page.dart';

import '../widgets/base_widgets/base_components.dart';
import '../widgets/widgets_pages/heading_login.dart';

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
        padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const HeadingLogin(),
            const SizedBox(
              height: 40,
            ),
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.5,
              decoration: BoxDecoration(
                color: Colors.white60.withOpacity(0.16),
                borderRadius: const BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TextTitle(
                      title: 'Welcome, New User',
                      align: TextAlign.start,
                      fontSize: 24,
                      weight: FontWeight.bold,
                      color: Colors.white),
                  const SizedBox(
                    height: 10,
                  ),
                  FieldContainer(
                    controllerText: usernameController,
                    title: 'Your Username',
                    hintText: 'username',
                    obscureText: false,
                  ),
                  FieldContainer(
                    controllerText: emailController,
                    title: 'Your Email',
                    hintText: 'email',
                    obscureText: false,
                  ),
                  FieldContainer(
                    controllerText: passwordController,
                    title: 'Your password',
                    hintText: 'password',
                    obscureText: true,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () async {
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
                                            builder: (context) =>
                                                const LoginPage(),
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
                    child: const ButtonContainer(
                        width: 3,
                        height: 20,
                        color: Colors.white,
                        opacity: 0.16,
                        radiusCircular: 10,
                        title: "Register",
                        sizeFont: 16,
                        fontWeight: FontWeight.w500,
                        fontColor: Colors.white),
                  ),
                  const SizedBox(height: 50),
                  Center(
                    child: TextButton(
                      onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                          (route) => false),
                      child: const TextTitle(title: "Login Account?", align: TextAlign.center, fontSize: 14, weight: FontWeight.w500, color: Colors.white)
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
