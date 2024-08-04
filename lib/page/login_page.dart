// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:money_flow/controller/user_controller.dart';
import 'package:money_flow/page/home_page.dart';

import '../widgets/base_widgets/base_components.dart';
import '../widgets/widgets_pages/heading_login.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final apiUser = ApiUser();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 24, 10, 55),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const HeadingLogin(),
                const SizedBox(
                  height: 40,
                ),
                // container--Box
                Container(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 20),
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
                          title: 'Welcome,\nBack',
                          align: TextAlign.start,
                          fontSize: 24,
                          weight: FontWeight.bold,
                          color: Colors.white),
                      const SizedBox(
                        height: 40,
                      ),
                      FieldContainer(
                        controllerText: emailController,
                        title: 'Your Email Address',
                        hintText: 'email',
                        obscureText: false,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      FieldContainer(
                        controllerText: passwordController,
                        title: 'Your Password',
                        hintText: 'password',
                        obscureText: true,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      GestureDetector(
                        onTap: () async {
                          try {
                            final Map<String, dynamic> response =
                                await apiUser.loginAccount(emailController.text,
                                    passwordController.text);

                            if (response.isNotEmpty) {
                              final dataUser = response['user'];
                              final userId = dataUser['user_id'];
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Success'),
                                    content: const Text('Login Successful'),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.of(context)
                                            .pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      HomePage(usersId: userId),
                                                ),
                                                (route) => false),
                                        child: const Text("OK"),
                                      )
                                    ],
                                  );
                                },
                              );
                            }
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
                              },
                            );
                          }
                        },
                        child: const ButtonContainer(
                            width: 3,
                            height: 20,
                            color: Colors.white,
                            opacity: 0.16,
                            radiusCircular: 10,
                            title: "Login",
                            sizeFont: 16,
                            fontWeight: FontWeight.w500,
                            fontColor: Colors.white),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}






