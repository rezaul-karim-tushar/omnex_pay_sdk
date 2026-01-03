
class OmRemitInfoRequest {
  final String id;

  OmRemitInfoRequest({required this.id});

  Map<String, dynamic> toJson() => {'id': id};
}

class OmRemitInfoResponse {
  final int remitterId;
  final int clientId;
  final int payoutBankId;
  final String repIds;

  OmRemitInfoResponse({
    required this.remitterId,
    required this.clientId,
    required this.payoutBankId,
    required this.repIds,
  });

  factory OmRemitInfoResponse.fromJson(Map<String, dynamic> json) {
    return OmRemitInfoResponse(
      remitterId: json['remitterId'] ?? 0,
      clientId: json['clientId'] ?? 0,
      payoutBankId: json['payoutBankId'] ?? 0,
      repIds: json['repIds'] ?? '',
    );
  }
}

class PhoneModel {
  final String phone;

  PhoneModel({required this.phone});

  Map<String, dynamic> toJson() => {'phone': phone};

  factory PhoneModel.fromJson(Map<String, dynamic> json) => PhoneModel(phone: json['phone'] ?? '');
}

class BankModel {
  final int id;
  final String countryBankId;
  final String branch;
  final String accountNumber;
  final String typeId;

  BankModel({
    required this.id,
    required this.countryBankId,
    required this.branch,
    required this.accountNumber,
    required this.typeId,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'countryBankId': countryBankId,
    'branch': branch,
    'accountNumber': accountNumber,
    'typeId': typeId,
  };

  factory BankModel.fromJson(Map<String, dynamic> json) => BankModel(
    id: json['id'] ?? 0,
    countryBankId: json['countryBankId'] ?? '',
    branch: json['branch'] ?? '',
    accountNumber: json['accountNumber'] ?? '',
    typeId: json['typeId'] ?? '',
  );
}

class IdModel {
  final int id;
  final String typeId;
  final String number;
  final String issuedBy;
  final String expirationDate;
  final String issueDate;

  IdModel({
    required this.id,
    required this.typeId,
    required this.number,
    required this.issuedBy,
    required this.expirationDate,
    required this.issueDate,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'typeId': typeId,
    'number': number,
    'issuedBy': issuedBy,
    'expirationDate': expirationDate,
    'issueDate': issueDate,
  };

  factory IdModel.fromJson(Map<String, dynamic> json) => IdModel(
    id: json['id'] ?? 0,
    typeId: json['typeId'] ?? '',
    number: json['number'] ?? '',
    issuedBy: json['issuedBy'] ?? '',
    expirationDate: json['expirationDate'] ?? '',
    issueDate: json['issueDate'] ?? '',
  );
}

class OccupationModel {
  final Map<String, dynamic> data;

  OccupationModel({Map<String, dynamic>? data}) : data = data ?? {};

  Map<String, dynamic> toJson() => data;

  factory OccupationModel.fromJson(Map<String, dynamic> json) => OccupationModel(data: json);
}

class OmRegistrationModel {
  final String remitterId;
  final int clientId;
  final String dateOfBirth;
  final List<PhoneModel> phones;
  final List<BankModel> banks;
  final List<IdModel> ids;
  final String repIds;
  final String birthCountryIso3;
  final String countryIso3;
  final String firstName;
  final String middleName;
  final String firstLastName;
  final String secondLastName;
  final String address1;
  final int stateId;
  final String city;
  final String zip;
  final int clientTypeId;
  final String email;
  final String employer;
  final String employerAddress;
  final String employerPhone;
  final OccupationModel occupation;

  OmRegistrationModel({
    required this.remitterId,
    required this.clientId,
    required this.dateOfBirth,
    required this.phones,
    required this.banks,
    required this.ids,
    required this.repIds,
    required this.birthCountryIso3,
    required this.countryIso3,
    required this.firstName,
    required this.middleName,
    required this.firstLastName,
    required this.secondLastName,
    required this.address1,
    required this.stateId,
    required this.city,
    required this.zip,
    required this.clientTypeId,
    required this.email,
    required this.employer,
    required this.employerAddress,
    required this.employerPhone,
    required this.occupation,
  });

  Map<String, dynamic> toJson() {
    return {
      'RemitterId': remitterId,
      'clientId': clientId,
      'dateOfBirth': dateOfBirth,
      'phones': phones.map((p) => p.toJson()).toList(),
      'banks': banks.map((b) => b.toJson()).toList(),
      'ids': ids.map((i) => i.toJson()).toList(),
      'RepIds': repIds,
      'birthCountryIso3': birthCountryIso3,
      'countryIso3': countryIso3,
      'firstName': firstName,
      'middleName': middleName,
      'firstLastName': firstLastName,
      'secondLastName': secondLastName,
      'address1': address1,
      'stateId': stateId,
      'city': city,
      'zip': zip,
      'clientTypeId': clientTypeId,
      'email': email,
      'employer': employer,
      'employerAddress': employerAddress,
      'employerPhone': employerPhone,
      'occupation': occupation.toJson(),
    };
  }

