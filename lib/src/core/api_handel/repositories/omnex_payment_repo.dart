import 'package:omnex_pay_sdk/src/core/api_handel/network/api_client.dart';
import '../api_mathod/api_mathod.dart';
import '../models/model.dart';

class OmnexPaymentRepo extends RepoMathod {
  final ApiClient apiClient;
  OmnexPaymentRepo({required this.apiClient});

  @override
  Future<Map<String, dynamic>> getRemitInfo(String id, String apiendpoint, String apiKey) async {
    return await apiClient.postWithQuery(apiendpoint, {'id': id}, apiKey: apiKey).then((result){
      if (result.isSuccess && result.data != null) {
        if (result.data!.containsKey("data") && result.data!["data"] != null) {
          final data = result.data!["data"];
          if (data is Map<String, dynamic>) {
            return Map<String, dynamic>.from(data);
          } else {
            return Map<String, dynamic>.from(result.data!);
          }
        } else {
          return Map<String, dynamic>.from(result.data!);
        }
      } else {
        throw Exception("Failed to get remit info: ${result.error}");
      }
    });
  }

  @override
  Future<Map<String, dynamic>> register(OmRegistrationModel requestModel, String apiendpoint, String apiKey) async {
    return await apiClient.post(apiendpoint, requestModel.toJson(), apiKey: apiKey).then((result){
      if (result.isSuccess && result.data != null) {
        return Map<String, dynamic>.from(result.data!);
      } else {
        throw Exception("Failed to register: ${result.error}");
      }
    });
  }

  @override
  Future<Map<String, dynamic>> createTransaction(OmTransactionModel requestModel, String apiendpoint, String apiKey) async {
    return await apiClient.post(apiendpoint, requestModel.toJson(), apiKey: apiKey).then((result){
      if (result.isSuccess && result.data != null) {
        return Map<String, dynamic>.from(result.data!);
      } else {
        throw Exception("Failed to create transaction: ${result.error}");
      }
    });
  }
}

