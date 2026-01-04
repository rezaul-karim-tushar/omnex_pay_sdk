import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import '../views/open_omnex_pay.dart';
import '../core/api_handle/models/model.dart';
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
  final _middleNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _employerController = TextEditingController();
  final _employerAddressController = TextEditingController();
  final _employerPhoneController = TextEditingController();
  final _dateOfBirthController = TextEditingController();

  DateTime? _selectedDateOfBirth;

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
    _middleNameController.dispose();
    _emailController.dispose();
    _employerController.dispose();
    _employerAddressController.dispose();
    _employerPhoneController.dispose();
    _dateOfBirthController.dispose();
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
        dateOfBirth: _selectedDateOfBirth != null ? DateFormat('yyyy-MM-dd').format(_selectedDateOfBirth!) : '',
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
        middleName: _middleNameController.text.trim(),
        firstLastName: _firstLastNameController.text.trim(),
        secondLastName: '',
        address1: _address1Controller.text,
        stateId: int.tryParse(_stateIdController.text) ?? 73,
        city: _cityController.text,
        zip: _zipController.text,
        clientTypeId: 1,
        email: _emailController.text.trim(),
        employer: _employerController.text.trim(),
        employerAddress: _employerAddressController.text.trim(),
        employerPhone: _employerPhoneController.text.trim(),
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

  Future<void> _selectDateOfBirth(BuildContext context) async {
    DateTime tempDate = _selectedDateOfBirth ?? DateTime.now().subtract(const Duration(days: 365 * 25));
    
    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          height: 300,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _selectedDateOfBirth = tempDate;
                          _dateOfBirthController.text = DateFormat('yyyy-MM-dd').format(tempDate);
                        });
                        Navigator.pop(context);
                      },
                      child: const Text('Done'),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: CupertinoDatePicker(
                  initialDateTime: tempDate,
                  mode: CupertinoDatePickerMode.date,
                  maximumDate: DateTime.now(),
                  minimumDate: DateTime(1900),
                  onDateTimeChanged: (DateTime newDate) {
                    tempDate = newDate;
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
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
            TextField(controller: _middleNameController, decoration: const InputDecoration(labelText: 'Middle Name', border: OutlineInputBorder())),
            const SizedBox(height: 12),
            TextField(controller: _firstLastNameController, decoration: const InputDecoration(labelText: 'Last Name', border: OutlineInputBorder())),
            const SizedBox(height: 12),
            TextField(
              controller: _dateOfBirthController,
              decoration: const InputDecoration(
                labelText: 'Date of Birth',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.calendar_today),
              ),
              readOnly: true,
              onTap: () => _selectDateOfBirth(context),
            ),
            const SizedBox(height: 12),
            TextField(controller: _phoneController, decoration: const InputDecoration(labelText: 'Phone', border: OutlineInputBorder())),
            const SizedBox(height: 12),
            TextField(controller: _emailController, decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder()), keyboardType: TextInputType.emailAddress),
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
            const Divider(),
            const SizedBox(height: 12),
            const Text('Employer Information', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            TextField(controller: _employerController, decoration: const InputDecoration(labelText: 'Employer', border: OutlineInputBorder())),
            const SizedBox(height: 12),
            TextField(controller: _employerAddressController, decoration: const InputDecoration(labelText: 'Employer Address', border: OutlineInputBorder()), maxLines: 2),
            const SizedBox(height: 12),
            TextField(controller: _employerPhoneController, decoration: const InputDecoration(labelText: 'Employer Phone', border: OutlineInputBorder()), keyboardType: TextInputType.phone),
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