  factory OmRegistrationModel.fromJson(Map<String, dynamic> json) {
    return OmRegistrationModel(
      remitterId: json['remitterId']?.toString() ?? '',
      clientId: json['clientId'] ?? 0,
      dateOfBirth: json['dateOfBirth'] ?? '',
      phones: (json['phones'] as List<dynamic>?)
          ?.map((p) => PhoneModel.fromJson(p as Map<String, dynamic>))
          .toList() ?? [],
      banks: (json['banks'] as List<dynamic>?)
          ?.map((b) => BankModel.fromJson(b as Map<String, dynamic>))
          .toList() ?? [],
      ids: (json['ids'] as List<dynamic>?)
          ?.map((i) => IdModel.fromJson(i as Map<String, dynamic>))
          .toList() ?? [],
      repIds: json['repIds']?.toString() ?? '',
      birthCountryIso3: json['birthCountryIso3'] ?? '',
      countryIso3: json['countryIso3'] ?? '',
      firstName: json['firstName'] ?? '',
      middleName: json['middleName'] ?? '',
      firstLastName: json['firstLastName'] ?? '',
      secondLastName: json['secondLastName'] ?? '',
      address1: json['address1'] ?? '',
      stateId: json['stateId'] ?? 0,
      city: json['city'] ?? '',
      zip: json['zip'] ?? '',
      clientTypeId: json['clientTypeId'] ?? 0,
      email: json['email'] ?? '',
      employer: json['employer'] ?? '',
      employerAddress: json['employerAddress'] ?? '',
      employerPhone: json['employerPhone'] ?? '',
      occupation: OccupationModel.fromJson(json['occupation'] as Map<String, dynamic>? ?? {}),
    );
  }
}

class OmTransactionModel {
  final int payoutRepId;
  final int? payoutLocationId;
  final double amount;
  final String remitNo;
  final int deliveryMethodId;
  final int payoutBankId;
  final int payoutClientId;
  final String payoutCountryIso3;
  final String payoutCurrencyIso3;
  final int payoutPhoneId;
  final int productId;
  final int purposeId;
  final int relationshipId;
  final int scenarioId;
  final int sendingClientId;
  final String sendingCurrencyIso3;
  final String source;
  final int sendingPaymentType;
  final String? folio;
  final String? lang;

  OmTransactionModel({
    required this.payoutRepId,
    this.payoutLocationId,
    required this.amount,
    required this.remitNo,
    required this.deliveryMethodId,
    required this.payoutBankId,
    required this.payoutClientId,
    required this.payoutCountryIso3,
    required this.payoutCurrencyIso3,
    required this.payoutPhoneId,
    required this.productId,
    required this.purposeId,
    required this.relationshipId,
    required this.scenarioId,
    required this.sendingClientId,
    required this.sendingCurrencyIso3,
    required this.source,
    required this.sendingPaymentType,
    this.folio,
    this.lang,
  });

  Map<String, dynamic> toJson() {
    final json = {
      'payoutRepId': payoutRepId,
      'amount': amount,
      'RemitNo': remitNo,
      'deliveryMethodId': deliveryMethodId,
      'payoutBankId': payoutBankId,
      'payoutClientId': payoutClientId,
      'payoutCountryIso3': payoutCountryIso3,
      'payoutCurrencyIso3': payoutCurrencyIso3,
      'payoutPhoneId': payoutPhoneId,
      'productId': productId,
      'purposeId': purposeId,
      'relationshipId': relationshipId,
      'scenarioId': scenarioId,
      'sendingClientId': sendingClientId,
      'sendingCurrencyIso3': sendingCurrencyIso3,
      'source': source,
      'sendingPaymentType': sendingPaymentType,
    };

    if (payoutLocationId != null) {
      json['payoutLocationId'] = payoutLocationId as Object;
    }
    if (folio != null) {
      json['folio'] = folio as Object;
    }
    if (lang != null) {
      json['lang'] = lang as Object;
    }

    return json;
  }

  factory OmTransactionModel.fromJson(Map<String, dynamic> json) {
    return OmTransactionModel(
      payoutRepId: json['payoutRepId'] ?? 0,
      payoutLocationId: json['payoutLocationId'],
      amount: (json['amount'] ?? 0).toDouble(),
      remitNo: json['RemitNo'] ?? '',
      deliveryMethodId: json['deliveryMethodId'] ?? 0,
      payoutBankId: json['payoutBankId'] ?? 0,
      payoutClientId: json['payoutClientId'] ?? 0,
      payoutCountryIso3: json['payoutCountryIso3'] ?? '',
      payoutCurrencyIso3: json['payoutCurrencyIso3'] ?? '',
      payoutPhoneId: json['payoutPhoneId'] ?? 0,
      productId: json['productId'] ?? 0,
      purposeId: json['purposeId'] ?? 0,
      relationshipId: json['relationshipId'] ?? 0,
      scenarioId: json['scenarioId'] ?? 0,
      sendingClientId: json['sendingClientId'] ?? 0,
      sendingCurrencyIso3: json['sendingCurrencyIso3'] ?? '',
      source: json['source'] ?? '',
      sendingPaymentType: json['sendingPaymentType'] ?? 0,
      folio: json['folio'],
      lang: json['lang'],
    );
  }
}

