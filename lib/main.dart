import 'package:flutter/material.dart';
import 'package:money_flow/page/splash_scree.dart';

void main() {
  runApp(const MoneyFlow());
}

class MoneyFlow extends StatelessWidget {
  const MoneyFlow({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            colorScheme: const ColorScheme(
                brightness: Brightness.light,
                primary: Colors.white,
                onPrimary: Colors.white,
                secondary: Colors.blue,
                onSecondary: Colors.blue,
                error: Colors.red,
                onError: Colors.red,
                background: Color.fromARGB(255, 24, 10, 55),
                onBackground: Colors.blue,
                surface: Colors.blue,
                onSurface: Colors.white)),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen());
  }
}
