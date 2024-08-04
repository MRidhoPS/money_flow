import 'package:flutter/material.dart';

import '../base_widgets/base_components.dart';

class HeadingHome extends StatelessWidget {
  const HeadingHome({
    super.key,
  });

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
        children: const [
          TextTitle(
            title: "Spent this Month",
            align: TextAlign.center,
            fontSize: 18,
            weight: FontWeight.w500,
            color: Colors.white54,
          ),
          TextTitle(
            title: "Rp. 435000",
            align: TextAlign.center,
            fontSize: 30,
            weight: FontWeight.bold,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
