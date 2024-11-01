

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:postgres/postgres.dart';
import 'package:switrans_2_0/src/util/resources/backend/backend_error_response.dart';

class ErrorResponse {
  int? code;
  String title;
  String content;
  String? details;
  ErrorResponse({
    required this.content,
    required this.title,
    this.code,
    this.details,
  });

  factory ErrorResponse.fromResponse(Response<dynamic> response) {
    final Map<String, dynamic> errorData = _parseErrorData(response);

    if (_isStandardError(errorData)) {
      return _createStandardErrorResponse(errorData);
    } else if (_isPocketbaseError(errorData)) {
      return _createPocketbaseErrorResponse(errorData, response);
    } else if (_isBackendError(errorData)) {
      return _createBackendErrorResponse(errorData);
    } else {
      return ErrorResponse(content: "Error no controlado", title: "Error no controlado", details: "");
    }
  }

  static Map<String, dynamic> _parseErrorData(Response<dynamic> response) {
    if (response.data is String) {
      return jsonDecode(response.data);
    } else if (response.data is ServerException) {
      final ServerException serverException = response.data as ServerException;
      return <String, dynamic>{
        "status": int.parse(serverException.code ?? "500"),
        "error": serverException.message,
        "path": serverException.detail,
      };
    } else if (response.data is Exception) {
      final Exception exception = response.data as Exception;
      return <String, dynamic>{
        "status": 500,
        "error": exception.toString(),
        "path": "",
      };
    } else {
      return response.data ?? <String, dynamic>{};
    }
  }

  static bool _isStandardError(Map<String, dynamic> errorData) {
    return errorData.containsKey('status') && errorData.containsKey('error');
  }

  static bool _isPocketbaseError(Map<String, dynamic> errorData) {
    return errorData.containsKey('code') && errorData.containsKey('message');
  }

  static bool _isBackendError(Map<String, dynamic> errorData) {
    return errorData.containsKey('success') && errorData.containsKey('data') && errorData.containsKey('error');
  }

  // ignore: prefer_constructors_over_static_methods
  static ErrorResponse _createStandardErrorResponse(Map<String, dynamic> errorData) {
    return ErrorResponse(content: errorData["error"], code: errorData["status"], title: "Error ", details: errorData["path"]);
  }

  // ignore: prefer_constructors_over_static_methods
  static ErrorResponse _createPocketbaseErrorResponse(Map<String, dynamic> errorData, Response<dynamic> response) {
    final String details = errorData["data"].isNotEmpty ? errorData["data"].toString() : response.realUri.path;

    return ErrorResponse(content: errorData["message"], code: errorData["code"], title: "Error Servicion Pocketbase", details: details);
  }

  // ignore: prefer_constructors_over_static_methods
  static ErrorResponse _createBackendErrorResponse(Map<String, dynamic> errorData) {
    final BackendErrorResponse errorResponse = BackendErrorResponse.fromJson(errorData["error"]);
    return ErrorResponse(code: 500, title: errorResponse.errorClient, details: errorResponse.errorTrace);
  }
}
