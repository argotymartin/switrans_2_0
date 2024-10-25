
class BackendResponse {
  final bool success;
  final dynamic data;

  BackendResponse({
    required this.success,
    required this.data,
  });

  factory BackendResponse.fromJson(Map<String, dynamic> json) => BackendResponse(
        success: json["success"],
        data: json["data"] is List ? List<dynamic>.from(json["data"].map((dynamic x) => x)) : json["data"] ?? 'No Data',
      );
}
