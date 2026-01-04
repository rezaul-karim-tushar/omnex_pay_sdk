import 'package:flutter/material.dart';
import 'package:omnex_pay_sdk/omnex_pay_sdk.dart';

void main() {
  // Initialize the SDK
  OmnexPaySDK.instance.initialize(
    apiKey: '326972B17658A6558F66688A81FAD',
    environment: 'sandbox',
  );
  
  runApp(const OmnexPayDemoApp());
}

class OmnexPayDemoApp extends StatelessWidget {
  const OmnexPayDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Omnex Pay SDK',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 75, 210, 237), // Indigo color
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
      home: PaymentHomePage(
        baseUrl: 'https://uatomnex.necmoney.com/api',
        apiKey: '326972B17658A6558F66688A81FAD',
        remitInfoEndpoint: '/service/OmRemitInfo',
        registrationEndpoint: '/service/OmRegistration',
        transactionEndpoint: '/service/OmTransaction',
      ),
    );
  }
}
