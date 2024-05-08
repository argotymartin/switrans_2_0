import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';

class NotificationSlack {
  final Map<String, String> headers = <String, String>{
    'Content-Type': 'application/json',
    'Authorization': 'Basic YW5kcmVzLmNhc3RhbmVkYTpBbmRyZXMyMDI0Ki4=',
  };

  final Dio dio = Dio();

  FutureOr<void> sendMessage(String message) async {
    final String data = json.encode(<String, String>{"text": message, "chanel": "notificaciones_system"});
    final Response<dynamic> response = await dio.request(
      'https://192.168.24.152:8443/slack/send',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );
    if (response.statusCode == 200) {}
  }
}
