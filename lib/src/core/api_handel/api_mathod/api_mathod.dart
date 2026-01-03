import '../../error_handels/api_result.dart';
import '../models/model.dart';

abstract class ApiMathod {
   Future<ApiResult<Map<String, dynamic>>> post(String endpoint, Map<String,dynamic> body, {String? apiKey});
   Future<ApiResult<Map<String, dynamic>>> postWithQuery(String endpoint, Map<String, String> queryParams, {String? apiKey});
}



abstract class RepoMathod {
  Future<Map<String, dynamic>> getRemitInfo(String id, String apiendpoint, String apiKey);
  Future<Map<String, dynamic>> register(OmRegistrationModel requestModel, String apiendpoint, String apiKey);
  Future<Map<String, dynamic>> createTransaction(OmTransactionModel requestModel, String apiendpoint, String apiKey);
}


