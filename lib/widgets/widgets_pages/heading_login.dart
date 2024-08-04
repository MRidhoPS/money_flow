import 'package:flutter/material.dart';

import '../base_widgets/base_components.dart';

class HeadingLogin extends StatelessWidget {
  const HeadingLogin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        TextTitle(
            title: "MONEY\nTRACKERS",
            align: TextAlign.center,
            fontSize: 30,
            weight: FontWeight.bold,
            color: Colors.white),
        SizedBox(
          height: 10,
        ),
        TextSub(
          title: "Track your incomes and expenses",
          align: TextAlign.center,
          fontSize: 12,
          weight: FontWeight.w500,
          color: Colors.white54,
        )
      ],
    );
  }
}
