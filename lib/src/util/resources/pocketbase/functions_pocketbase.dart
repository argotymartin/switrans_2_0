import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:switrans_2_0/src/util/constans/constants.dart';

class FunctionsPocketbase {
  static Future<int> getMaxCodigoCollection({required Dio dio, required String collection, required String field}) async {
    final String url = '$kPocketBaseUrl/api/collections/$collection/records';
    final Map<String, dynamic> queryParameters = <String, dynamic>{"sort": "-$field", "perPage": 1};
    final Response<String> response = await dio.get('$url', queryParameters: queryParameters);
    int codigo = 0;
    if (response.data != null && jsonDecode(response.data!)['items'].length > 0) {
      codigo = jsonDecode(response.data!)["items"][0]["$field"];
    }
    return codigo + 1;
  }

  static Future<String> getIdCollection({
    required Dio dio,
    required String collection,
    required String field,
    required int value,
  }) async {
    final String url = '$kPocketBaseUrl/api/collections/$collection/records';
    final Map<String, dynamic> queryParameters = <String, dynamic>{"filter": ('$field = $value')};
    final Response<String> response = await dio.get('$url', queryParameters: queryParameters);
    String id = "";
    if (response.data != null) {
      id = jsonDecode(response.data!)["items"][0]["id"];
    }
    return id;
  }
}
