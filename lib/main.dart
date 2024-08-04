import 'package:flutter/material.dart';
import 'package:money_flow/page/splash_scree.dart';

void main() {
  runApp(const MoneyFlow());
}

class MoneyFlow extends StatelessWidget {
  const MoneyFlow({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen()
    );
  }
}
