class ErrorBackendDio {
  final String errorClient;
  final String errorTrace;

  ErrorBackendDio({
    required this.errorClient,
    required this.errorTrace,
  });

  factory ErrorBackendDio.fromJson(Map<String, dynamic> json) => ErrorBackendDio(
        errorClient: json['errorClient'] ?? '-',
        errorTrace: json['errorTrace'].toString(),
      );
}
