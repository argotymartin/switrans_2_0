class ErrorGenericDio {
  final String status;
  final String error;
  final String path;

  ErrorGenericDio({
    required this.status,
    required this.error,
    required this.path,
  });

  factory ErrorGenericDio.fromJson(Map<String, dynamic> json) => ErrorGenericDio(
        status: json['status'].toString(),
        error: json['error'] ?? '-',
        path: json['path'] ?? '-',
      );
}
