import 'package:flutter/material.dart';
import 'remit_info_screen.dart';
import 'registration_screen.dart';
import 'transaction_screen.dart';

/// Main home page with navigation buttons to 3 separate API screens.
class PaymentHomePage extends StatelessWidget {
  final String baseUrl;
  final String apiKey;
  final String remitInfoEndpoint;
  final String registrationEndpoint;
  final String transactionEndpoint;

  const PaymentHomePage({
    super.key,
    required this.baseUrl,
    required this.apiKey,
    required this.remitInfoEndpoint,
    required this.registrationEndpoint,
    required this.transactionEndpoint,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Omnex Pay SDK')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RemitInfoScreen(
                        baseUrl: baseUrl,
                        apiKey: apiKey,
                        endpoint: remitInfoEndpoint,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Remit Info'),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegistrationScreen(
                        baseUrl: baseUrl,
                        apiKey: apiKey,
                        endpoint: registrationEndpoint,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Registration'),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TransactionScreen(
                        baseUrl: baseUrl,
                        apiKey: apiKey,
                        endpoint: transactionEndpoint,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Transaction'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
