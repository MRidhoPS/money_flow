// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:money_flow/models/user_models.dart';
import 'package:money_flow/page/home_page.dart';

import '../controller/user_controller.dart';
import '../widgets/base_widgets/base_components.dart';

class AddPage extends StatefulWidget {
  final dynamic userId;

  const AddPage({super.key, required this.userId});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final amountController = TextEditingController();
  final descriptionController = TextEditingController();

  final apiUser = ApiUser();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
                      title: 'Add Your Expenses',
                      align: TextAlign.start,
                      fontSize: 24,
                      weight: FontWeight.bold,
                      color: Colors.white),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFieldAmount(
                    amountController: amountController,
                    title: 'Amount',
                  ),
                  FieldContainer(
                    controllerText: descriptionController,
                    title: 'Description',
                    hintText: 'decription',
                    obscureText: false,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () async {
                      final expenses = Expenses(
                        userId: widget.userId,
                        amount: int.parse(
                            amountController.text.replaceAll('.', '')),
                        description: descriptionController.text,
                        date: DateTime.now().toIso8601String().split('T')[0],
                      );
                      try {
                        await apiUser.createExpense(expenses);
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Success"),
                                content: const Text('Berhasil Membuat data'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                            builder: (context) => HomePage(
                                                usersId: widget.userId),
                                          ),
                                          (route) => false);
                                    },
                                    child: const Text("OK"),
                                  ),
                                ],
                              );
                            });
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
                        title: "Submit",
                        sizeFont: 16,
                        fontWeight: FontWeight.w500,
                        fontColor: Colors.white),
                  ),
                ],
              ),
            )
            
          ],
        ),
      ),
    );
  }
}