import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:switrans_2_0/src/globals/login/domain/entities/request/usuario.request.dart';
import 'package:switrans_2_0/src/util/constans/constants.dart';

class AuthPocketbaseApi {
  final Dio _dio;
  AuthPocketbaseApi(this._dio);

  Future<Response> getinfoUser(UsuarioRequest params) async {
    const url = '$kPocketBaseUrl/api/collections/usuario_nedimo/auth-with-password';
    final String jsonRequest = jsonEncode(params.toJson());
    final response = await _dio.post(url, data: jsonRequest);
    return response;
  }

  Future<Response> setUser(UsuarioRequest params) async {
    const url = '$kPocketBaseUrl/api/collections/usuario_nedimo/records';
    final response = await _dio.patch(
      '$url/${params.identity}',
      data: {"usunedPhoneId": params.token},
      options: Options(headers: {
        'Authorization': kTokenPocketBase, // Set the content-length.
      }),
    );
    return response;
  }

  Future<Response> getUsuarioByID(UsuarioRequest params) async {
    const url = '$kPocketBaseUrl/api/collections/usuario_nedimo/auth-with-password';
    final String jsonRequest = jsonEncode(params.toJson());
    final response = await _dio.post(url, data: jsonRequest);
    return response;
  }

  Future<Response> refreshToken(UsuarioRequest params) async {
    const url = '$kPocketBaseUrl/api/collections/usuario_nedimo/auth-refresh';
    final headers = {'Authorization': params.token};

    final response = await _dio.post(url, options: Options(headers: headers));
    return response;
  }
}
