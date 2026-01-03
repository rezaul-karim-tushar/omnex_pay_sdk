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
      appBar: AppBar(
        title: const Text('Omnex Pay SDK'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Select an API to test',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 48),
            
            // Remit Info Button
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton.icon(
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
                icon: const Icon(Icons.info_outline, size: 28),
                label: const Text(
                  'Remit Info',
                  style: TextStyle(fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // Registration Button
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton.icon(
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
                icon: const Icon(Icons.person_add, size: 28),
                label: const Text(
                  'Registration',
                  style: TextStyle(fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // Transaction Button
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton.icon(
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
                icon: const Icon(Icons.payment, size: 28),
                label: const Text(
                  'Transaction',
                  style: TextStyle(fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
