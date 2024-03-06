import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';

class NotificationSlack {
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Basic YW5kcmVzLmNhc3RhbmVkYTpBbmRyZXMyMDI0Ki4=',
  };

  final dio = Dio();

  FutureOr sendMessage(String message) async {
    final data = json.encode({"text": message, "chanel": "notificaciones_system"});
    final response = await dio.request(
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
