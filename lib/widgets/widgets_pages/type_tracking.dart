import 'package:flutter/material.dart';

import '../base_widgets/base_components.dart';

class TypeTracking extends StatelessWidget {
  const TypeTracking({
    super.key,
    required this.textTitle, required this.textColors, required this.buttonColors,
  });

  final String textTitle;
  final Color textColors;
  final Color buttonColors;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2.5,
      height: MediaQuery.of(context).size.height / 20,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: buttonColors,
      ),
      child: Center(
        child: TextTitle(
            title: textTitle,
            align: TextAlign.center,
            fontSize: 15,
            weight: FontWeight.bold,
            color: textColors),
      ),
    );
  }
}
