// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:money_flow/controller/user_controller.dart';
import 'package:money_flow/models/user_models.dart';
import 'package:money_flow/widgets/base_widgets/base_components.dart';
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
    amountController = TextEditingController(text: widget.amount ?? '');
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
                        title: 'Edit Your Expenses',
                        align: TextAlign.start,
                        fontSize: 24,
                        weight: FontWeight.bold,
                        color: Colors.white),
                    TextFieldAmount(
                        amountController: amountController, title: 'Amount'),
                    FieldContainer(
                        controllerText: descriptionController,
                        title: "Description",
                        hintText: 'description',
                        obscureText: false),
                    const SizedBox(height: 30),
                    GestureDetector(
                      onTap: () async {
                        if (amountController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please enter a valid amount'),
                            ),
                          );
                          return;
                        }

                        final amount = int.tryParse(
                            amountController.text.replaceAll('.', ''));
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
                                builder: (context) =>
                                    HomePage(usersId: widget.userId),
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
                        } // button edit
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
                    const SizedBox(height: 30),
                    GestureDetector(
                      onTap: () async {
                        try {
                          await apiUser.deleteExpense(
                              widget.userId, widget.expenseId);
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Success"),
                                  content:
                                      const Text('Berhasil Menghapus data'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      HomePage(
                                                          usersId:
                                                              widget.userId),
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
                        } // button delete
                      },
                      child: const ButtonContainer(
                          width: 3,
                          height: 20,
                          color: Colors.red,
                          opacity: 0.16,
                          radiusCircular: 10,
                          title: "Delete",
                          sizeFont: 16,
                          fontWeight: FontWeight.w500,
                          fontColor: Colors.white),
                    ),
                  ],
                ),
              ),
            ]),
      ),
    );
  }
}
