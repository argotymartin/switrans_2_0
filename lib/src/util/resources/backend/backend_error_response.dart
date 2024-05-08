class BackendErrorResponse {
  final String errorClient;
  final String errorTrace;

  BackendErrorResponse({
    required this.errorClient,
    required this.errorTrace,
  });

  factory BackendErrorResponse.fromJson(Map<String, dynamic> json) => BackendErrorResponse(
        errorClient: json["errorClient"],
        errorTrace: json["errorTrace"],
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        "errorClient": errorClient,
        "errorTrace": errorTrace,
      };
}
