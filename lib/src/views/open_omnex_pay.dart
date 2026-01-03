// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:omnex_pay_sdk/src/core/api_handel/network/api_client.dart';
import 'package:omnex_pay_sdk/src/core/api_handel/repositories/omnex_payment_repo.dart';
import 'package:omnex_pay_sdk/src/core/api_handel/models/model.dart';

class OpenOmnexPay {
  String baseUrl;
  String? apiKey;
  
  OpenOmnexPay({required this.baseUrl, this.apiKey});

  Future<Map<String, dynamic>> getRemitInfo({
    required String id,
    required String apiendpoint,
    required BuildContext context,
  }) async {
    try {
      if (apiKey == null) {
        throw Exception("API Key is required for remit info");
      }
      final repo = OmnexPaymentRepo(apiClient: ApiClient(baseUrl: baseUrl));
      final response = await repo.getRemitInfo(id, apiendpoint, apiKey!);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> register({
    required OmRegistrationModel requestModel,
    required String apiendpoint,
    required BuildContext context,
  }) async {
    try {
      if (apiKey == null) {
        throw Exception("API Key is required for registration");
      }
      final repo = OmnexPaymentRepo(apiClient: ApiClient(baseUrl: baseUrl));
      final response = await repo.register(requestModel, apiendpoint, apiKey!);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> createTransaction({
    required OmTransactionModel requestModel,
    required String apiendpoint,
    required BuildContext context,
  }) async {
    try {
      if (apiKey == null) {
        throw Exception("API Key is required for transaction");
      }
      final repo = OmnexPaymentRepo(apiClient: ApiClient(baseUrl: baseUrl));
      final response = await repo.createTransaction(requestModel, apiendpoint, apiKey!);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}

