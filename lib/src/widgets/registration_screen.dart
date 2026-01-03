import 'package:flutter/material.dart';
import '../views/open_omnex_pay.dart';
import '../core/api_handel/models/model.dart';
import 'response_display_widget.dart';

class RegistrationScreen extends StatefulWidget {
  final String baseUrl;
  final String apiKey;
  final String endpoint;

  const RegistrationScreen({
    super.key,
    required this.baseUrl,
    required this.apiKey,
    required this.endpoint,
  });

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _remitterIdController = TextEditingController(text: '1234');
  final _firstNameController = TextEditingController(text: 'Joney');
  final _firstLastNameController = TextEditingController(text: 'Smith');
  final _phoneController = TextEditingController(text: '+18143512510');
  final _countryIso3Controller = TextEditingController(text: 'USA');
  final _address1Controller = TextEditingController(text: '1600 Pennsylvania Avenue');
  final _cityController = TextEditingController(text: 'Miami Beach');
  final _zipController = TextEditingController(text: '33139');
  final _stateIdController = TextEditingController(text: '73');
  final _countryBankIdController = TextEditingController(text: '49388');
  final _accountNumberController = TextEditingController(text: '12654556653');
  final _branchController = TextEditingController(text: 'branc1');
  final _idTypeController = TextEditingController(text: '1');
  final _idNumberController = TextEditingController(text: 'PAS-77788');
  final _idIssuedByController = TextEditingController(text: 'xyzz');
  final _expirationDateController = TextEditingController(text: '2030-12-31');
  final _issueDateController = TextEditingController(text: '2025-12-31');
  final _repIdsController = TextEditingController(text: '187303');

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
    _firstNameController.dispose();
    _firstLastNameController.dispose();
    _phoneController.dispose();
    _countryIso3Controller.dispose();
    _address1Controller.dispose();
    _cityController.dispose();
    _zipController.dispose();
    _stateIdController.dispose();
    _countryBankIdController.dispose();
    _accountNumberController.dispose();
    _branchController.dispose();
    _idTypeController.dispose();
    _idNumberController.dispose();
    _idIssuedByController.dispose();
    _expirationDateController.dispose();
    _issueDateController.dispose();
    _repIdsController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (_firstNameController.text.isEmpty || _firstLastNameController.text.isEmpty) {
      return;
    }

    setState(() {
      _isLoading = true;
      _responseData = null;
    });

    try {
      final registrationModel = OmRegistrationModel(
        remitterId: _remitterIdController.text,
        clientId: 0,
        dateOfBirth: '',
        phones: [PhoneModel(phone: _phoneController.text)],
        banks: [
          BankModel(
            id: 0,
            countryBankId: _countryBankIdController.text,
            branch: _branchController.text,
            accountNumber: _accountNumberController.text,
            typeId: '1',
          ),
        ],
        ids: [
          IdModel(
            id: 0,
            typeId: _idTypeController.text,
            number: _idNumberController.text,
            issuedBy: _idIssuedByController.text,
            expirationDate: _expirationDateController.text,
            issueDate: _issueDateController.text,
          ),
        ],
        repIds: _repIdsController.text,
        birthCountryIso3: '',
        countryIso3: _countryIso3Controller.text,
        firstName: _firstNameController.text.trim(),
        middleName: '',
        firstLastName: _firstLastNameController.text.trim(),
        secondLastName: '',
        address1: _address1Controller.text,
        stateId: int.tryParse(_stateIdController.text) ?? 73,
        city: _cityController.text,
        zip: _zipController.text,
        clientTypeId: 1,
        email: '',
        employer: '',
        employerAddress: '',
        employerPhone: '',
        occupation: OccupationModel(),
      );

      final response = await _omnexPay.register(
        requestModel: registrationModel,
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
      appBar: AppBar(title: const Text('Registration')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _remitterIdController, decoration: const InputDecoration(labelText: 'Remitter ID', border: OutlineInputBorder())),
            const SizedBox(height: 12),
            TextField(controller: _firstNameController, decoration: const InputDecoration(labelText: 'First Name', border: OutlineInputBorder())),
            const SizedBox(height: 12),
            TextField(controller: _firstLastNameController, decoration: const InputDecoration(labelText: 'Last Name', border: OutlineInputBorder())),
            const SizedBox(height: 12),
            TextField(controller: _phoneController, decoration: const InputDecoration(labelText: 'Phone', border: OutlineInputBorder())),
            const SizedBox(height: 12),
            TextField(controller: _countryIso3Controller, decoration: const InputDecoration(labelText: 'Country ISO3', border: OutlineInputBorder())),
            const SizedBox(height: 12),
            TextField(controller: _address1Controller, decoration: const InputDecoration(labelText: 'Address', border: OutlineInputBorder())),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: TextField(controller: _cityController, decoration: const InputDecoration(labelText: 'City', border: OutlineInputBorder()))),
                const SizedBox(width: 12),
                Expanded(child: TextField(controller: _zipController, decoration: const InputDecoration(labelText: 'ZIP', border: OutlineInputBorder()))),
              ],
            ),
            const SizedBox(height: 12),
            TextField(controller: _stateIdController, decoration: const InputDecoration(labelText: 'State ID', border: OutlineInputBorder())),
            const SizedBox(height: 12),
            TextField(controller: _countryBankIdController, decoration: const InputDecoration(labelText: 'Country Bank ID', border: OutlineInputBorder())),
            const SizedBox(height: 12),
            TextField(controller: _accountNumberController, decoration: const InputDecoration(labelText: 'Account Number', border: OutlineInputBorder())),
            const SizedBox(height: 12),
            TextField(controller: _branchController, decoration: const InputDecoration(labelText: 'Branch', border: OutlineInputBorder())),
            const SizedBox(height: 12),
            TextField(controller: _idTypeController, decoration: const InputDecoration(labelText: 'ID Type', border: OutlineInputBorder())),
            const SizedBox(height: 12),
            TextField(controller: _idNumberController, decoration: const InputDecoration(labelText: 'ID Number', border: OutlineInputBorder())),
            const SizedBox(height: 12),
            TextField(controller: _idIssuedByController, decoration: const InputDecoration(labelText: 'Issued By', border: OutlineInputBorder())),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: TextField(controller: _issueDateController, decoration: const InputDecoration(labelText: 'Issue Date', border: OutlineInputBorder()))),
                const SizedBox(width: 12),
                Expanded(child: TextField(controller: _expirationDateController, decoration: const InputDecoration(labelText: 'Expiration Date', border: OutlineInputBorder()))),
              ],
            ),
            const SizedBox(height: 12),
            TextField(controller: _repIdsController, decoration: const InputDecoration(labelText: 'Rep IDs', border: OutlineInputBorder())),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _register,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: _isLoading
                    ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                    : const Text('Register'),
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

