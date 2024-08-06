// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:money_flow/models/user_models.dart';
import 'package:money_flow/page/home_page.dart';

import '../controller/formater.dart';
import '../controller/user_controller.dart';



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
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: amountController,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                ThousandsSeparatorInputFormatter(),
              ],
              decoration: const InputDecoration(
                  hintText: 'amount',
                  hintStyle: TextStyle(
                    fontSize: 10,
                  )),
            ),
            TextFormField(
              controller: descriptionController,
              decoration: const InputDecoration(
                  hintText: 'description',
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
                final expenses = Expenses(
                  userId: widget.userId,
                  amount: int.parse(amountController.text.replaceAll('.', '')),
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
                                      builder: (context) =>
                                          HomePage(usersId: widget.userId),
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
            )
          ],
        ),
      ),
    );
  }
}
