import 'package:switrans_2_0/src/util/resources/backend/backend_error_response.dart';

class BackendResponse {
  final bool success;
  final dynamic data;
  final BackendErrorResponse error;

  BackendResponse({
    required this.success,
    required this.data,
    required this.error,
  });

  factory BackendResponse.fromJson(Map<String, dynamic> json) => BackendResponse(
        success: json["success"],
        data: json["data"] is List ? List<dynamic>.from(json["data"].map((dynamic x) => x)) : json["data"] ?? 'No Data',
        error: BackendErrorResponse.fromJson(json["error"]),
      );
}
