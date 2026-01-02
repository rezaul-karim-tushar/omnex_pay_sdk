import 'package:flutter/material.dart';
import 'package:omnex_pay_sdk/omnex_pay_sdk.dart';

void main() {
  runApp(const OmnexPayDemoApp());
}

class OmnexPayDemoApp extends StatelessWidget {
  const OmnexPayDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Omnex Pay SDK Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6366F1), // Indigo color
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      home: const PaymentHomePage(),
    );
  }
}
