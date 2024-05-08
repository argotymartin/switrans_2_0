import 'package:switrans_2_0/src/util/resources/backend/backend_error_response.dart';

class BackendResponse {
  final bool success;
  final List<dynamic> data;
  final BackendErrorResponse error;

  BackendResponse({
    required this.success,
    required this.data,
    required this.error,
  });

  factory BackendResponse.fromJson(Map<String, dynamic> json) => BackendResponse(
        success: json["success"],
        data: List<dynamic>.from(json["data"].map((dynamic x) => x)),
        error: BackendErrorResponse.fromJson(json["error"]),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        "success": success,
        "data": List<dynamic>.from(data.map((dynamic x) => x)),
        "error": error.toJson(),
      };
}
