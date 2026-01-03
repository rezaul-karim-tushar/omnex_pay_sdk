import 'package:flutter/material.dart';
import '../views/open_omnex_pay.dart';
import 'response_display_widget.dart';

class RemitInfoScreen extends StatefulWidget {
  final String baseUrl;
  final String apiKey;
  final String endpoint;

  const RemitInfoScreen({
    super.key,
    required this.baseUrl,
    required this.apiKey,
    required this.endpoint,
  });

  @override
  State<RemitInfoScreen> createState() => _RemitInfoScreenState();
}

class _RemitInfoScreenState extends State<RemitInfoScreen> {
  final _remitterIdController = TextEditingController(text: '1234');
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
    _remitterIdController.dispose();
    super.dispose();
  }

  Future<void> _getRemitInfo() async {
    if (_remitterIdController.text.isEmpty) {
      return;
    }

    setState(() {
      _isLoading = true;
      _responseData = null;
    });

    try {
      final response = await _omnexPay.getRemitInfo(
        id: _remitterIdController.text,
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
      appBar: AppBar(title: const Text('Remit Info')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _remitterIdController,
              decoration: const InputDecoration(
                labelText: 'Remitter ID',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _getRemitInfo,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Get Remit Info'),
              ),
            ),
            if (_responseData != null) ...[
              const SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: ResponseDisplayWidget(data: _responseData!),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

