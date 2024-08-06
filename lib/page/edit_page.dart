// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:money_flow/controller/formater.dart';
import 'package:money_flow/controller/user_controller.dart';
import 'package:money_flow/models/user_models.dart';
import 'home_page.dart';

class EditPage extends StatefulWidget {
  final int expenseId;
  final int userId;
  final String description;
  final String? amount;

  const EditPage({
    super.key,
    required this.userId,
    required this.expenseId,
    required this.description,
    required this.amount,
  });

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  late ApiUser apiUser;

  late TextEditingController amountController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    apiUser = ApiUser();
    // amountController =
    //     TextEditingController(text: widget.amount?.toString() ?? '');
    amountController =
        TextEditingController(text: widget.amount ?? '');
    descriptionController = TextEditingController(text: widget.description);
  }

  @override
  void dispose() {
    amountController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Expense'),
        leading: IconButton(
          onPressed: () async {
            try {
              await apiUser.deleteExpense(widget.userId, widget.expenseId);
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Success"),
                      content: const Text('Berhasil Menghapus data'),
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
          icon: const Icon(
            Icons.delete,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                ThousandsSeparatorInputFormatter(),
              ],
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Amount',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter amount';
                }
                if (int.tryParse(value) == null) {
                  return 'Invalid amount';
                }
                return null;
              },
            ),
            TextFormField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text("Update"),
              onPressed: () async {
                if (amountController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please enter a valid amount'),
                    ),
                  );
                  return;
                }

                final amount = int.tryParse(amountController.text.replaceAll('.', ''));
                if (amount == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Invalid amount format'),
                    ),
                  );
                  return;
                }

                try {
                  final expenses = Expenses(
                    expenseId: widget.expenseId,
                    userId: widget.userId,
                    amount: amount,
                    description: descriptionController.text,
                    date: DateTime.now().toIso8601String(),
                  );
                  await apiUser.editExpense(
                      expenses, widget.userId, widget.expenseId);
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => HomePage(usersId: widget.userId),
                      ),
                      (route) => false);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Failed to update expense: ${e.toString()}',
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
