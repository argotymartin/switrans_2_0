import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:postgres/postgres.dart';
import 'package:switrans_2_0/src/util/resources/backend/postgres/connection_postregsql.dart';

class FunctionsPostgresql {
  static Future<String> getMaxIdTable({required String table, required String key}) async {
    final Connection conn = await ConnectionPostgresql.onConnect();
    final String sql = "SELECT COALESCE(MAX($key), 1) + 1 FROM $table;";
    final Result result = await conn.execute(sql);
    result.first.first;
    await conn.close();
    return result.first.first.toString();
  }

  static Future<Response<dynamic>> executeQueryDB(String sql) async {
    if (kIsWeb) {
      throw Exception("Platafroma WEB no soportada para conexiones postgresql");
    }
    final String path = sql.toLowerCase().split("tb_")[1].split(" ")[0].trim();
    final Connection conn = await ConnectionPostgresql.onConnect();
    final Result result = await conn.execute(sql);

    final List<Map<String, dynamic>> resultMapList = result.map((ResultRow row) => row.toColumnMap()).toList();

    final Response<List<Map<String, dynamic>>> response = Response<List<Map<String, dynamic>>>(
      requestOptions: RequestOptions(path: path),
      data: resultMapList,
      statusCode: 200,
    );
    await conn.close();
    return response;
  }

  static Future<Response<dynamic>> exception(Exception serverException) async {
    return Response<dynamic>(
      requestOptions: RequestOptions(),
      statusCode: 502,
      statusMessage: serverException.toString(),
      data: serverException,
    );
  }
}
