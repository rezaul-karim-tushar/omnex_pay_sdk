import 'package:flutter/material.dart';
import '../views/open_omnex_pay.dart';
import '../core/api_handle/models/model.dart';
import 'response_display_widget.dart';

class TransactionScreen extends StatefulWidget {
  final String baseUrl;
  final String apiKey;
  final String endpoint;

  const TransactionScreen({
    super.key,
    required this.baseUrl,
    required this.apiKey,
    required this.endpoint,
  });

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  final _amountController = TextEditingController(text: '83.00');
  final _remitNoController = TextEditingController(text: 'OG0004090/000014');
  final _payoutRepIdController = TextEditingController(text: '187303');
  final _payoutBankIdController = TextEditingController(text: '1615622');
  final _payoutClientIdController = TextEditingController(text: '17331276');
  final _sendingClientIdController = TextEditingController(text: '17331276');
  final _deliveryMethodIdController = TextEditingController(text: '102');
  final _purposeIdController = TextEditingController(text: '6');
  final _relationshipIdController = TextEditingController(text: '8');
  final _scenarioIdController = TextEditingController(text: '3');
  final _sendingPaymentTypeController = TextEditingController(text: '13');
  final _sourceController = TextEditingController(text: 'wage');
  final _langController = TextEditingController(text: 'en');

  bool _isLoading = false;
  Map<String, dynamic>? _responseData;
  final _omnexPay = OpenOmnexPay(baseUrl: '', apiKey: '');

  @override
  void initState() {
    super.initState();
    _omnexPay.baseUrl = widget.baseUrl;
    _omnexPay.apiKey = widget.apiKey;
  }

  @override
  void dispose() {
    _amountController.dispose();
    _remitNoController.dispose();
    _payoutRepIdController.dispose();
    _payoutBankIdController.dispose();
    _payoutClientIdController.dispose();
    _sendingClientIdController.dispose();
    _deliveryMethodIdController.dispose();
    _purposeIdController.dispose();
    _relationshipIdController.dispose();
    _scenarioIdController.dispose();
    _sendingPaymentTypeController.dispose();
    _sourceController.dispose();
    _langController.dispose();
    super.dispose();
  }

  Future<void> _createTransaction() async {
    if (_amountController.text.isEmpty) {
      return;
    }

    setState(() {
      _isLoading = true;
      _responseData = null;
    });

    try {
      final transactionModel = OmTransactionModel(
        payoutRepId: int.tryParse(_payoutRepIdController.text) ?? 0,
        amount: double.tryParse(_amountController.text) ?? 0.0,
        remitNo: _remitNoController.text,
        deliveryMethodId: int.tryParse(_deliveryMethodIdController.text) ?? 102,
        payoutBankId: int.tryParse(_payoutBankIdController.text) ?? 0,
        payoutClientId: int.tryParse(_payoutClientIdController.text) ?? 0,
        payoutCountryIso3: 'USA',
        payoutCurrencyIso3: 'USD',
        payoutPhoneId: 0,
        productId: 2,
        purposeId: int.tryParse(_purposeIdController.text) ?? 6,
        relationshipId: int.tryParse(_relationshipIdController.text) ?? 8,
        scenarioId: int.tryParse(_scenarioIdController.text) ?? 3,
        sendingClientId: int.tryParse(_sendingClientIdController.text) ?? 0,
        sendingCurrencyIso3: 'USD',
        source: _sourceController.text,
        sendingPaymentType: int.tryParse(_sendingPaymentTypeController.text) ?? 13,
        lang: _langController.text.isNotEmpty ? _langController.text : 'en',
      );

      final response = await _omnexPay.createTransaction(
        requestModel: transactionModel,
        apiendpoint: widget.endpoint,
        context: context,
      );

      setState(() {
        _responseData = response;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _responseData = {'error': e.toString()};
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Transaction')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _amountController, decoration: const InputDecoration(labelText: 'Amount', border: OutlineInputBorder()), keyboardType: TextInputType.number),
            const SizedBox(height: 12),
            TextField(controller: _remitNoController, decoration: const InputDecoration(labelText: 'Remit No', border: OutlineInputBorder())),
            const SizedBox(height: 12),
            TextField(controller: _payoutRepIdController, decoration: const InputDecoration(labelText: 'Payout Rep ID', border: OutlineInputBorder()), keyboardType: TextInputType.number),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: TextField(controller: _payoutBankIdController, decoration: const InputDecoration(labelText: 'Payout Bank ID', border: OutlineInputBorder()), keyboardType: TextInputType.number)),
                const SizedBox(width: 12),
                Expanded(child: TextField(controller: _payoutClientIdController, decoration: const InputDecoration(labelText: 'Payout Client ID', border: OutlineInputBorder()), keyboardType: TextInputType.number)),
              ],
            ),
            const SizedBox(height: 12),
            TextField(controller: _sendingClientIdController, decoration: const InputDecoration(labelText: 'Sending Client ID', border: OutlineInputBorder()), keyboardType: TextInputType.number),
            const SizedBox(height: 12),
            TextField(controller: _deliveryMethodIdController, decoration: const InputDecoration(labelText: 'Delivery Method ID', border: OutlineInputBorder()), keyboardType: TextInputType.number),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: TextField(controller: _purposeIdController, decoration: const InputDecoration(labelText: 'Purpose ID', border: OutlineInputBorder()), keyboardType: TextInputType.number)),
                const SizedBox(width: 12),
                Expanded(child: TextField(controller: _relationshipIdController, decoration: const InputDecoration(labelText: 'Relationship ID', border: OutlineInputBorder()), keyboardType: TextInputType.number)),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: TextField(controller: _scenarioIdController, decoration: const InputDecoration(labelText: 'Scenario ID', border: OutlineInputBorder()), keyboardType: TextInputType.number)),
                const SizedBox(width: 12),
                Expanded(child: TextField(controller: _sendingPaymentTypeController, decoration: const InputDecoration(labelText: 'Sending Payment Type', border: OutlineInputBorder()), keyboardType: TextInputType.number)),
              ],
            ),
            const SizedBox(height: 12),
            TextField(controller: _sourceController, decoration: const InputDecoration(labelText: 'Source', border: OutlineInputBorder())),
            const SizedBox(height: 12),
            TextField(controller: _langController, decoration: const InputDecoration(labelText: 'Language', border: OutlineInputBorder())),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _createTransaction,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: _isLoading
                    ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                    : const Text('Create Transaction'),
              ),
            ),
            if (_responseData != null) ...[
              const SizedBox(height: 20),
              ResponseDisplayWidget(data: _responseData!),
            ],
          ],
        ),
      ),
    );
  }
}

