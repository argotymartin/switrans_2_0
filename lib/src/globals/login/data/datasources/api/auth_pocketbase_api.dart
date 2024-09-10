import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:switrans_2_0/src/config/config.dart';
import 'package:switrans_2_0/src/globals/login/domain/entities/request/usuario.request.dart';

class AuthPocketbaseApi {
  final Dio _dio;
  AuthPocketbaseApi(this._dio);

  Future<Response<dynamic>> getinfoUser(UsuarioRequest params) async {
    final String url = '$kPocketBaseUrl/api/collections/usuario_nedimo/auth-with-password';
    final String jsonRequest = jsonEncode(params.toJson());
    final Response<dynamic> response = await _dio.post(url, data: jsonRequest);
    return response;
  }

  Future<Response<dynamic>> setUser(UsuarioRequest params) async {
    final String url = '$kPocketBaseUrl/api/collections/usuario_nedimo/records';
    final Response<dynamic> response = await _dio.patch(
      '$url/${params.identity}',
      data: <String, String>{"usunedPhoneId": params.token},
      options: Options(
        headers: <String, dynamic>{
          'Authorization': kTokenPocketBase, // Set the content-length.
        },
      ),
    );
    return response;
  }

  Future<Response<dynamic>> getUsuarioByID(UsuarioRequest params) async {
    final String url = '$kPocketBaseUrl/api/collections/usuario_nedimo/auth-with-password';
    final String jsonRequest = jsonEncode(params.toJson());
    final Response<dynamic> response = await _dio.post(url, data: jsonRequest);
    return response;
  }

  Future<Response<dynamic>> refreshToken(UsuarioRequest params) async {
    final String url = '$kPocketBaseUrl/api/collections/usuario_nedimo/auth-refresh';

    final Map<String, String> headers = <String, String>{'Authorization': params.token};
    final Response<dynamic> response = await _dio.post(url, options: Options(headers: headers));
    return response;
  }
}
