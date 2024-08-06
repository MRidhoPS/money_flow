import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../controller/user_controller.dart';
import '../base_widgets/base_components.dart';

class HeadingHome extends StatefulWidget {
  final int userId;

  const HeadingHome({
    super.key,
    required this.userId,
  });

  @override
  State<HeadingHome> createState() => _HeadingHomeState();
}

class _HeadingHomeState extends State<HeadingHome> {
  late Future<Map<String, dynamic>> futureTotalExpenses;

  ApiUser apiUser = ApiUser();

  @override
  void initState() {
    super.initState();
    futureTotalExpenses = apiUser.getTotalExpenses(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 5,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.values[2],
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const TextTitle(
            title: "Spent this Month",
            align: TextAlign.center,
            fontSize: 18,
            weight: FontWeight.w500,
            color: Colors.white54,
          ),
          const SizedBox(height: 20,),
          FutureBuilder<Map<String, dynamic>>(
            future: futureTotalExpenses,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const TextTitle(
                    title: '0',
                    align: TextAlign.center,
                    fontSize: 30,
                    weight: FontWeight.bold,
                    color: Colors.white);
              } else if (snapshot.hasData) {
                final totalAmount = snapshot.data?['total_amount'];
                final totalAmountFinal = int.tryParse(totalAmount ?? '0') ?? 0;
                return TextTitle(
                    title: NumberFormat.currency(
                      locale: 'id',
                      symbol: 'Rp. ',
                      decimalDigits: 0,
                    ).format(totalAmountFinal),
                    align: TextAlign.center,
                    fontSize: 30,
                    weight: FontWeight.bold,
                    color: Colors.white);
              } else {
                return const Text('No data found');
              }
            },
          ),
        ],
      ),
    );
  }
}
