class ErrorPocketbaseDio {
  final String code;
  final String message;
  final String data;

  ErrorPocketbaseDio({
    required this.code,
    required this.message,
    required this.data,
  });

  factory ErrorPocketbaseDio.fromJson(Map<String, dynamic> json) => ErrorPocketbaseDio(
        code: json['code'].toString(),
        message: json['message'],
        data: json['path'].toString(),
      );
}
