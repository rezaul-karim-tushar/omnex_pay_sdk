// ignore_for_file: unnecessary_string_interpolations

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:omnex_pay_sdk/src/core/api_handle/api_method/api_method.dart';
import 'package:omnex_pay_sdk/src/core/error_handels/api_result.dart';
import 'package:omnex_pay_sdk/src/core/error_handels/omnex_errors.dart';
import 'package:omnex_pay_sdk/src/core/error_handels/omnex_network_error.dart';
import 'package:omnex_pay_sdk/src/core/error_handels/omnex_unknown_error.dart';


class ApiClient extends ApiMethod {
  final String baseUrl;
  ApiClient({required this.baseUrl});

  @override
  Future<ApiResult<Map<String, dynamic>>> post(String endpoint, Map<String,dynamic> body, {String? apiKey, Map<String, String>? queryParams})async{
      var uri = Uri.parse('$baseUrl$endpoint');
      if (queryParams != null && queryParams.isNotEmpty) {
        uri = uri.replace(queryParameters: queryParams);
      }
      final headers = {'Content-Type': 'application/json'};
      if (apiKey != null) {
        headers['Authorization'] = 'ApiKey $apiKey';
      }
      
      try {
        final responce = await http.post(uri, headers: headers, body: jsonEncode(body));
        if (responce.statusCode == 200){
          return ApiResult.success(jsonDecode(responce.body));
        }else{
          return ApiResult.failure(
            OmnexApiErrors(
              statusCode: responce.statusCode,
              message: 'API Error',
              body: jsonDecode(responce.body),
            )
          );
        }
      } on http.ClientException catch (e) {
        return ApiResult.failure(
          OmnexNetworkError('Network Error', "${e.message}"),
        );
      }catch(e){
        return ApiResult.failure(
          OmnexUnknownError('Unknown Error: ${e.toString()}'),
        );
      }
    }

}

