import 'package:flutter/material.dart';
import '../views/open_omnex_pay.dart';

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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter Remitter ID')),
      );
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
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Remit Info retrieved successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      
      // Show error details
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 5),
        ),
      );
      
      // Also show error in response area for debugging
      setState(() {
        _responseData = {'error': e.toString()};
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Remit Info'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _remitterIdController,
              decoration: const InputDecoration(
                labelText: 'Remitter ID',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isLoading ? null : _getRemitInfo,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: _isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                    )
                  : const Text('Get Remit Info'),
            ),
            if (_responseData != null) ...[
              const SizedBox(height: 24),
              const Text(
                'Response:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _responseData!.entries.map((entry) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${entry.key}: ',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                child: Text(entry.value.toString()),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

