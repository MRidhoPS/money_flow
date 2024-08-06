// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../controller/user_controller.dart';
import '../../models/user_models.dart';
import '../../page/edit_page.dart';
import '../base_widgets/base_components.dart';

class DataContainer extends StatefulWidget {
  const DataContainer({super.key, required this.usersId});

  final dynamic usersId;

  @override
  State<DataContainer> createState() => _DataContainerState();
}

class _DataContainerState extends State<DataContainer> {
  late Future<List<Expenses>> expenses;

  ApiUser apiUser = ApiUser();

  @override
  void initState() {
    super.initState();
    FetchData();
  }

  // ignore: non_constant_identifier_names
  void FetchData() {
    expenses = apiUser.getUserExpenses(widget.usersId);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 2,
      child: FutureBuilder<List<Expenses>>(
        future: expenses,
        builder: (context, snapshot) {
          final result = snapshot.data ?? [];
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (result.isNotEmpty) {
              return ListView.builder(
                itemCount: result.length,
                itemBuilder: (context, index) {
                  final data = result[index];
                  final amount = NumberFormat.decimalPattern('id').format(data.amount);
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => EditPage(
                          userId: widget.usersId,
                          expenseId: data.expenseId!,
                          amount: amount,
                          description: data.description,
                        ),
                      ));
                    },
                    child: Container(
                      padding: const EdgeInsets.only(left: 20),
                      margin: const EdgeInsets.only(top: 20),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 15,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        color: Colors.white.withOpacity(0.15),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextTitle(
                                title: data.description,
                                align: TextAlign.left,
                                fontSize: 16,
                                weight: FontWeight.w500,
                                color: Colors.white,
                              ),
                              TextTitle(
                                title:
                                    'Rp. $amount',
                                align: TextAlign.left,
                                fontSize: 12,
                                weight: FontWeight.w400,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(child: Text("No data"));
            }
          } else {
            return const Center(child: Text("Error"));
          }
        },
      ),
    );
  }
}
