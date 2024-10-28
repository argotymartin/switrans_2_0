import 'dart:convert';

class BackendErrorResponse {
  final String errorClient;
  final String errorTrace;

  BackendErrorResponse({
    required this.errorClient,
    required this.errorTrace,
  });

  factory BackendErrorResponse.fromJson(Map<String, dynamic> json) => BackendErrorResponse(
        errorClient: json["errorClient"] ?? 'Sin Error Client',
        errorTrace: (json["errorTrace"] is Map) ? jsonEncode(json["errorTrace"]) : json["errorTrace"] ?? 'Sin Error Trace',
      );
}
