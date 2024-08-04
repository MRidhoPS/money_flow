// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:money_flow/controller/user_controller.dart';
import 'package:money_flow/models/user_models.dart';

import 'home_page.dart';

class EditPage extends StatefulWidget {
  final int? expenseId;
  final int? userId;
  final String description;
  final int? amount;

  const EditPage(
      {super.key,
      required this.userId,
      required this.expenseId,
      required this.description,
      required this.amount});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  ApiUser apiUser = ApiUser();

  TextEditingController amountController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    amountController = TextEditingController(text: widget.amount.toString());
    descriptionController = TextEditingController(text: widget.description);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFormField(
            controller: amountController,
          ),
          TextFormField(
            controller: descriptionController,
          ),
          ElevatedButton(
            child: const Text("Update"),
            onPressed: () async {
              setState(() {});
              try {
                final expenses = Expenses(
                  expenseId: widget.expenseId,
                  userId: widget.userId,
                  amount: int.parse(amountController.text),
                  description: descriptionController.text,
                  date: DateTime.now().toIso8601String(),
                );
                await apiUser.editExpense(expenses);
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => HomePage(usersId: widget.userId),
                    ),
                    (route) => false);
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(
                          'Failed to update on ${widget.userId} and ${widget.expenseId}')),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
