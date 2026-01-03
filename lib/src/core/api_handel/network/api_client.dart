
// ignore_for_file: unnecessary_string_interpolations

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:omnex_pay_sdk/src/core/api_handel/api_mathod/api_mathod.dart';
import 'package:omnex_pay_sdk/src/core/error_handels/api_result.dart';
import 'package:omnex_pay_sdk/src/core/error_handels/omnex_errors.dart';
import 'package:omnex_pay_sdk/src/core/error_handels/omnex_network_error.dart';
import 'package:omnex_pay_sdk/src/core/error_handels/omnex_unknown_error.dart';


class ApiClient extends ApiMathod {
  final String baseUrl;
  ApiClient({required this.baseUrl});

  @override
  Future<ApiResult<Map<String, dynamic>>> post(String endpoint, Map<String,dynamic> body, {String? apiKey})async{
      // Construct URL properly - handle all cases
      String fullUrl;
      String cleanBaseUrl = baseUrl.endsWith('/') ? baseUrl.substring(0, baseUrl.length - 1) : baseUrl;
      String cleanEndpoint = endpoint.startsWith('/') ? endpoint : '/$endpoint';
      fullUrl = '$cleanBaseUrl$cleanEndpoint';
      final url = Uri.parse(fullUrl);
      final headers = {'Content-Type': 'application/json'};
      if (apiKey != null) {
        headers['Authorization'] = 'ApiKey $apiKey';
      }
      
      try {
        print("POST Request URL: $url");
        print("POST Request Headers: $headers");
        print("POST Request Body: ${jsonEncode(body)}");
        
        final responce = await http.post(url, headers: headers, body: jsonEncode(body));
        
        print("Response Status Code: ${responce.statusCode}");
        print("Response Body: ${responce.body}");
        
        if (responce.statusCode == 200){
          try {
            final decodedResponse = jsonDecode(responce.body);
            print("Decoded Response: $decodedResponse");
            return ApiResult.success(decodedResponse);
          } catch (e) {
            print("JSON Decode Error: $e");
            return ApiResult.failure(
              OmnexUnknownError('Failed to parse response: ${e.toString()}'),
            );
          }
        }else{
          try {
            final errorBody = jsonDecode(responce.body);
            return ApiResult.failure(
              OmnexApiErrors(
                statusCode: responce.statusCode,
                message: 'API Error',
                body: errorBody,
              )
            );
          } catch (e) {
            return ApiResult.failure(
              OmnexApiErrors(
                statusCode: responce.statusCode,
                message: 'API Error: ${responce.body}',
                body: null,
              )
            );
          }
        }
      } on http.ClientException catch (e) {
        print("Client Exception: $e");
        return ApiResult.failure(
          OmnexNetworkError('Network Error', "${e.message}"),
        );
      }catch(e){
        print("Unknown Exception: $e");
        return ApiResult.failure(
          OmnexUnknownError('Unknown Error: ${e.toString()}'),
        );
      }
    }

  @override
  Future<ApiResult<Map<String, dynamic>>> postWithQuery(String endpoint, Map<String, String> queryParams, {String? apiKey}) async {
    // Construct URL properly - handle all cases
    String fullUrl;
    String cleanBaseUrl = baseUrl.endsWith('/') ? baseUrl.substring(0, baseUrl.length - 1) : baseUrl;
    String cleanEndpoint = endpoint.startsWith('/') ? endpoint : '/$endpoint';
    fullUrl = '$cleanBaseUrl$cleanEndpoint';
    
    var uri = Uri.parse(fullUrl);
    uri = uri.replace(queryParameters: queryParams);
    
    final headers = {'Content-Type': 'application/json'};
    if (apiKey != null) {
      headers['Authorization'] = 'ApiKey $apiKey';
    }
    
    try {
      print("POST With Query Request URL: $uri");
      print("POST With Query Request Headers: $headers");
      
      final responce = await http.post(uri, headers: headers);
      
      print("POST With Query Response Status Code: ${responce.statusCode}");
      print("POST With Query Response Body: ${responce.body}");
      
      if (responce.statusCode == 200){
        try {
          final decodedResponse = jsonDecode(responce.body);
          print("POST With Query Decoded Response: $decodedResponse");
          return ApiResult.success(decodedResponse);
        } catch (e) {
          print("POST With Query JSON Decode Error: $e");
          return ApiResult.failure(
            OmnexUnknownError('Failed to parse response: ${e.toString()}'),
          );
        }
      }else{
        try {
          final errorBody = jsonDecode(responce.body);
          return ApiResult.failure(
            OmnexApiErrors(
              statusCode: responce.statusCode,
              message: 'API Error',
              body: errorBody,
            )
          );
        } catch (e) {
          return ApiResult.failure(
            OmnexApiErrors(
              statusCode: responce.statusCode,
              message: 'API Error: ${responce.body}',
              body: null,
            )
          );
        }
      }
    } on http.ClientException catch (e) {
      print("POST With Query Client Exception: $e");
      return ApiResult.failure(
        OmnexNetworkError('Network Error', "${e.message}"),
      );
    }catch(e){
      print("POST With Query Unknown Exception: $e");
      return ApiResult.failure(
        OmnexUnknownError('Unknown Error: ${e.toString()}'),
      );
    }
  }

  @override
  Future<ApiResult<Map<String, dynamic>>> get(String endpoint, {Map<String, String>? queryParams, String? apiKey}) async {
    // Construct URL properly
    String fullUrl;
    if (baseUrl.endsWith('/') && endpoint.startsWith('/')) {
      fullUrl = baseUrl + endpoint.substring(1);
    } else if (!baseUrl.endsWith('/') && !endpoint.startsWith('/')) {
      fullUrl = '$baseUrl/$endpoint';
    } else {
      fullUrl = baseUrl + endpoint;
    }
    
    var uri = Uri.parse(fullUrl);
    if (queryParams != null && queryParams.isNotEmpty) {
      uri = uri.replace(queryParameters: queryParams);
    }
    
    final headers = <String, String>{};
    if (apiKey != null) {
      headers['Authorization'] = 'ApiKey $apiKey';
    }
    
    try {
      print("GET Request URL: $uri");
      print("GET Request Headers: $headers");
      
      final responce = await http.get(uri, headers: headers.isEmpty ? null : headers);
      
      print("GET Response Status Code: ${responce.statusCode}");
      print("GET Response Body: ${responce.body}");
      
      if (responce.statusCode == 200){
        try {
          final decodedResponse = jsonDecode(responce.body);
          print("GET Decoded Response: $decodedResponse");
          return ApiResult.success(decodedResponse);
        } catch (e) {
          print("GET JSON Decode Error: $e");
          return ApiResult.failure(
            OmnexUnknownError('Failed to parse response: ${e.toString()}'),
          );
        }
      }else{
        try {
          final errorBody = jsonDecode(responce.body);
          return ApiResult.failure(
            OmnexApiErrors(
              statusCode: responce.statusCode,
              message: 'API Error',
              body: errorBody,
            )
          );
        } catch (e) {
          return ApiResult.failure(
            OmnexApiErrors(
              statusCode: responce.statusCode,
              message: 'API Error: ${responce.body}',
              body: null,
            )
          );
        }
      }
    } on http.ClientException catch (e) {
      print("GET Client Exception: $e");
      return ApiResult.failure(
        OmnexNetworkError('Network Error', "${e.message}"),
      );
    }catch(e){
      print("GET Unknown Exception: $e");
      return ApiResult.failure(
        OmnexUnknownError('Unknown Error: ${e.toString()}'),
      );
    }
  }
}

