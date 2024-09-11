import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:switrans_2_0/src/config/config.dart';
import 'package:switrans_2_0/src/globals/login/domain/entities/request/usuario.request.dart';

class AuthPocketbaseApi {
  final Dio _dio;
  AuthPocketbaseApi(this._dio);

  Future<Response<dynamic>> getinfoUser(UsuarioRequest params) async {
    const String url = '$kISPocketBaseUrl/api/collections/users/auth-with-password';
    final String jsonRequest = jsonEncode(params.toJson());
    final Response<dynamic> response = await _dio.post(url, data: jsonRequest);
    return response;
  }

  Future<Response<dynamic>> refreshToken(UsuarioRequest params) async {
    const String url = '$kISPocketBaseUrl/api/collections/users/auth-refresh';
    final Map<String, String> headers = <String, String>{'Authorization': params.token};
    final Response<dynamic> response = await _dio.post(url, options: Options(headers: headers));
    return response;
  }
}
